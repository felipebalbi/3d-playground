$fn = 50;

/* milimeters in one inch */
mm_per_inch = 25.4;

height = 100;

inner_diameter_eu = 30;
outer_diameter_eu = 35;

inner_diameter_us = 2.5 * mm_per_inch;
outer_diameter_us = 2.75 * mm_per_inch;

extra_outer_thickness = 2;

module adapter(height, outer_us, inner_us, outer_eu, inner_eu, extra)
{
  union() {
    /* bottom */
    difference() {
      cylinder(h=height/3, d=outer_us + extra);

      translate([0, 0, -1]) {
	cylinder(h=(height/3)+2, d=inner_us);
      }
    }

    /* top */
    translate([0, 0, 2*height/3])
      difference() {
	cylinder(h=height/3, d=outer_eu + extra);

	translate([0, 0, -1]) {
	  cylinder(h=(height/3)+2, d=inner_eu);
	}
    }

    /* size transition */
    translate([0, 0, height/3])
      difference() {
      cylinder(h=height/3, d1=outer_us + extra, d2=outer_eu + extra);

      translate([0, 0, 0])
	cylinder(h=(height/3), d1=inner_us, d2=inner_eu);
    }
  }
}

adapter(height, extra = extra_outer_thickness,
	outer_us = outer_diameter_us, inner_us = inner_diameter_us,
	outer_eu = outer_diameter_eu, inner_eu = inner_diameter_eu);
