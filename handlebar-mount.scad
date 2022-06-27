$fn = $preview ? 25 : 100;

/*
 * Thickness of material
 *
 * Must be thick as we want to countersink the M3 screws
 */
thickness = 15;

/* How much material to screw on */
wingspan = 20;

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

module mount(nut) {
  wing_position = (handlebar_diameter + handlebar_thickness) / 4;

  handlebar_cutout(thickness, extrusion_height, handlebar_diameter/2);

  translate([wing_position, 0, 0])
    wing(wingspan, thickness, extrusion_height, nut);

  mirror([1, 0, 0])
  translate([wing_position, 0, 0])
    wing(wingspan, thickness, extrusion_height, nut);
}

mount(false);
