$fn		= 50;

tolerance	= 0.4;

width		= 35 - tolerance;
length		= 35 - tolerance;
thickness	= 4.1 - tolerance;
corner_radius	= 0.4;

lip_height	= thickness + 1;

notch_width	= 3;
notch_length	= 6.4;

points = [[0						, 0],
	  [width - 2 * corner_radius			, 0],
	  [width - 2 * corner_radius			, (length - 2 * corner_radius) / 2],
	  [notch_width - 2 * corner_radius		, (length - 2 * corner_radius) / 2],
	  [notch_width - 2 * corner_radius		, notch_length - 2 * corner_radius],
	  [0						, notch_length - 2 * corner_radius],
	  [0						, 0]];

module cartridge_cover(points) {
  union() {
    minkowski() {
      linear_extrude(thickness / 2)
	polygon(points = points);

      cylinder(h = thickness / 2, r = corner_radius);
    }


    hull() {
      lip = [[0				, 0],
	     [width - 2 * corner_radius	, 0],
	     [0				, 1],
	     [width - 2 * corner_radius	, 1]];

      for (p = lip) {
	translate(p) cylinder(h = lip_height, r = corner_radius);
      }
    }
  }
}

cartridge_cover(points);
