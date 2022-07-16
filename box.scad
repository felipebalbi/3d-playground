// SPDX-License-Identifier: CC-BY-NC-SA-4.0

/*
 * Copyright (c) 2022 - Felipe Balbi <felipe@balbi.sh>
 */

/* [Hidden] */
// Number Of Faces
$fn = 100;

// Box & Lid lip
lip_thickness = 1;

// Box & Lip slack
lip_slack = 0.2;

/* [Parameters] */
// Total Box Width (mm)
box_width = 22;

// Total Box Length (mm)
box_length = 13;

// Total Box Height (mm)
box_height = 71;

// Wall Thickness (mm)
wall_thickness = 2;

// Wall radius (mm)
wall_radius = 1;

// Box vs Lid Ratio
ratio = 4/5;

module rounded_square(w, l, r) {
  points = [[-w/2	, -l/2],
	    [-w/2	, l/2],
	    [w/2	, -l/2],
	    [w/2	, l/2]];

  hull() {
    for (p = points)
      translate(p) circle(r);
  }
}

module box_walls(width, length, height, thickness, radius) {
  outter_width	= width + 2 * thickness - radius;
  outter_length = length + 2 * thickness - radius;

  inner_width	= width - radius;
  inner_length	= length - radius;

  linear_extrude(height)
  difference() {
    rounded_square(outter_width, outter_length, radius);
    rounded_square(inner_width, inner_length, radius);
  }
}

module box_lip(width, length, thickness, radius, lip) {
  total_width = width + lip - radius;
  total_length = length + lip - radius;

  linear_extrude(2 * thickness + lip)
    rounded_square(total_width, total_length, radius);
}

module box_floor(width, length, thickness, radius) {
  total_width = width + 2 * thickness - radius;
  total_length = length + 2 * thickness - radius;

  linear_extrude(thickness)
    rounded_square(total_width, total_length, radius);
}

module box_body(width, length, height, thickness, radius) {
  union() {
   %box_floor(width, length, thickness, radius);

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
