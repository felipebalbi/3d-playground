width = 60;
length = 60;
height = 35;
hole_diameter = 16;

module holder(w, l, h, d, name) {
  difference() {
    cube([w, l, h]);

    translate([w/2, 2*l/3, -1])
      cylinder(h=h*1.1, d=d);

    translate([w/2 - w/3, l/2 - l*0.55, -1])
    cube([2*w/3, l*1.1, h/4]);

    translate([w/2, l/4, h-1])
    linear_extrude(height=3)
      text(name, font="Roboto Condense:style=Bold",
	   halign="center", valign="center", size=10);
  }
}

for (conf = [[[0,0,0], "Dad"],
	     [[width, 0, 0], "Mom"],
	     [[2*width, 0, 0], "Logan"],
	     [[3*width, 0, 0], "Linda"]]) {
  translate(conf[0])
    holder(width, length, height, hole_diameter, conf[1]);
}
