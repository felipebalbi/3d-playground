$fn = 60;

module fillet(height, radius) {
  cylinder(h = height, r = radius);

  rotate_extrude()
  translate([radius * 3, radius * 2, 0])
    rotate([0, 0, 180])
    difference() {
      square(radius * 2);
      circle(radius * 2);
  }
}

module top(height, radius) {
  difference() {
      sphere(r = height);
      translate([0, 0, -height])
      cube(height * 2, center = true);
  }
}

module knob(height, radius) {
  fillet(height, radius);

  translate([0, 0, height])
    top(height, radius);

  translate([0, 0, height])
  rotate([180, 0, 0])
    fillet(height, radius);
}

knob(10, 3);
