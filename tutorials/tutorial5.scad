v1 = 340;
v2 = 170;
v3 = 338;
v4 = 168;

module loft(d1, d2) {
    hull() {
        translate([0, 0, 40])
        cylinder(h = 0.00001, d = d1);
        
        translate([225, 0, 355])
        cylinder(h = 0.00001, d = d2);
    }
}

difference() {
    union() {
        loft(d1 = v1, d2 = v2);
        mirror([1, 0, 0]) loft(d1 = v1, d2 = v2);
        
        cylinder(h = 40, d = v1);
        
        translate([225, 0, 355])
        cylinder(h = 40, d = v2);
        
        translate([-225, 0, 355])
        cylinder(h = 40, d = v2);
    }
    
    union() {
        loft(d1 = v3, d2 = v4);
        mirror([1, 0, 0]) loft(d1 = v3, d2 = v4);
        
        cylinder(h = 40, d = v3);
        
        translate([225, 0, 355])
        cylinder(h = 40, d = v4);
        
        translate([-225, 0, 355])
        cylinder(h = 40, d = v4);
    }
}