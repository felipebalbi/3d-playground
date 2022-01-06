union() {
    difference() {
        cube([50, 65, 40]);
    
        translate([12, 0, 14])
        cube([38, 65, 12]);
    
        translate([42, 20, 26])
        cube([8, 25, 14]);
    
        translate([22, 12.5, 26])
        cube([20, 40, 14]);
    }
    
    translate([50, 40, 0])
    cube([12, 25, 14]);
}