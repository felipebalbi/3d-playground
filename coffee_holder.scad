module box_sleeve(width, depth, height, thickness, radius) {
  translate([radius, radius, 0]) {
    difference() {
      hull() {
	for (p = [[0, 0, 0],
		  [width + thickness / 2, 0, 0],
		  [0, depth + thickness / 2, 0],
		  [width + thickness / 2, depth + thickness / 2, 0]]) {
	  translate(p) {
	    cylinder(h = height, r = radius, $fn=60);
	  }
	}
      }

      hull() {
	for (p = [[thickness/2, thickness/2, -10],
		  [width, thickness/2, -10],
		  [thickness/2, depth, -10],
		  [width, depth, -10]]) {
	  translate(p) {
	    cylinder(h = height * 1.5, r = radius, $fn=60);
	  }
	}
      }

      translate([3 * width / 4, depth / 4, -10]) {
        cube([width / 2, depth / 2, height * 1.5]);
      }

      translate([3 * width / 4, thickness / 2, -1]) {
	minkowski() {
          cube([width - thickness / 2, depth - thickness/2, height / 2]);
	  sphere(thickness / 2, $fn = 60);
        }
      }
    }
  }
}

module shelf(width, depth, height) {
  translate([height, height, 0])
  hull() {
    for (p = [[0, 0, 0],
	      [width + height / 2, 0, 0],
	      [0, depth + height / 2, 0],
	      [width + height / 2, depth + height / 2, 0]]) {
      translate(p) {
	cylinder(h = height, r = height, $fn=60);
      }
    }
  }

  translate([width + height * 1.5, height, 15 + height])
  rotate([0, 90, 0])
  hull() {
    for (p = [[0, 0, 0],
	      [15, 0, 0],
	      [0, depth + height / 2, 0],
	      [15, depth + height / 2, 0]]) {
      translate(p) {
	cylinder(h = height, r = height, $fn=60);
      }
    }
  }

  translate([width + height * 1.5, height * 1.5, 7.5]) {
    rotate(a = [-270, 0, 90])
    linear_extrude(4)
    text("#2", size=6);
  }
}

module lip(box_depth, box_height) {
  translate([3, box_depth / 2, box_height / 2])
  rotate([-90, 0, 0])
  cylinder(h = 10, r = 2, $fn = 60);
}

module ramp(width, depth, height, thickness, radius) {
  difference() {
    translate([radius, radius, 0]) {
      hull() {
	for (p = [[thickness/2, thickness/2, 0],
		  [width, thickness/2, 0],
		  [thickness/2, depth, 0],
		  [width, depth, 0]]) {
	  translate(p) {
	    cylinder(h = height, r = radius, $fn=60);
	  }
	}
      }
    }

    translate([height*1.75, 0, height*2])
      rotate([-90, 0, 0])
      cylinder(h = width + thickness*3, r = height*2, $fn = 100);
  }
}

module coffee_holder() {
  box_sleeve(60, 60, 90, 3, 3);
  shelf(80, 60, 3);
  lip(60, 90);
  ramp(60, 60, 30, 3, 3);
}

coffee_holder();
