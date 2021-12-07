width = 15;
depth = 25;
height = 15;

cut_width = 5;
cut_depth = 12.5;
cut_height = 20;

module usb_holder(x=0, y=0) {
  translate([x, y, 0]) {
    difference() {
      translate([-width/2, -depth/2, 0]) {
	minkowski() {
	  cube([width, depth, height], center = true);
	  translate([width/2, depth/2, -height/2]) {
	    cylinder(1, $fn=50);
	  }
	}
      }

      translate([0, 0, 2]) {
          cube([cut_width, cut_depth, cut_height], center = true);
      }
    }
  }
}


for (i = [0:0])
  usb_holder(width * i);

translate([-width/4, -depth/2, -3*height/4])
rotate(a = [-270, 0, 0])
linear_extrude(3, center=true)
text("#1", size=6);
