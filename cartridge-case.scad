// SPDX-License-Identifier: CC-BY-NC-SA-4.0

/*
 * Copyright (c) 2022 - Felipe Balbi <felipe@balbi.sh>
 */

/* [Parameters] */
// Number of rows
rows			= 10;

// Number of columns
columns			= 1;

// Cartridge Type
type			= "NES"; // [ NES, SNES, N64, DS/2DS/3DS, Switch, GameBoy, PSP/UMD, VIC20, C64, Atari 800, Atari 2600, Atari 5200, SD, microSD, Memory Stick Duo ]

/* [Hidden] */
// Number of faces
$fn			= 50;

// Thickness of all walls
material_thickness	= 2;

// Extra slack/tolerance
material_tolerance	= 0.4;

// Corner Radius
material_radius		= 1;

/*		       NAME		Width	Depth	Height	Ratio */
/* Nintendo */
nes_cartridge	    = ["NES",		119.8,	16.7,	134.5,	3/5];
snes_cartridge	    = ["SNES",		135,	20,	86,	3/5];
n64_cartridge	    = ["N64",		116,	18,	75,	3/5];
3ds_cartridge	    = ["DS/2DS/3DS",	32.9,	3.7,	35,	3/5];
switch_cartridge    = ["Switch",	21.4,	3.4,	31.2,	1/2];
gb_cartridge        = ["GameBoy",	57,	7.7,	65,	1/3];

/* Sony */
psp_cartridge	    = ["PSP",		64,	4.2,	65,	3/5];

/* Commodore */
vic20_cartridge	    = ["VIC20",		139,	17,	79,	3/5];
c64_cartridge	    = ["C64",		68.5,	20.1,	88.9,	3/5];

/* Atari */
atari800_cartridge  = ["Atari 800",	68,	21,	77,	3/5];
atari2600_cartridge = ["Atari 2600",	81,	19,	87,	3/5];
atari5200_cartridge = ["Atari 5200",	104,	17,	112,	3/5];

/* Memory Cards */
sd_cartridge        = ["SD",		24,	2.2,	32,	3/4];
microsd_cartridge   = ["microSD",	11,	1,	15,	4/5];
msd_cartridge	    = ["MSD",		20,	1.6,	30.8,	4/5];

function cartridge_name(cart)		= cart[0];
function cartridge_width(cart)		= cart[1];
function cartridge_depth(cart)		= cart[2];
function cartridge_height(cart)		= cart[3];
function cartridge_ratio(cart)		= cart[4];

module rounded_box(width, depth, height, radius) {
  points = [[radius, radius],
	    [width - radius, radius],
	    [radius, depth - radius],
	    [width - radius, depth - radius]];

  hull() {
    for (p = points) {
      translate(p) cylinder(h = height, r = radius);
    }
  }
}

module cartridge_array(rows, cols, cart) {
  width		= cartridge_width(cart);
  depth		= cartridge_depth(cart);
  height	= cartridge_height(cart);

  for (i = [0:1:cols - 1]) {
    for (j = [0:1:rows - 1]) {
      x = (2 * material_thickness + width + material_tolerance) * i +
	material_thickness;

      y = (2 * material_thickness + depth + material_tolerance) * j +
	material_thickness;

      translate([x, y, material_thickness])
	children();
    }
  }
}

module cartridge_slot(cart) {
  width		= cartridge_width(cart);
  depth		= cartridge_depth(cart);
  height	= cartridge_height(cart);

  total_width	= width + 2 * material_tolerance;
  total_depth	= depth + 2 * material_tolerance;
  total_height	= height;

  rounded_box(total_width, total_depth, total_height, material_radius);
}

module cartridge_case_base(rows, cols, cart) {
  width		= cartridge_width(cart);
  depth		= cartridge_depth(cart);
  height	= cartridge_height(cart);
  ratio		= cartridge_ratio(cart);

  total_width	= cols * (width + material_tolerance + 2 * material_thickness);
  total_depth	= rows * (depth + material_tolerance + 2 * material_thickness);
  total_height	= height * ratio;

  echo(str("Total Dimensions: ", total_width, " mm ✕ ", total_depth, " mm ✕ ",
	   total_height, " mm."));

  rounded_box(total_width, total_depth, total_height, material_radius);
}

module cartridge_case(rows, cols, cart) {
  name		= cartridge_name(cart);
  width		= cartridge_width(cart);
  depth		= cartridge_depth(cart);
  height	= cartridge_height(cart);

  echo(str("Generating case for ", name, " Cartridge Type"));

  difference() {
    cartridge_case_base(rows, columns, cart);

    cartridge_array(rows, cols, cart)
      cartridge_slot(cart);
  }
}

if (type == "NES")
  cartridge_case(rows, columns, nes_cartridge);
else if (type == "SNES")
  cartridge_case(rows, columns, snes_cartridge);
else if (type == "N64")
  cartridge_case(rows, columns, n64_cartridge);
else if (type == "DS/2DS/3DS")
  cartridge_case(rows, columns, 3ds_cartridge);
else if (type == "Switch")
  cartridge_case(rows, columns, switch_cartridge);
else if (type == "GameBoy")
  cartridge_case(rows, columns, gb_cartridge);
else if (type == "PSP/UMD")
  cartridge_case(rows, columns, psp_cartridge);
else if (type == "VIC20")
  cartridge_case(rows, columns, vic20_cartridge);
else if (type == "C64")
  cartridge_case(rows, columns, c64_cartridge);
else if (type == "Atari 800")
  cartridge_case(rows, columns, atari800_cartridge);
else if (type == "Atari 2600")
  cartridge_case(rows, columns, atari2600_cartridge);
else if (type == "Atari 5200")
  cartridge_case(rows, columns, atari5200_cartridge);
else if (type == "SD")
  cartridge_case(rows, columns, sd_cartridge);
else if (type == "microSD")
  cartridge_case(rows, columns, microsd_cartridge);
else if (type == "Memory Stick Duo")
  cartridge_case(rows, columns, msd_cartridge);
