use <box.scad>;
use <fillet.scad>;

$fn = 100;

holder_width = 63;
holder_depth = 63;
capsule_height = 35;
holder_height = 150;

material_thickness = 2.5;
corner_radius = 3;

module holder_ramp(dims, r = 1) {
  function get_width(dims)	= dims[0];
  function get_depth(dims)	= dims[1];

  width = get_width(dims);
  depth = get_depth(dims);
  height = width;

  difference() {
    linear_extrude(depth) {
      rounded_square([width, depth, height], r);
    }

    translate([0, material_thickness - depth / 2, depth])
      rotate([0, 90, 0])
      cylinder(r = depth, h = height, center = true);
  }
}

module holder_walls(dims, r = 1) {
  function get_width(dims)	= dims[0];
  function get_depth(dims)	= dims[1];
  function get_height(dims)	= dims[2];

  width = get_width(dims);
  depth = get_depth(dims);
  height = get_height(dims);

  strain_relief = width / 3;

  difference() {
    linear_extrude(height - capsule_height)
      difference() {
      rounded_square([width + material_thickness * 2,
		      depth + material_thickness * 2], r);

      rounded_square(dims, r);

      translate([0, -depth/2])
	rounded_square([strain_relief, depth/2], r);
    }

    translate([0, -depth/2, 0])
    rotate([90, 45, 0])
      cube([width * cos(45),
	    width * sin(45),
	    material_thickness * 2 + 2], center=true);

    translate([strain_relief/2 - 0.1, -depth/2, height - capsule_height + 0.1])
      rotate([0, 90, 0]) {
      linear_fillet(material_thickness * 2 + 2, corner_radius);
    }

    mirror([1, 0, 0])
    translate([strain_relief/2 - 0.1, -depth/2, height - capsule_height + 0.1])
    rotate([0, 90, 0])
      linear_fillet(material_thickness * 2 + 2, corner_radius);
  }
}

module holder_shelf(dims, r = 1) {
  function get_width(dims)	= dims[0];
  function get_depth(dims)	= dims[1];

  linear_extrude(capsule_height)
  difference() {
    width = get_width(dims);
    depth = get_depth(dims) * 2;

    rounded_square([width + material_thickness * 2,
		    depth + material_thickness * 2], r);

    rounded_square([width, depth], r);
  }
}

module holder_floor(dims, r = 1) {
  function get_width(dims)	= dims[0];
  function get_depth(dims)	= dims[1];
  function get_height(dims)	= dims[2];

  linear_extrude(material_thickness)
  difference() {
    width = get_width(dims);
    depth = get_depth(dims) * 2;

    rounded_square([width + material_thickness * 2,
		    depth + material_thickness * 2], r);
  }
}

module holder(dims, r) {
  function get_width(dims)	= dims[0];
  function get_depth(dims)	= dims[1];
  function get_height(dims)	= dims[2];

  union() {
    translate([0, -get_depth(dims)/2, 0]) {
      holder_shelf(dims, r);
      holder_floor(dims, r);
    }

    holder_ramp(dims, r);

    translate([0, 0, capsule_height])
      holder_walls(dims, r);
  }
}

holder([holder_width, holder_depth, holder_height], r = corner_radius);
