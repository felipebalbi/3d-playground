$fn = 60;

box_width = 57;
box_length = 38;
box_height = 2*88/3;

lid_height = 35;
lip_thickness = 2;

wall_thickness = 6;
wall_radius = 3;

module box_walls(width, length, height, thickness, radius) {
  linear_extrude(height)
  difference() {
    minkowski() {
      square([width + thickness, length + thickness], center = true);
      circle(radius);
    }

    minkowski() {
      square([width, length], center = true);
      circle(radius);
    }
  }
}

module box_lip(width, length, thickness, radius, lip = lip_thickness) {
  linear_extrude(thickness + lip)
    minkowski() {
    square([width + lip, length + lip], center = true);
    circle(radius);
  }
}

module box_floor(width, length, thickness, radius) {
  linear_extrude(thickness)
    minkowski() {
    square([width + thickness, length + thickness], center = true);
    circle(radius);
  }
}

module box_body(width, length, height, thickness, radius) {
  union() {
    translate([0, 0, thickness])
      box_walls(width, length, height, thickness, radius);

    box_floor(width, length, thickness, radius);
  }
}

module box(width, length, height, thickness, radius) {
  difference() {
    box_body(width, length, height, thickness, radius);

    translate([0, 0, height])
      box_lip(width, length, thickness, radius);
  }
}

module lid(width, length, height, thickness, radius,
	   lip = lip_thickness) {
  difference() {
    box_body(width, length, height, thickness, radius);
    
    translate([0, 0, height])
      box_walls(width + lip, length + lip, height + lip,
		thickness, radius);
  }
}

box(box_width, box_length, box_height,
    wall_thickness, wall_radius);

translate([box_width * 2, 0, 0])
lid(box_width, box_length, lid_height, wall_thickness, wall_radius);
