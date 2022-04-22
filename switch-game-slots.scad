$fn = 100;

gamecard_width = 22;
gamecard_length = 32;
gamecard_height = 3.8;
gamecard_radius = 5;

margin = 2;
height = 10;
rows = 4;
columns = 8;

border_radius = 30;
border_x = 14;
border_y = 7;

module game_card_slot(w, l, h, r) {
  corners = [[r		, r],
	     [w - r	, r],
	     [w - r	, l - r],
	     [r		, l - r]];

  rotate([15, 0, 0]) {
    linear_extrude(h) {
      hull() {
	for (p = corners) {
	  translate(p) circle(r=r);
	}
      }
    }
  }
}


module game_card_slots(w, l, h, r, m, rows, cols) {
  for (i = [0:1:rows - 1]) {
    for (j = [0:1:cols - 1]) {
      x = j * (w + m);
      y = i * (l / 2 + m);

      translate([x, y, 0]) {
	game_card_slot(w, l, h, r);
      }
    }
  }
}

module base(w, l, r) {
  corners = [[r		, r],
	     [w - r	, r],
	     [w - r	, l - r],
	     [r		, l - r]];

  hull() {
    for (p = corners) {
      translate(p) circle(r=r);
    }
  }
}

module game_card_holder(h, gw, gl, gh, gr, m, rows, cols, bx, by, br) {
  width = (gw + m) * cols + bx + br / 2;
  length = (2 * gl / 3 + m) * rows + by;

  echo(str("Holder dimensions: ", width, "mm x ", length, "mm x ", h, "mm"));

  difference() {
    linear_extrude(h)
      base(width, length, br);

    translate([bx, by, 2.4])
      game_card_slots(gw,
		      gl,
		      gh,
		      gr,
		      m,
		      rows,
		      cols);
  }
}

game_card_holder(height,
		 gamecard_width,
		 gamecard_length,
		 gamecard_height,
		 gamecard_radius,
		 margin,
		 rows,
		 columns,
		 border_x,
		 border_y,
		 border_radius);
