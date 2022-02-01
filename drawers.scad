$fn = 100;

border_thickness = 1;
border_radius = 2;

drawer_width = 125;
drawer_length = 30;
drawer_height = 50;
drawer_spacing = 5;

num_drawers = 3;

module drawer_system_profile(width, total_length, radius) {
  minkowski() {
    square([width, total_length]);
    circle(radius);
  }
}

module drawer_system_floor(width, length, thickness, spacing, radius, num) {
  total_length = (length + spacing) * num;
  
  translate([radius, radius, 0]) {
    union() {
      difference() {
        drawer_system_profile(width, total_length, radius);

        let (midpoint = (length + spacing) / 2) {
          for (i = [0:1:num-1]) {
            translate([- 3 * radius / 7, midpoint + midpoint * i * 2]) {
              circle(r = radius);
            }
          }
        }


        let (midpoint = width / 6) {
          for (i = [0:1:num-1]) {
            translate([midpoint + midpoint * i * 2, - 3 * radius / 7]) {
              circle(r = radius);
            }
          }
        }
      }

      let (midpoint = (length + spacing) / 2) {
        for (i = [0:1:num-1]) {
          translate([width + 2 * radius - 3 * radius / 7, midpoint + midpoint * i * 2]) {
            circle(r = radius - 0.1);
          }
        }
      }

      let (midpoint = width / 6) {
        for (i = [0:1:num-1]) {
          translate([midpoint + midpoint * i * 2, total_length + 2 * radius - 3 * radius / 7]) {
	    circle(r = radius - 0.1);
          }
        }
      }
    }
  }
}

module drawer_system_body(width, length, height, spacing, thickness, radius, num) {
  difference() {
    linear_extrude(height) {
      drawer_system_floor(width, length, thickness, spacing, radius, num);
    }

    translate([thickness + 3 * radius, thickness + 3 * radius, thickness]) {
      linear_extrude(height) {
	total_length = (length + spacing) * num;

	drawer_system_profile(width - 4 * radius - thickness,
			      total_length - 4 * radius - thickness,
			      radius);
      }
    }
  }
}

module drawer_system_dividers(width, length, height, spacing, thickness, radius, num) {
  total_length = (length + spacing) * num;

  for (i = [width/3+spacing:width/3:width-1]) {
    translate([i, thickness + 2*radius, 0]) {
      union() {
	translate([thickness, 0, 0])
	linear_extrude(drawer_height)
	  difference() {
	  square(border_radius);

	  translate([border_radius, border_radius])
	    circle(border_radius);
	}

	mirror([1, 0, 0])
	  linear_extrude(drawer_height)
	  difference() {
	  square(border_radius);

	  translate([border_radius, border_radius])
	    circle(border_radius);
	}

	cube([thickness, spacing, height]);
      }
    }
  }

  translate([0, total_length + thickness + 2*radius, 0])
  mirror([0, 1, 0])
  for (i = [width/3+spacing:width/3:width-1]) {
    translate([i, thickness + 2*radius, 0]) {
      union() {
	translate([thickness, 0, 0])
	linear_extrude(drawer_height)
	  difference() {
	  square(border_radius);

	  translate([border_radius, border_radius])
	    circle(border_radius);
	}

	mirror([1, 0, 0])
	  linear_extrude(drawer_height)
	  difference() {
	  square(border_radius);

	  translate([border_radius, border_radius])
	    circle(border_radius);
	}

	cube([thickness, spacing, height]);
      }
    }
  }
}

module drawer_system(width, length, height, spacing, thickness, radius, num) {
  drawer_system_body(width, length, height, spacing, thickness, radius, num);
  drawer_system_dividers(width, length, height, spacing, thickness, radius, num);
}

drawer_system(drawer_width, drawer_length, drawer_height, drawer_spacing,
	      border_thickness, border_radius, num_drawers);

