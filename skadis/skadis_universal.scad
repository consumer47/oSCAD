// Thickness of the mounting plate (mm) - do not change
THICKNESS=4.7;
// Width of the hook holes (mm) - do not change
HOLE_WIDTH=4.3;
// Radius of the rounding at the top of the mounting plate
FILET_R=3;
$fn=60;

module skadis_universal() {
    difference() {
        cube([15, THICKNESS, 35-FILET_R]);
        // upper hole
        translate([5.2, 0, 20]) {
            cube([HOLE_WIDTH, THICKNESS, 10]);
        }
        // lower hole
        translate([5.2, 0, 0]) {
            cube([HOLE_WIDTH, THICKNESS, 4]);
        }
    }
    // filet left cylinder
    translate([FILET_R, 0, 35-FILET_R]) {
        rotate([-90,0,0])
            cylinder(r=FILET_R, h=THICKNESS);
    }
    // filet right cylinder
    translate([15-FILET_R, 0, 35-FILET_R]) {
        rotate([-90,0,0])
            cylinder(r=FILET_R, h=THICKNESS);
    }
    // filet middle
    translate([FILET_R, 0, 35-FILET_R]) {
        cube([15-2*FILET_R, THICKNESS, FILET_R]);
    }

    // connector to the rest of the part
    translate([0, THICKNESS, 0]) {
        difference() {
            cube([15, THICKNESS, 8]);
            translate([0, THICKNESS, 2*THICKNESS])
                rotate([0, 90, 0]) 
                    cylinder(r=THICKNESS, h=15);
        }
    }
}

