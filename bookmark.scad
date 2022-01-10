$fn=125;

width = 40;
length = 120;
height = 0.5;

radius = 3;
border = 4;

module bookmark() {
  difference() {
    translate([radius, radius, 0])
      minkowski() {
      cube([width - radius, length - radius, height]);
      cylinder(h=height, r=radius);
    }

    translate([(width+radius)/2, length - border, height/2]) {
      linear_extrude(height*2) {
	text("Just Keep Reading", font="Roboto:style=Bold", size=3, halign="center", valign="center");
      }
    }
  }
}

bookmark();
