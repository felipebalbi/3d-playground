freq_x = 120;
freq_y = 160;
a = 24;
sample_period = 120;
phase_x = 0;
phase_y = 0;
step = 1;

for (i = [0:step:120]) {
  for (j = [0:step:120]) {
    translate([i, j, 0])
      color(c = [0, 0, 1.0])
      cube(size = [step, step, (a/2+2) + (a/2-2) * cos(2 * PI * freq_x * i / sample_period + phase_x) * sin(2 * PI * freq_y * j / sample_period + phase_y)] );
  }
 }
