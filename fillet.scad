$fn = 100;

module fillet(radius) {
  difference() {
    square(radius);

    translate([radius, radius, 0])
      circle(r = radius);
  }
}

module circular_fillet(rod_radius, radius) {
  rotate_extrude(angle = 360)
  translate([rod_radius, 0, 0])
    fillet(radius);
}

module linear_fillet(width, radius) {
  rotate([90, 0, 0])
    linear_extrude(height = width, center = true)
    fillet(radius);
}

module rectangular_fillet(width, length, radius) {
  module rectangular_half(width, length, radius) {
    translate([0, width / 2, 0])
      linear_fillet(width, radius);

    translate([length / 2, 0, 0])
      rotate([0, 0, 90])
      linear_fillet(length, radius);
  }

  rectangular_half(width, length, radius);

  translate([length, width, 0])
  rotate([0, 0, 180])
    rectangular_half(width, length, radius);
}

rectangular_fillet(5, 10, 1);
