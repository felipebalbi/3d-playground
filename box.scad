$fn = 60;

width = 90;
length = 90;
height = 90;
lid_height = 15;
thickness = 5;
radius = 3;


module box(w, l, h, r, t) {
  outter_corners = [
		    [0, 0, 0],
		    [w, 0, 0],
		    [0, l, 0],
		    [w, l, 0]
		    ];

  inner_corners = [
		   [t, t, t],
		   [w - t, t, t],
		   [t, l - t, t],
		   [w - t, l - t, t]
		   ];

  lip_corners = [
		 [t - 2, t - 2, h - t],
		 [w - t + 2, t - 2, h - t],
		 [t - 2, l - t + 2, h - t],
		 [w - t + 2, l - t + 2, h - t]
		 ];

  difference() {
    hull() {
      for (point = outter_corners) {
	translate(point) cylinder(r = r, h = h);
      }
    }

    hull() {
      for (point = inner_corners) {
	translate(point) cylinder(r = r, h = h);
      }
    }

    hull() {
      for (point = lip_corners) {
	translate(point) cylinder(r = r, h = t*2);
      }
    }
  }
}

module lid(w, l, h, r, t) {
  outter_corners = [
		    [0, 0, 0],
		    [w, 0, 0],
		    [0, l, 0],
		    [w, l, 0]
		    ];

  lip_outter_corners = [
		    [-1, -1, 0],
		    [w+1, -1, 0],
		    [-1, l+1, 0],
		    [w+1, l+1, 0]
		    ];
  lip_corners = [
		 [t - 2, t - 2, h - t],
		 [w - t + 2, t - 2, h - t],
		 [t - 2, l - t + 2, h - t],
		 [w - t + 2, l - t + 2, h - t]
		 ];

  translate([w / 2, l / 2, h * 0.95]) {
    cylinder(r = 4, h = 5);

    translate([0, 0, 4.9]) cylinder(r = 8, h = 2);

    difference() {
      translate([0, 0, 7]) sphere(r=8);
      translate([-10, -10, 0]) cube([20, 20, 5]);
    }
  }

  difference() {
    hull() {
      for (point = outter_corners) {
        translate(point) cylinder(r = r, h = h);
      }
    }

    translate([0, 0, -h * 0.75]) {
      difference() {
        hull() {
          for (point = lip_outter_corners) {
            translate(point) cylinder(r = r, h = h);
          }
        }

      translate([0, 0, -15])
        hull() {
        for (point = lip_corners) {
          translate(point) cylinder(r = r, h = h*2);
        }
      }
    }
  }    
}
}

box(width, length, height, radius, thickness);

translate([width/2, 0, height/2])
rotate([90, 0, 0])
linear_extrude(4)
text("#5", font="Roboto Condense:style=Bold", halign = "center",
     valign = "center", size = 15);

translate([width * 1.5, 0, 0])
  lid(width, length, lid_height, radius, thickness);
