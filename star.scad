thickness = 5;
height = 8;
num_points = 5;
outter_radius = 80;
inner_radius = 40;

$fn = 60;

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

module Star(thickness, delta) {
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
for (i = [0:4])
  Star(thickness, delta = i * thickness * 2);

translate([0, outter_radius + 8, 0])
difference() {
  cylinder(h = height, r = 10);
  translate([0, 0, -1])
    cylinder(h = height * 2, r = 5);
}

translate([- height / 3, 3 + height / 2, 0])
cube([2 * height / 3, outter_radius - 5, height]);

translate([0, outter_radius - 5, 1])
rotate([0, 0, 90])
linear_extrude(8)
text("#3", font="Roboto Condense:style=Bold", halign = "center",
     valign = "center", size = 5);
