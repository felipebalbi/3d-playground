abdomen_size = 120;
neck_size = abdomen_size * 1.25;
paw_size = (abdomen_size/2) * 0.8;

module neck(size) {
  union() {
    translate([size/2, 0, 0])
      rotate([0, 45, 0])
      cube([size, size, size/5], center=true);

    translate([-size/2, 0, 0])
      rotate([0, -45, 0])
      cube([size, size, size/5], center=true);
  }

  rotate([0, 0, 90])
  union() {
    translate([size/2, 0, 0])
      rotate([0, 45, 0])
      cube([size, size, size/5], center=true);

    translate([-size/2, 0, 0])
      rotate([0, -45, 0])
      cube([size, size, size/5], center=true);
  }
}

module abdomen(size, neck_size) {
  difference() {
    translate([0, 0, (size*0.75/2) + size*0.2])
      cube([size, size, size*0.75], center=true);

    translate([0, 0, abdomen_size*0.85])
      neck(neck_size);
  }
}

module paw(size) {
  union() {
    translate([0, 0, size/2])
      cube([size, size, size], center=true);

    translate([size*0.1, 0, size/10])
      cube([size, size, size/5], center=true);
  }
}

module tail(size) {
  rotate([0, -35, 0])
  union() {
    translate([-size/7, 0, size/10])
      linear_extrude(height=75, scale=1.5)
      square(size/5, center=true);

    translate([-size/7, 0, size/10])
      cube([size/5, size/5, size], center=true);
  }
}

module body(abdomen_size, neck_size, paw_size) {
  difference() {
    union() {
      abdomen(abdomen_size, neck_size);

      for (p = [
		[abdomen_size/2 - paw_size/2, abdomen_size/2 - paw_size/2, 0],
		[abdomen_size/2 - paw_size/2, -abdomen_size/2 + paw_size/2, 0],
		[-abdomen_size/2 + paw_size/2, abdomen_size/2 - paw_size/2, 0],
		[-abdomen_size/2 + paw_size/2, -abdomen_size/2 + paw_size/2, 0]
		]) {
        translate(p)
	  paw(paw_size);
      }

      translate([-13*abdomen_size/27, 0, 7*abdomen_size/9])
	tail(abdomen_size);
    }

    translate([0, 0, abdomen_size*0.75])
      cube([2*abdomen_size/3, 2*abdomen_size/3, abdomen_size], center=true);
  }
}

module ear(size) {
  rotate([0, 90, 0])
  linear_extrude(height = size)
    polygon([[0, 0],
	     [size/4, 0],
	     [size/4, size/3],
	     [0, 0]]);
}

module whisker(p, w, l, h) {
  translate(p)
    cube([w, l, h], center=true);
}

module eye(p, w, l, h) {
  translate(p)
    cube([w, l, h], center=true);
}

module face_half(p, size) {
  translate(p) {
    /* eye */
    eye([0, -size/5.5, size/5], size/35, size/15, size/8);

    /* Top whisker */
    whisker([0, 0, size/15], size/35, size/4, size/45);

    /* bottom whisker */
    whisker([0, 0, size/30], size/35, size/4, size/45);
  }
}

module face(size) {
  face_half([size/2, size/4, -size*0.65], size);

  mirror([0, 1, 0])
    face_half([size/2, size/4, -size*0.65], size);

  rotate([0, 90, 0])
    translate([size*0.60, 0, size*0.49])
    cylinder(h = size, r=5, $fn=3);
}

module head(size, neck_size) {
  difference() {
    union() {
      mirror([0, 0, 1])
	abdomen(size, neck_size);

      translate([-size/2, -size/2, 0])
	ear(abdomen_size);

      mirror([0, 1, 0])
	translate([-size/2, -size/2, 0])
	ear(abdomen_size);

      /* box lip */
      translate([0, 0, -abdomen_size*0.87]) {
	difference() {
	  cube([2*abdomen_size/3 - 1, 2*abdomen_size/3 - 1, abdomen_size/4], center=true);

	  translate([0, 0, -1])
	    cube([2*abdomen_size/3 - 5, 2*abdomen_size/3 - 5, abdomen_size/4 + 2], center=true);
        }
      }
    }

    face(size);
  }
}

body(abdomen_size, neck_size, paw_size);

translate([0, 0, abdomen_size*2])
head(abdomen_size, neck_size);

