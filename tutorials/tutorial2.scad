$fn = 125;

union() {
    difference() {
        rotate_extrude(angle=180)
        square([1, 4]);

        rotate_extrude(angle=180)
        translate([0.375, 3.7, 0])
        square([0.375, 0.3]);
    }

    rotate_extrude(angle=-180)
    translate([0.7, 0, 0])
    square([0.3, 0.8]);
}