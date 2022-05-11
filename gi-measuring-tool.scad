body_width = 35;
body_length = 25;
body_height = 150;

cutout_width = 35;
cutout_length = 13;
cutout_height = 70;

module bump(w) {
  rotate([0, 90, 0])
    cylinder(h=w, r=1, $fn=100);
}

module cutout(w, l, h) {
  cube([w, l, h]);
}

module body(w, l, h) {
  cube([w, l, h]);
}

module tool(bw, bl, bh, cw, cl, ch) {
  union() {
    difference() {
      body(bw, bl, bh);

      translate([-1, (bl - cl)/2, bh - ch])
	cutout(cw + 2, cl, ch + 2);
    }

    translate([0, 0, bh - 50])
      bump(bw);

    translate([0, bl, bh - 50])
      bump(bw);
  }
}

tool(body_width, body_length, body_height,
     cutout_width, cutout_length, cutout_height);
