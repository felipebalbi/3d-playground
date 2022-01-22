$fn = 50;

height = 100;

inner_diameter_eu = 30;
outer_diameter_eu = 35;

inner_diameter_us = 33.746;
outer_diameter_us = 39.84112;

extra_outer_thickness = 5;

module adapter(height, outer_us, inner_us, outer_eu, inner_eu, extra)
{
  union() {
    difference() {
      cylinder(h=height/2, d=outer_us + extra);
      translate([0, 0, -1])
	cylinder(h=(height/2)+2, d=inner_diameter_us);
    }

    translate([0, 0, height/2])
      difference() {
      cylinder(h=height/2, d=outer_eu + extra);
      translate([0, 0, -1])
	cylinder(h=(height/2)+2, d1=inner_us, d2=inner_eu);
    }

    translate([0, 0, height/2])
      difference() {
      cylinder(h=height/5, d1=outer_us + extra, d2=outer_eu + extra);
      translate([0, 0, -1])
	cylinder(h=(height/5)+2, d1=outer_eu + extra, d2=outer_eu + extra);
    }
  }
}

adapter(height, extra = extra_outer_thickness,
	outer_us = outer_diameter_us, inner_us = inner_diameter_us,
	outer_eu = outer_diameter_eu, inner_eu = inner_diameter_eu);
