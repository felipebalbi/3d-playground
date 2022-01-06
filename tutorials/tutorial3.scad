$fn = 125;
inner_radius = 8;
bend_radius = 20;
bend_angle = 90;
thickness = 12;
height = 64;
first_armlength = 46;
second_armlength = 20;
third_armlength = 26;
fourth_armlength = 30;

difference() {
    union() {
        // first arm
        cube([first_armlength, height, thickness]);
    
        // first bend
        translate([first_armlength, 0, bend_radius]) {
            rotate([-90, 0, 0]) {
                rotate_extrude(angle=bend_angle)
                translate([inner_radius, 0, 0])
                square([thickness, height]);
            }
        }
    
        // second arm
        translate([first_armlength + inner_radius, 0, bend_radius])
        cube([thickness, height, second_armlength]);
    
        // second bend
        translate([first_armlength + bend_radius + inner_radius, 0, bend_radius + second_armlength]) {
            rotate([-90, -180, 0]) {
                rotate_extrude(angle=bend_angle)
                translate([inner_radius, 0, 0])
                square([thickness, height]);
            }
        }
        
        // third arm
        translate([first_armlength + inner_radius + bend_radius, 0, bend_radius + second_armlength + inner_radius])
        cube([third_armlength, height, thickness]);
        
        // third bend
        translate([first_armlength + bend_radius + inner_radius + third_armlength, 0, bend_radius + second_armlength]) {
            rotate([-90, -90, 0]) {
                rotate_extrude(angle=bend_angle)
                translate([inner_radius, 0, 0])
                square([thickness, height]);
            }
        }
        
        // fourth arm
        translate([first_armlength + inner_radius + 2*bend_radius + third_armlength, 0, bend_radius + second_armlength])
        rotate([0, 180, 0])
        cube([thickness, height, fourth_armlength]);
    }
    
    // chamfered hole
    translate([54, 32, 33])
    rotate([0, 90, 0]) {
        cylinder(66, d = 21, false);
        translate([0, 0, 64.7])
        cylinder(h = 1.3, r1 = 10.5, r2 = 12, center=false);
    }
    
    // second hole
    translate([87, 32, 0])
    cylinder(74, d = 20, false);
    
    // third hole
    translate([30, 15, 0])
    cylinder(12, d = 10, false);
    
    // fourth hole
    translate([30, 45, 0])
    cylinder(12, d = 10, false);
    
    // first chamfer
    linear_extrude(height = 12, center = false)
    polygon([[0, 0], [10, 0], [0, 20]]); 
    
    
    // second chamfer
    translate([0, 44, 0])
    linear_extrude(height = 12, center = false)
    polygon([[0, 0], [10, 20], [0, 20]]);
    
    // third chamfer
    translate([120, 0, 10])
    rotate([0, -90, 0])
    linear_extrude(height = 12, center = false)
    polygon([[0, 0], [10, 0], [0, 10]]);
    
    // fourth chamfer
    translate([108, 64, 10])
    rotate([180, -90, 0])
    linear_extrude(height = 16, center = false)
    polygon([[0, 0], [10, 0], [0, 10]]);
}