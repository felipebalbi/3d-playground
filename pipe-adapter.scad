/* [Hidden] */
// Number Of Faces
$fn = 200;

// milimeters in one inch
mm_per_inch = 25.4;

/* [Parameters] */
// Total height of the part (in mm)
Height = 100;

// US Standard Pipe Outer Diameter (in inches)
Diameter_US = 2.5;

// EU Standard Pipe Outer Diameter (in mm)
Diameter_EU = 35;

// Thickness Of The Wall (in mm)
Wall_Thickness = 5;

// Tolerance (in mm)
Tolerance = 0;

module adapter(height=100, dia_us=2.5, dia_eu=35, thickness=5, tolerance=0)
{
  out_us = (dia_us * mm_per_inch) + thickness;
  in_us = (dia_us * mm_per_inch) + tolerance;

  out_eu = dia_eu + thickness;
  in_eu = dia_eu + tolerance;

  union() {
    /* bottom */
    difference() {
      cylinder(h=height/3, d=out_us);

      translate([0, 0, -1]) {
	cylinder(h=(height/3)+2, d=in_us);
      }
    }

    /* top */
    translate([0, 0, 2*height/3])
      difference() {
	cylinder(h=height/3, d=out_eu);

	translate([0, 0, -1]) {
	  cylinder(h=(height/3)+2, d=in_eu);
	}
    }

    /* size transition */
    translate([0, 0, height/3])
      difference() {
      cylinder(h=height/3, d1=out_us, d2=out_eu);

      union() {
	cylinder(h=(height/3), d1=in_us, d2=in_eu);

	translate([0, 0, -0.99])
	  cylinder(h=1, d=in_us);

	translate([0, 0, (height/3)-0.01])
	  cylinder(h=1, d=in_eu);
      }
    }
  }
}

adapter(Height, dia_us = Diameter_US, dia_eu = Diameter_EU,
	thickness = Wall_Thickness, tolerance = Tolerance);
