$fn = 100;

width = 45;
length = 60;
height = 35;
hole_diameter = 12.5;
hole_height = 9;

module holder(w, l, h, d, hh, name) {
  difference() {
    cube([w, l, h]);

    translate([w/2, 2*l/3, h-hh+0.2])
      cylinder(h=hh, d=d);

    translate([w/2, 2*l/3, -1])
      cylinder(h=h, d=hh-0.5);

    translate([w/2 - w/3, l/2 - l*0.55, -1])
    cube([2*w/3, l*1.1, h/4]);

    translate([w/2, l/5, h-2])
    linear_extrude(height=3)
      text(name, font="Roboto:style=Bold",
	   halign="center", size=10);
  }
}

for (conf = [[[0,0,0], "1"],
	     [[width, 0, 0], "2"],
	     [[2*width, 0, 0], "3"],
	     [[3*width, 0, 0], "4"]]) {
  translate(conf[0])
    holder(width, length, height, hole_diameter, hole_height, conf[1]);
}
