rows = 5;
cols = 7;

width = 20;
length = 45;
height = 15;

module tray_base(width, length, height, thickness, radius) {
  linear_extrude(height) {
    hull() {
      w = width - radius + thickness;
      l = length - radius + thickness;

      points = [[-w/2, -l/2],
		[ w/2, -l/2],
		[ w/2,  l/2],
		[-w/2,  l/2]];
      for (p = points) {
	translate(p) {
	  circle(radius);
	}
      }
    }
  }
}

module tray_walls(width, length, height, thickness, radius)
{
  linear_extrude(height) {
    difference() {
      hull() {
	w = width - radius + thickness;
	l = length - radius + thickness;

	points = [[-w/2, -l/2],
		  [ w/2, -l/2],
		  [ w/2,  l/2],
		  [-w/2,  l/2]];
	for (p = points) {
	  translate(p) {
	    circle(radius);
	  }
	}
      }

      hull() {
	w = width - radius;
	l = length - radius;

	points = [[-w/2, -l/2],
		  [ w/2, -l/2],
		  [ w/2,  l/2],
		  [-w/2,  l/2]];
	for (p = points) {
	  translate(p) {
	    circle(radius);
	  }
	}
      }
    }
  }
}

module tray_dividers(width, length, height, rows, cols, thickness) {
  total_width = width * cols + thickness;
  total_length = length * rows + thickness;

  for (x = [-total_width / 2 + width:width:total_width / 2 - width]) {
    translate([x, -total_length/2, 0])
      cube([thickness, total_length, height]);
  }

  for (y = [-total_length / 2 + length:length:total_length / 2 - length]) {
    translate([-total_width / 2, y, 0])
      cube([total_width, thickness, height]);
  }
}

module tray(width, length, height, rows, cols, thickness, radius) {
  total_width = width * cols;
  total_length = length * rows;

  tray_base(total_width, total_length, thickness, thickness, radius);

  translate([0, 0, thickness])
    tray_walls(total_width, total_length, height, thickness, radius);

  tray_dividers(width, length, height, rows, cols, thickness);
}

tray(width, length, height, rows, cols, 3, 3);
