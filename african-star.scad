$fn = 125;

print_covers = true;

module cover() {
  difference() {
    cylinder(h=3, d=25.5);

    translate([0, 0, 1.5])
      cylinder(h=3, d=23.8);
  }
}

module blank() {
  cylinder(h=3, d=23);
}

module horseshoe() {
  difference() {
    blank();

    union() {
      translate([0, 2, 2])
	rotate_extrude(angle = 180)
	translate([23/2 - 7.5, 0, 0])
	square([2.5, 2.5]);

      translate([23/2 - 7.5, -7.5, 2])
	cube([2.5, 10, 2.5]);

      mirror([-1, 0, 0])
	translate([23/2 - 7.5, -7.5, 2])
	cube([2.5, 10, 2.5]);


      translate([23/2 - 7.5, -7.5, 2])
	cube([3.5, 2.5, 2.5]);

      mirror([-1, 0, 0])
	translate([23/2 - 7.5, -7.5, 2])
	cube([3.5, 2.5, 2.5]);
    }
  }
}

module topaz() {
  difference() {
    blank();
    
    translate([0, 0, 2])
    linear_extrude([0, 0, 1])
      text("Topaz", font="Roboto Condense:style=Bold", halign="center", valign="center", size=5);
  }
}

module leopard() {
  difference() {
    blank();

    translate([0, 0, 2])
    linear_extrude([0, 0, 1])
      text("Leopard", font="Roboto Condense:style=Bold", halign="center", valign="center", size=4);
  }
}

module emerald() {
  difference() {
    blank();

    translate([0, 0, 2])
    linear_extrude([0, 0, 1])
      text("Emerald", font="Roboto Condense:style=Bold", halign="center", valign="center", size=4);
  }
}

module ruby() {
  difference() {
    blank();

    translate([0, 0, 2])
    linear_extrude([0, 0, 1])
      text("Ruby", font="Roboto Condense:style=Bold", halign="center", valign="center", size=4);
  }
}

star_vertices = function(points, r1, r2)
  [
   [
    for (i = [0:points * 2 - 1])
       let (r = i % 2 ? r2 : r1,
	    deg = i * 360 / (points * 2))
	 [sin(deg) * r, cos(deg) * r]
    ],
   [
    [
     for (i = [0:points * 2])
	 i % (points * 2)]
    ]
   ];

vertices = star_vertices(5, 10, 5);

module Star(thickness, delta = 0) {
  difference() {
    offset(thickness / 2)
      offset(delta = -delta)
      polygon(vertices[0], vertices[1]);

    offset(-thickness / 2)
      offset(delta = -delta)
      polygon(vertices[0], vertices[1]);
  }
};

module african_star() {
  difference() {
    blank();

    translate([0, 0, 2])
    linear_extrude(2, convexity = 5)
      Star(2);
  }
}

if (print_covers) {
  for (x = [0:1:5]) {
    for (y = [0:1:4]) {
      translate([x*26, y*26, 0])
	cover();
    }

    for (y = [0:1:2]) {
      translate([6*26, y*26, 0])
	cover();
    }
  }
} else {
  for (x = [0:1:5]) {
    for (y = [0:1:1]) {
      translate([x*25, y*25, 0])
	blank();
    }
  }

  for (x = [0:1:3]) {
    translate([x*25, 2*25, 0])
      topaz();
  }

  for (x = [4:1:5]) {
    translate([x*25, 2*25, 0])
      ruby();
  }

  for (x = [0:1:2]) {
    translate([x*25, 3*25, 0])
      emerald();
  }

  for (x = [3:1:5]) {
    translate([x*25, 3*25, 0])
      leopard();
  }

  translate([0*25, 4*25, 0])
    african_star();

  for (x = [1:1:5]) {
    translate([x*25, 4*25, 0])
      horseshoe();
  }
}
