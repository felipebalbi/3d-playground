thickness = 20;
height = 10;
num_points = 5;
outter_radius = 70;
inner_radius = 35;

$fn = 100;

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

vertices = star_vertices(num_points, outter_radius, inner_radius);

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

linear_extrude(height, convexity = 5)
Star(thickness);

translate([0, outter_radius * 1.35, 0])
difference() {
  cylinder(h = height, r = 10);
  translate([0, 0, -1])
    cylinder(h = height * 2, r = 5);
}

translate([- height / 3, outter_radius, 0])
cube([2 * height / 3, inner_radius / 2, height]);

translate([0, outter_radius - 5, height*0.9])
rotate([0, 0, 90])
linear_extrude(2)
text("#3", font="Roboto Condense:style=Bold", halign = "center",
     valign = "center", size = 10);
