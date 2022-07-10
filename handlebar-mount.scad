$fn = $preview ? 25 : 100;

/*
 * Thickness of material
 *
 * Must be thick as we want to countersink the M4 screws
 */
thickness = 8;

/* How much material to screw on */
wingspan = 12;

/* Diameter of handlebar */
handlebar_diameter = 24;

/* Diameter of outter cylinder */
handlebar_thickness = handlebar_diameter + 2 * thickness;

/* Minimum space between center of screw hole and edge of material */
margin = 5;

/* Height of extrusion */
extrusion_height = 12;

/* Tolerance */
tolerance = 0.2;

/* M4 Screw dimensions */
body_diameter = 3.9 + tolerance;
head_diameter = 7 + tolerance;
head_height = 4.1 + tolerance;
transition_diameter = body_diameter;

/* M4 Nut dimensions */
nut_height = 4.8 + tolerance;
nut_diameter = 7.8 + tolerance;

test = false;

radio_clip_thickness = 3.2;
radio_clip_radius = 4;
radio_clip_width = 26;
radio_clip_catch = 8;
radio_clip_length = extrusion_height + radio_clip_catch + radio_clip_thickness * 2;
radio_clip_height = test ? 10 : 21.6;

module screw(nut) {
  union() {
    cylinder(d = transition_diameter, h = thickness - head_height);

    translate([0, 0, thickness - head_height])
      cylinder(d = head_diameter, h = head_height, $fn = nut ? 6 : 50);
  }
}

module screw_hole(nut) {
  rotate([-90, 0, 0]) {
    screw(nut);
  }
}

module wing_corner_cutout(size, height) {
  translate([0, 0, -1])
  linear_extrude(height + 2)
  difference() {
    square([size / 2, size / 2]);
    circle(size / 2);
  }
}

module handlebar_cutout(width, length, radius) {
  rotate_extrude(angle = 180)
  translate([radius, 0, 0])
    square([width, length]);
}

module wing(width, length, height, nut) {
  difference() {
    cube([width, length, height]);

    /* Rounded corner */
    translate([width / 2, length / 3, 0])
      wing_corner_cutout(width, extrusion_height);
  }
}

module top_mount_bracket(thickness, height, radius) {
  translate([0, thickness/2 + radius - 2, height / 2])
    rotate([90, 0, 0])
    cylinder(h = radius, d = height);
}

module mount(top) {
  wing_position = (handlebar_diameter + handlebar_thickness) / 4;
  nut = !top;

  difference() {
    union() {
      handlebar_cutout(thickness, extrusion_height, handlebar_diameter/2);

      translate([wing_position, 0, 0])
	wing(wingspan, thickness, extrusion_height, nut);

      mirror([1, 0, 0])
	translate([wing_position, 0, 0])
	wing(wingspan, thickness, extrusion_height, nut);
      if (top) 
	top_mount_bracket(handlebar_thickness, extrusion_height, thickness * 2);
    }

    /* M4 Screw Holes */
    translate([wing_position +  wingspan / 2, 0, extrusion_height / 2])
      screw_hole(nut);

    mirror([1, 0, 0])
      translate([wing_position +  wingspan / 2, 0, extrusion_height / 2])
      screw_hole(nut);

    if (top) {
      rotate([90, 0, 0]) {
	translate([0, extrusion_height/2, 0]) {
          translate([0, 0, -(handlebar_thickness + extrusion_height + 1)]) {
	    /* screw body */
	    cylinder(h = 5 * thickness, d = transition_diameter);

	    /* screw head */
	    cylinder(h = head_height + 1, d = head_diameter);
	  }

	  /* nut */
	  translate([0, 0, - handlebar_diameter/2 - head_height]) {
	    cylinder(d = head_diameter, h = head_height + 1, $fn = 6);
	  }
        }
      }
    }
  }
}

module top_mount() {
  mount(true);
}

module bottom_mount() {
  mount(false);
}

module radio_clip_cutout(w, l, h, t, r) {
  points = [[r		, r],
	    [w - r	, r],
	    [r		, l - r],
	    [w - r	, l - r]];

  hull() {
    for (p = points) {
      translate(p) cylinder(h = h + 2, r = r);
    }
  }
}

module radio_mount(w, l, h, r, t) {
  width = w + 2 * t;
  length = l + 2 * t;

  echo(str("Dimensions: ", width, "mm X ", length, "mm"));
  
  points = [[r		, r],
	    [width - r	, r],
	    [r		, length - r],
	    [width - r	, length - r]];

  union() {
    difference() {
      /* Body */
      hull() {
	for (p = points) {
	  translate(p) cylinder(h = h, r = r);
	}
      }

      /* Radio Clip Cutout */
      translate([t, t, -1])
	radio_clip_cutout(radio_clip_width, radio_clip_catch, h, t, 2);

      /* Mounting Hole */
      translate([width / 2, -1, h / 2])
	rotate([-90, 0, 0]) {
	cylinder(d = head_diameter, h = head_height + t + radio_clip_catch + 1);
	cylinder(d = body_diameter, h = length);
      }

      translate([width / 2, length / 2 - r - extrusion_height + 1, h / 2 - (extrusion_height + 1) / 2])
	top_mount_bracket(handlebar_thickness, extrusion_height + 0.4, thickness * 2);

      /* Insertion relief */
      translate([t, t + 1, h - 2 * t])
	rotate([30, 0, 0])
	cube([w, 2 * t, h / 3]);
    }

    /* translate([t, t + radio_clip_catch, h - 1]) */
      /* cube([radio_clip_width, 2, 22]); */

    /* radio clip top catch */
    translate([t, t, h - 1]) {
      difference() {
	hull() {
	  cube([radio_clip_width, 10, 2]);

	  translate([0, 2, h + 2])
	    rotate([0, 90, 0])
	    cylinder(h = radio_clip_width, r = 2);

	  translate([0, 8, h + 2])
	    rotate([0, 90, 0])
	    cylinder(h = radio_clip_width, r = 2);
	}

	translate([-1, -2, -2])
	hull() {
	  cube([radio_clip_width + 2, 10, 2]);

	  translate([0, 2, h + 2])
	    rotate([0, 90, 0])
	    cylinder(h = radio_clip_width + 2, r = 2);

	  translate([0, 8, h + 2])
	    rotate([0, 90, 0])
	    cylinder(h = radio_clip_width + 2, r = 2);
	}
	/* translate([-1, -1, -1]) */
	/*   cube([radio_clip_width + 2, 8, h+1]); */
      }
    }

    /* union() { */
    /*   translate([t, t + 2 - 0.5, h + 22 - 1]) { */
    /* 	intersection() { */
    /* 	  cube([radio_clip_width, 4 + 5, t]); */

    /* 	  translate([0, (t + 5) / 2, 0]) */
    /* 	    rotate([0, 90, 0]) */
    /* 	    cylinder(h = radio_clip_width, d = 4 + 5); */
    /* 	} */
    /*   } */
    /* } */
  }
}

/* top_mount(); */

/* translate([0, -5, 0]) */
/* mirror([0, 1, 0]) */
/* bottom_mount(); */

/* translate([handlebar_thickness + thickness, 0, 0]) */
radio_mount(radio_clip_width, radio_clip_length, radio_clip_height,
	    radio_clip_radius, radio_clip_thickness);
