$fn = $preview ? 25 : 100;

/*
 * Thickness of material
 *
 * Must be thick as we want to countersink the M3 screws
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

/*
 * M3 Screw dimensions
 *
 * Source: https://www.engineersedge.com/hardware/_metric_socket_head_cap_screws_14054.htm
 */
body_diameter = 3 + tolerance;
head_diameter = 5.5 + tolerance;
head_height = 3 + tolerance;
transition_diameter = 3.6 + tolerance;

/* M3 Nut dimensions
 *
 * Source: https://amesweb.info/Fasteners/Nut/Metric-Hex-Nut-Sizes-Dimensions-Chart.aspx
 */
nut_height = 2.4 + tolerance;
nut_diameter = 6 + tolerance;

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

    /* M3 Screw Hole */
    translate([width / 2, 0, height / 2])
      screw_hole(nut);
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

module radio_mount(w, l, h, r) {
  points = [[r, r],
	    [w - r, r],
	    [r, l - r],
	    [w - r , l - r]];

  difference() {
    hull() {
      for (p = points) {
	translate(p) cylinder(h = h, r = r);
      }
    }

    translate([w/2, l/2, -1]) {
      cylinder(d = extrusion_height + tolerance, h = h * 0.5);
      cylinder(d = transition_diameter, h = h * 1.5);

      translate([0, 0, h - head_diameter])
        cylinder(d = head_diameter, h = h/2);
    }

    hull() {
      translate([4, 4, -1]) {
	cylinder(r = 2, h = h * 1.5);

	translate([0, l - 8, 0])
	  cylinder(r = 2, h = h * 1.5);
      }
    }
  }
}

top_mount();

translate([0, -5, 0])
mirror([0, 1, 0])
bottom_mount();

translate([handlebar_thickness + thickness, 0, 0])
radio_mount(handlebar_thickness/2, handlebar_thickness - 5, 70, 2);
