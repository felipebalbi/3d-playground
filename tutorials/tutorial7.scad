$fn = 125;

d1=220;
d2=180;
d3=60;
d4=20;
d5=32;
d6=10;
h1=120;
h2=100;
h3=20;
h4=5;
h5=50.8;
l1=220;
l2=155;

module slot(height, diameter, length) {
    hull() {
        cylinder(h=height, d=diameter);
        translate([length, 0, 0])
        cylinder(h=height, d=diameter);
    }
}


module boss(boss_height, boss_dia) {
    cylinder(h=boss_height, d=boss_dia);
    
    rotate_extrude(angle=360)
    translate([boss_dia/2, 0, 0])
    difference() {
        square(5);
        translate([5, 5, 0])
        circle(5);
    }
}

module fastenning_hole(p1, p2, p3) {
    translate([p1, p2, p3])
    cylinder(h=h5, d=d6);
}

module fillet(f) {
    linear_extrude(height=20)
    difference() {
        translate([321.538, 30, 0])
        square([18.462, 12.308]);
        
        translate([220, 0, 0])
        circle(110);
        
        translate([340, 50, 0])
        circle(f);
    }
}

difference() {
    union() {
        difference() {
            union() {
                slot(height=h1, diameter=d1, length=l1);
                
                translate([l1, 0, 0])
                slot(height=h3, diameter=d3, length=l2);
            }
            
            translate([0, 0, h3])
            slot(height=h2, diameter=d2, length=l1);
        }
        
        
        for (x=[0:110:220]) {
            translate([x, 0, 0])
            translate([0, 0, h3])
            boss(h4, d3);
        }
    }
    
    for (x=[0:110:220]) {
        translate([x, 0, 0])
        cylinder(h=h3+h4, d=d5);
    }
    
    translate([l2+l1, 0, 0])
    cylinder(h=h3, d=d4);
    
    for (x=[0:91.5:183]) {
        translate([x, 0, 0])
        fastenning_hole(37, 100, h1-h5);
    }
    
    for (x=[0:91.5:183]){
        translate([x, 0, 0])
        fastenning_hole(0, -100, h1-h5);
    }
    
    for (z=[0:-50:-150]) {
        rotate([0, 0, z])
        fastenning_hole(0, -100, h1-h5);
    }
    
    translate([220, 0, 0])
    for(z=[0:-50:-150]) {
        rotate([0, 0, z])
        fastenning_hole(0, 100, h1-h5);
    }
}

fillet(20);
mirror([0, 1, 0])
fillet(20);