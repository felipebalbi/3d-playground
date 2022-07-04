// SPDX-License-Identifier: CC-BY-NC-SA-4.0

/*
 * Copyright (c) 2022 - Felipe Balbi <felipe@balbi.sh>
 */

$fn = $preview ? 25 : 100;

aa_diameter = 14.2;
aa_height = 44.4;

aaa_diameter = 10.2;
aaa_height = 44.4;

ratio = 4/5;
tolerance = 1.2;

wall_thickness = 2;
rows = 8;
cols = 2;

corner_radius = 2;

module battery_cutout(height, diameter) {
  cylinder(h = height, d = diameter);
}

module center_cutout(width, length, height)
{
  cube([width, length, height]);
}

module battery_matrix(width, height, diameter, rows, cols) {
  for (i = [0:rows-1]) {
    for (j = [0:(cols/2)]) {
      radius = diameter / 2;
      x = wall_thickness + radius + i * diameter;
      y = wall_thickness + radius + j * (diameter + wall_thickness);
      z = wall_thickness;

      translate([x, y, z])
	battery_cutout(height, diameter);
    }
  }

  for (j = [0:(cols/2)]) {
    center_cutout_width = width - diameter - 2 * wall_thickness;
    center_cutout_length = diameter / 2;
    center_cutout_x = wall_thickness + diameter / 2;
    center_cutout_y = wall_thickness + diameter / 2 - center_cutout_length / 2
      + j * (diameter + wall_thickness);

    translate([center_cutout_x, center_cutout_y, wall_thickness])
      center_cutout(center_cutout_width, center_cutout_length, height);
  }
}

module body(is_aa = true) {
  battery_diameter = tolerance + (is_aa ? aa_diameter : aaa_diameter);
  battery_height = is_aa ? aa_height : aaa_height;

  width = rows * battery_diameter + 2 * wall_thickness;
  length = cols * (battery_diameter + wall_thickness) + wall_thickness;

  difference() {
    points = [[corner_radius, corner_radius],
	      [width - corner_radius, corner_radius],
	      [corner_radius, length - corner_radius],
	      [width - corner_radius, length - corner_radius]];

    hull() {
      for (p = points) {
	translate(p) cylinder(h = battery_height * ratio, r = corner_radius);
      }
    }

    battery_matrix(width, battery_height, battery_diameter, rows, cols);

    translate([width / 2, wall_thickness/4, battery_height / 2 * ratio])
      rotate([90, 0, 0])
      linear_extrude(wall_thickness)
      text("Charged",
	   font="Roboto Condensed:style=Bold",
	   halign="center",
	   valign="center",
	   size=is_aa ? 15 : 11);

    translate([width / 2, length - wall_thickness/4, battery_height / 2 * ratio])
      rotate([90, 0, 180])
      linear_extrude(wall_thickness)
      text("Discharged",
	   font="Roboto Condensed:style=Bold",
	   halign="center",
	   valign="center",
	   size=is_aa ? 15 : 11);
  }
}

body(is_aa = false);
