module face(string, position, rotation) {
  translate(position)
    rotate(rotation)
    linear_extrude(2)
    text(string, font="Roboto Condensed:style=Bold", size=4, halign="center", valign="center");
}

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

    face(face_text[0], [0, 0, size + radius/2], [0, 0, -45]);
    face(face_text[1], [size/2 + radius/2, 0, size/2], [90, -45, 90]);
    face(face_text[2], [0, size/2 + radius/2, size/2], [90, -45, 180]);
    face(face_text[3], [0, -size/2 - radius/2, size/2], [90, -45, 0]);
    face(face_text[4], [-size/2 - radius/2, 0, size/2], [90, -45, -90]);
    face(face_text[5], [0, 0, -radius/2], [0, 180, -45]);
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
