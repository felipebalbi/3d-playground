bed_size = 220;	/* mm */
height = 0.2;	/* mm */
margin = 10;	/* mm */

for (i = [bed_size - margin: - 2 * margin : margin]) {
  difference() {
    cube([i, i, height], center = true);
    cube([i - margin, i - margin, height * 2], center = true);
  }
 }
