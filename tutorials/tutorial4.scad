$fn = 25;

difference() {
    cube([130, 80, 50]);
    
    for (x = [0:104:104]) {
        for (y = [0:58:58]) {
            translate([x, y, 0]) {
                translate([-2, -2, 22])
                minkowski() {
                    cube([30, 25, 30]);
                    sphere(d=4);
                }
            }
        }
    }
    
    for (x = [0:100:100]) {
        for (y = [0:56:56]) {
            translate([x, y, 0])
            translate([15, 12, 0]) {
                cylinder(18, d = 8, false);
                translate([0, 0, 18])
                cylinder(3, d = 18, false);
            }
        }
    }
    
    translate([65, 80, 50])
    rotate([90, 0, 0]) {
        cylinder(65, d = 40, false);
        translate([0, 0, 65])
        cylinder(15, d = 50, false);
    }
    
    for (x = [0:100:100]) {
        translate([x, 0, 0]) {
            translate([15, 40, 30]) {
                cylinder(h = 3, r1 = 0, r2 = 6, center = false);
                
                translate([0, 0, 3])
                cylinder(20, d = 12, false);
            }
        }
    }
    
    translate([0, 80, 0])
    rotate([90, 0, 0])
    linear_extrude(height = 80, center=false)
    polygon([[36.7, 0], [93.3, 0], [90, 8], [40, 8]]);
}