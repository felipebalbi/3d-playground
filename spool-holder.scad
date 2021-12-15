$fn = 60;

/* Base */
length = 90;
width = 30;
height = 4;
border_radius = 3;

/* Abec 7 type bearing */
bearing_width = 4.2;
bearing_radius = 3.7;

module holder_base(width, length, height, radius) {
  base_corners = [
		  [0, 0, 0],
		  [width, 0, 0],
		  [0, length, 0],
		  [width, length, 0]
		  ];

  translate([-width/2, -length/2, 0])
    hull() {
    for (point = base_corners)
      translate(point) cylinder(r = radius, h = radius);
  }

  edge_corners = [
		  [0, 0, 0],
		  [0, length, 0],
		  [0, 0, height],
		  [0, length, height]
		  ];

  translate([-width/2, -length/2, 0])
    hull() {
      for (point = edge_corners) {
	translate(point) cylinder(h = height, r = radius);
      }
  }
}

module bearing_holder(width, radius, position) {
  translate(position)
  cylinder(r = radius, h = width);
}

difference() {
  union() {
    holder_base(width, length, height, border_radius);
    
    bearing_holder(bearing_width, bearing_radius,
		   [-width / 9, - 3 * length/8, border_radius * 0.9]);

    bearing_holder(bearing_width, bearing_radius,
		   [-width / 9, 3 * length/8, border_radius * 0.9]);
  }

  translate([25, 0, -5])
  cylinder(r=27, h = 20);
}

translate([-width / 4, 0, 1])
rotate([0, 0, -90])
linear_extrude(2.5)
text("#4", font="Roboto Condense:style=Bold", halign = "center",
     valign = "center", size = 5);
