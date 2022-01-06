d1 = 65;
d2 = 51;
ir = 5;
x = (d1/2 + ir);
h1 = 254 - x;
h2 = 508 - 2*x;
h3 = 381 - 2*x;
h4 = h1;

module pipe(h, diameter1, diameter2) {
    difference() {
        cylinder(h, d = diameter1, center = false);
        cylinder(h, d = diameter2, center = false);
    }
}

module elbow(a) {
    rotate_extrude(angle = a) {
        difference() {
            translate([d1/2 + 5, 0, 0]) circle(d = d1);
            translate([d1/2 + 5, 0, 0]) circle(d = d2);
        }
    }
}

module flange(i, t) {
    difference() {
        cylinder(h = 20, d = 115, center=false);
        
        cylinder(h = 20, d = 51, center=false);
        
        for(z=[0:i:t]) {
            rotate([0, 0, z])
            translate([45, 0, 0])
            cylinder(h=20, d=12, center=false);
        }
        
        translate([45, 0, 0])
        cylinder(h = 20, d = 12, center=false);
    }
}

rotate([0, 90, 0])
pipe(h = h1, diameter1 = d1, diameter2 = d2);

translate([h1, 0, x])
rotate([-90, 0, 0])
elbow(a = 90);

translate([h1 + x, 0, x])
pipe(h = h2, diameter1 = d1, diameter2 = d2);

translate([h1+d1+2*ir, 0, h2+x])
rotate([90, -90, 0])
elbow(a = 90);

translate([h1 + 2*x, 0, h2 + 2*x])
rotate([0, 90, 0])
pipe(h = h2, diameter1 = d1, diameter2 = d2);

translate([h1+h2+2*x, 0, h2+x])
rotate([90, 0, 0])
elbow(a = 90);

translate([h1 + h2 + 3*x, 0, h2 - h3 + x])
pipe(h = h3, diameter1 = d1, diameter2 = d2);

translate([h1+h2+4*x, 0, h2-h3+x])
rotate([-90, 90, 0])
elbow(a = 90);

translate([h1 + h2 + 4*x, 0, h2 - h3])
rotate([0, 90, 0])
pipe(h = h4, diameter1 = d1, diameter2 = d2);

// first flange
translate([-20, 0, 0])
rotate([0, 90, 0])
flange(60, 360);

// second flange
translate([h1+h2+h4+4*x, 0, h2-h3])
rotate([0, 90, 0])
flange(60, 360);