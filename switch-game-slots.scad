$fn = 100;

width = 220;
length = 100;
height = 10;

radius = 30;

gamecard_width = 22;
gamecard_length = 32;
gamecard_height = 3.8;
gamecard_radius = 5;

module base(width, length, radius) {
  corners = [[radius		, radius],
	     [width - radius	, radius],
	     [width - radius	, length - radius],
	     [radius		, length - radius]];

  hull() {
    for (p = corners) {
      translate(p) circle(r=radius);
    }
  }
}

module game_card_slot(width, length, height, radius) {
  corners = [[radius		, radius],
	     [width - radius	, radius],
	     [width - radius	, length - radius],
	     [radius		, length - radius]];

  rotate([15, 0, 0]) {
    linear_extrude(height) {
      hull() {
	for (p = corners) {
	  translate(p) circle(r=radius);
	}
      }
    }
  }
}

module game_card_slots(width, length, height, radius) {
  thickness = 2.4;
  margin = 2;

  for (j = [0:1:3]) {
    for (i = [0:1:7]) {
      x = i * (width + margin);
      y = j * (length / 2 + margin);
      z = thickness;

      translate([x, y, z]) {
	game_card_slot(width, length, height, radius);
      }
    }
  }
}

module game_card_holder(width, length, height, radius,
			g_width, g_length, g_height, g_radius) {
  h = height;

  difference() {
    linear_extrude(h)
      base(width, length, radius);

    translate([14, 7, 0])
    game_card_slots(g_width, g_length, g_height, g_radius);
  }
}

game_card_holder(width, length, height, radius,
		 gamecard_width, gamecard_length, gamecard_height, gamecard_radius);
