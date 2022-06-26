$fn = $preview ? 10 : 100;

/*
 * Thickness of material
 *
 * Must be thick as we want to countersink the M3 screws
 */
thickness = 15;

/* How much material to screw on */
wingspan = 10;

/* Diameter of handlebar */
handlebar_diameter = 24;

/* Diameter of outter cylinder */
handlebar_thickness = handlebar_diameter + 2 * thickness;

/* Minimum space between center of screw hole and edge of material */
margin = 5;

/* Height of extrusion */
extrusion_height = 15;

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

module wing_rounded_edge() {
  difference() {
    circle(r = thickness);

    translate([0, -thickness/2 - 2.5])
      square([2 * thickness, thickness + 5], center = true);

    translate([-thickness/2, thickness/2])
      square(thickness, center = true);
  }
}

module wing() {
  hull() {
    square(thickness);

    translate([wingspan, 0]) {
      wing_rounded_edge();
    }
  }
}

module screw_base() {
  translate([(handlebar_thickness + handlebar_diameter)/4, 0 ,0]) {
    wing();
  }

  mirror([1, 0, 0]) {
    translate([(handlebar_thickness + handlebar_diameter)/4, 0 ,0]) {
      wing();
    }
  }
}

module handle_cutout() {
  difference() {
    circle(d = handlebar_thickness);
    circle(d = handlebar_diameter);

    mirror([0, 1, 0])
      translate([-handlebar_thickness, 0])
	square(2 * handlebar_thickness);
  }
}

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

module handlebar_back(nut) {
  difference() {
    linear_extrude(extrusion_height) {
      union() {
	handle_cutout();
	screw_base();
      }
    }

    translate([wingspan + handlebar_diameter/2 + thickness/2,
	       0,
	       extrusion_height/2]) {
      screw_hole(nut);
    }

  translate([-(wingspan + handlebar_diameter/2 + thickness/2),
	     0,
	     extrusion_height/2])
 {
      screw_hole(nut);
    }
  }
}

module handlebar_mount(nut) {
  handlebar_back(nut);
}

handlebar_mount(nut = true);
