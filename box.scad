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
box_width = 10;

// Total Box Depth (mm)
box_depth = 10;
// Total Box Height (mm)
box_height = 10;

// Wall Thickness (mm)
wall_thickness = 2;

// Wall radius (mm)
wall_radius = 1;

// Box vs Lid Ratio
ratio = 4/5;

module rounded_square(dims, r = 1) {
  function get_width(dims)	= dims[0];
  function get_depth(dims)	= dims[1];

  w = get_width(dims);
  d = get_depth(dims);

  points = [[-w/2	, -d/2],
	    [-w/2	,  d/2],
	    [ w/2	, -d/2],
	    [ w/2	,  d/2]];

  hull() {
    for (p = points) {
      translate(p) {
	circle(r);
      }
    }
  }
}

module box_walls(width, depth, height, thickness, radius) {
  outter_width	= width + 2 * thickness - radius;
  outter_depth = depth + 2 * thickness - radius;

  inner_width	= width - radius;
  inner_depth	= depth - radius;

  linear_extrude(height) {
    difference() {
      rounded_square([outter_width, outter_depth], r = radius);
      rounded_square([inner_width, inner_depth], r = radius);
    }
  }
}

module box_lip(width, depth, thickness, radius, lip) {
  total_width = width + 2 * lip - radius;
  total_depth = depth + 2 * lip - radius;

  linear_extrude(2 * thickness + lip) {
    rounded_square([total_width, total_depth], r = radius);
  }
}

module box_floor(width, depth, thickness, radius) {
  total_width = width + 2 * thickness - radius;
  total_depth = depth + 2 * thickness - radius;

  linear_extrude(thickness) {
    rounded_square([total_width, total_depth], r = radius);
  }
}

module box_body(width, depth, height, thickness, radius) {
  union() {
    box_floor(width, depth, thickness, radius);

    translate([0, 0, thickness]) {
      box_walls(width, depth, height, thickness, radius);
    }
  }
}

module box(width, depth, height, thickness, radius, lip = lip_thickness) {
  difference() {
    box_body(width, depth, height, thickness, radius);

    translate([0, 0, height - lip/2]) {
      box_lip(width, depth, thickness, radius, lip);
    }
  }
}

module lid(width, depth, height, thickness, radius,
	   lip = lip_thickness, slack = lip_slack) {
  difference() {
    box_body(width, depth, height, thickness, radius);
    
    translate([0, 0, height]) {
      box_walls(width + 2 * lip - slack, depth + 2 * lip - slack, height + lip,
		thickness, radius);
    }
  }
}

box(box_width, box_depth, box_height * ratio,
    wall_thickness, wall_radius);

translate([box_width + 2 * wall_thickness + 2 * wall_radius + 2, 0, 0]) {
  lid(box_width, box_depth, box_height * (1 - ratio) + wall_thickness,
      wall_thickness, wall_radius);
}
