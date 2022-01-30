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
lip_slack = 0;

/* [Parameters] */
// Box Width (mm)
box_width = 57;

// Box Length (mm)
box_length = 38;

// Box Height (mm)
box_height = 2*90/3;

// Lid Height (mm)
lid_height = 90/3;

// Wall Thickness (mm)
wall_thickness = 6;

// Wall radius (mm)
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

module box_lip(width, length, thickness, radius, lip) {
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

module box(width, length, height, thickness, radius, lip = lip_thickness) {
  difference() {
    box_body(width, length, height, thickness, radius);

    translate([0, 0, height - lip])
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

box(box_width, box_length, box_height,
    wall_thickness, wall_radius);

translate([box_width + 2 * wall_thickness + 2 * wall_radius + 2, 0, 0])
lid(box_width, box_length, lid_height, wall_thickness, wall_radius);
