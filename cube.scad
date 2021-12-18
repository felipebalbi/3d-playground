$fn = 50;
size = 20;

difference(size) {
  cube(size);

  translate([size/2, 0.5, size/2])
    rotate([90, 0, 0])
    linear_extrude(3)
    text("X", font="Roboto Condense:style=Bold", halign = "center",
	 valign = "center", size = size*0.8);

  translate([size - 0.5, size/2, size/2])
    rotate([90, 0, 90])
    linear_extrude(3)
    text("Y", font="Roboto Condense:style=Bold", halign = "center",
	 valign = "center", size = size*0.8);

  translate([size/2, size/2, size - 0.5])
    linear_extrude(3)
    text("Z", font="Roboto Condense:style=Bold", halign = "center",
	 valign = "center", size = size*0.8);

  translate([0.5, size/2, size/2])
    rotate([90, 0, -90])
    linear_extrude(3)
    text("#6", font="Roboto Condense:style=Bold", halign = "center",
	 valign = "center", size = size*0.6);
}

