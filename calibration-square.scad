for (i = [0:7]) {
  difference() {
    cube([150 - 20 * i, 150 - 20 * i, 1], center = true);
    cube([140 - 20 * i, 140 - 20 * i, 2], center = true);
  }
 }
