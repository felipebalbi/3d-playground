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
      rotate([0, 0, 45])
      linear_extrude(3)
      text(face_text[0], font="Roboto Condensed:style=Bold", size=4.5, halign="center", valign="center");

    translate([size/2+1, 0, size/2])
      rotate([90, -45, 90])
      linear_extrude(3)
      text(face_text[1], font="Roboto Condensed:style=Bold", size=4.5, halign="center", valign="center");

    translate([0, size/2, size/2])
      rotate([90, 45, 180])
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

die(size = 25, radius = 3, face_text = ["Armbar",
					"Triangle",
					"Ezequiel",
					"RNC",
					"Omoplata",
					"Ankle Lock"]);

translate([40, 0, 0])
die(size = 25, radius = 3, face_text = ["Knee Slice",
					"X Pass",
					"Double Under",
					"Over Under",
					"Fold Pass",
					"Leg Drag"]);
