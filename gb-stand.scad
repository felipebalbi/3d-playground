// SPDX-License-Identifier: CC-BY-NC-SA-4.0

/*
 * Copyright (c) 2022 - Felipe Balbi <felipe@balbi.sh>
 */

/* [Hidden] */
$fn = 50;

game_width = 64;
game_length = 13;
game_height = 72;

gbc_width = 78;
gbc_length = 30;

height_ratio = 4/5;
wall_thickness = 3;

/* [Slider] */
// How many rows
rows = 6; // [1:10]
// Number of columns
cols = 2; // [2:10]

module game_cutout(w, l, h) {
  points = [[0, 0],
	    [w, 0],
	    [0, l],
	    [w, l]];

  hull() {
    for (p = points) {
      translate(p)
	cylinder(r = 1, h = h);
    }
  }
}

module games_cutout(rows, cols, gcw, gcl, gch, thickness) {
  for (j = [0:1:rows - 1]) {
    for (i = [0:1:cols - 1]) {
      translate([thickness + (gcw * i) + (i * thickness * 2),
		 thickness + (gcl * j) + (j * thickness * 2),
		 thickness])
	game_cutout(gcw, gcl, gch);
    }
  }
}

module gameboy_color_cutout(gbcw, gbcl, gbch)
{
  points = [[0, 0],
	    [gbcw, 0],
	    [0, gbcl],
	    [gbcw, gbcl]];

  hull() {
    for (p = points) {
      translate(p)
	cylinder(r = 1, h = gbch);
    }
  }
}

module game_stand(rows, cols,
		  gbcw, gbcl, /* game boy color size */
		  gcw, gcl, gch, /* game card size */
		  thickness, ratio) {
  width = (gcw + 2 * thickness) * cols;
  length = (gcl + 2 * thickness) * rows + gbcl + 2 * thickness;

  echo(str("Dimensions: ", width, "mm x ", length, "mm x ", gch * ratio, "mm"));

  difference() {
    points = [[0, 0],
	      [width, 0],
	      [0, length],
	      [width, length]];

    hull() {
      for (p = points) {
	translate(p)
	  cylinder(r = 1, h = gch * ratio);
      }
    }

    games_cutout(rows, cols, gcw, gcl, gch, thickness);

    translate([width / 2 - gbcw / 2, length - gbcl - thickness, thickness])
    gameboy_color_cutout(gbcw, gbcl, gch);
  }
}

game_stand(rows, cols,
	   gbc_width, gbc_length,
	   game_width, game_length, game_height,
	   wall_thickness, height_ratio);
