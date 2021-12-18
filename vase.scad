num_points = 5;
height = 65;
radius = 40;
twist = 100;
slices = 5;
scale = 1.5;

coordinates = function(points, r)
  [
   for (i = [0:points - 1])
     let (deg = i * 360 / points)
       [sin(deg) * r, cos(deg) * r]
   ];

vertices = coordinates(num_points, radius);

linear_extrude(height = height, twist = twist, slices = slices, scale = scale)
polygon(points = vertices);
