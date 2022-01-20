width = 90;
length = 190;
height = 5;
border = 10;

stroke_length = 20;

difference() {
  union() {
    cube([width, length, height]);

    for (thickness = [0.1:0.1:3.0]) {
      translate([border, thickness*border*6, 1])
	cube([stroke_length, thickness, height*1.5]);

      translate([border*4, thickness*border*6, 1])
	linear_extrude(height = 6)
	text(str(thickness, " mm"), size = 4, halign = "center",
	     valign = "center");
    }
  }

  union() {
    for (thickness = [0.1:0.1:3.0]) {
      translate([border*5, thickness*border*6, 2])
	cube([stroke_length, thickness, height*2]);
    }


    translate([width - border, length/2, -1])
      rotate([0, 0, 90])
      linear_extrude(height = height*2)
      text("Detail Test", size=12, valign="center", halign="center");
  }
}
