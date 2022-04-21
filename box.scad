// SPDX-License-Identifier: CC-BY-NC-SA-4.0

/*
 * Copyright (c) 2022 - Felipe Balbi <felipe@balbi.sh>
 */

/* [Hidden] */
// Number Of Faces
$fn = 100;

// Box & Lid lip
lip_thickness = 2;

// Box & Lip slack
lip_slack = 0.25;

/* [Parameters] */
// Total Box Width (mm)
box_width = 22;

// Total Box Length (mm)
box_length = 13;

// Total Box Height (mm)
box_height = 71;

// Wall Thickness (mm)
wall_thickness = 2.5;

// Wall radius (mm)
wall_radius = 1;

// Box vs Lid Ratio
ratio = 4/5;

module box_walls(width, length, height, thickness, radius) {
  linear_extrude(height)
  difference() {
    minkowski() {
      total_width = width + 2 * thickness - radius;
      total_length = length + 2 * thickness - radius;
      square([total_width, total_length], center = true);
      circle(radius);
    }

    minkowski() {
      square([width - radius, length - radius], center = true);
      circle(radius);
    }
  }
}

module box_lip(width, length, thickness, radius, lip) {
  linear_extrude(2 * thickness + lip)
    minkowski() {
    square([width + lip - radius, length + lip - radius], center = true);
    circle(radius);
  }
}

module box_floor(width, length, thickness, radius) {
  linear_extrude(thickness)
    minkowski() {
    square([width + 2 * thickness - radius, length + 2 * thickness - radius], center = true);
    circle(radius);
  }
}

module box_body(width, length, height, thickness, radius) {
  union() {
    box_floor(width, length, thickness, radius);

    translate([0, 0, thickness])
      box_walls(width, length, height, thickness, radius);
  }
}

module box(width, length, height, thickness, radius, lip = lip_thickness) {
  difference() {
    box_body(width, length, height, thickness, radius);

    translate([0, 0, height - lip/2])
      box_lip(width, length, thickness, radius, lip);
  }
}

module lid(width, length, height, thickness, radius,
	   lip = lip_thickness, slack = lip_slack) {
  difference() {
    box_body(width, length, height, thickness, radius);
    
    translate([0, 0, height])
      box_walls(width + lip - slack, length + lip - slack, height + lip,
		thickness, radius);
  }
}

box(box_width, box_length, box_height * ratio,
    wall_thickness, wall_radius);

translate([box_width + 2 * wall_thickness + 2 * wall_radius + 2, 0, 0])
lid(box_width, box_length, box_height * (1 - ratio) + wall_thickness,
    wall_thickness, wall_radius);
