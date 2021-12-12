module die(size = 25, radius = 3, face_text) {
  difference() {
    translate([-size/2, -size/2, 0])
      hull() {
      for (p = [[0, 0, 0],
		[size, 0, 0],
		[0, size, 0],
		[0, 0, size],
		[size, size, 0],
		[size, 0, size],
		[0, size, size],
		[size, size, size]])
	translate(p) sphere(radius, $fn = 50);
    }

    translate([0, 0, size+1])
      rotate([0, 0, -45])
      linear_extrude(3)
      text(face_text[0], font="Roboto Condensed:style=Bold", size=4.5, halign="center", valign="center");

    translate([size/2+1, 0, size/2])
      rotate([90, -45, 90])
      linear_extrude(3)
      text(face_text[1], font="Roboto Condensed:style=Bold", size=4.5, halign="center", valign="center");

    translate([0, size/2, size/2])
      rotate([90, -45, 180])
      linear_extrude(3)
      text(face_text[2], font="Roboto Condensed:style=Bold", size=4.5, halign="center", valign="center");

    translate([0, -size/2, size/2])
      rotate([90, -45, 0])
      linear_extrude(3)
      text(face_text[3], font="Roboto Condensed:style=Bold", size=4.5, halign="center", valign="center");

    translate([-size/2-1, 0, size/2])
      rotate([90, -45, -90])
      linear_extrude(3)
      text(face_text[4], font="Roboto Condensed:style=Bold", size=4.5, halign="center", valign="center");

    translate([0, 0, -1])
      rotate([0, 180, -45])
      linear_extrude(3)
      text(face_text[5], font="Roboto Condensed:style=Bold", size=4.5, halign="center", valign="center");

  }
}

die(size = 25, radius = 3, face_text = ["ARMBAR",
					"TRIANGLE",
					"EZEQUIEL",
					"RNC",
					"OMOPLATA",
					"ANKLE LOCK"]);

translate([40, 0, 0])
die(size = 25, radius = 3, face_text = ["KNEE SLICE",
					"X PASS",
					"DOUBLE UNDER",
					"OVER UNDER",
					"FOLD PASS",
					"LEG DRAG"]);

translate([0, 40, 0])
die(size = 25, radius = 3, face_text = ["SHRIMP FWD",
					"SHRIMP BWD",
					"FRONT ROLL",
					"BACK ROLL",
					"STANDUP",
					"LEG DRAG"]);

translate([40, 40, 0])
die(size = 25, radius = 3, face_text = ["MOUNT",
					"SIDE",
					"HEADLOCK",
					"TURTLE",
					"BACK",
					"HALF GUARD"]);
