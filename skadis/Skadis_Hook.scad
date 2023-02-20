/* [Hidden] */
$fn = 10;

CLIP_HEIGHT = 12;
CLIP_PIN_INNER_DISTANCE = 26;
PIN_LENGTH = 7;

BASE_WIDTH = 4.4;
BASE_DEPTH = 5;

/* [Base] */
// Height of the base.
BASE_HEIGHT = 50; // [36:100]

/* [Hook] */
// Enable Smooth Edges.
ENABLE_SMOOTH_EDGES = true;
// Make the hook a bit prettier.
ENABLE_HOOK_NICE = true;
// Length (horizontal size) of the hook.
HOOK_SIZE_H = 10; // [1:100]
// Height (vertical size) of the hook.
HOOK_SIZE_V = 10; // [0:50]
// Vertical rotation of the hook.
HOOK_ROTATION = 0; // [0:90]


minkowskiOutsideRound(1, ENABLE_SMOOTH_EDGES) {
	hook(
		base_height = BASE_HEIGHT,
		base_width = BASE_WIDTH,
		base_depth = BASE_DEPTH,
		clip_height = CLIP_HEIGHT,
		clip_pin_distance = CLIP_PIN_INNER_DISTANCE,
		pin_length = PIN_LENGTH,
		hook_size_h = HOOK_SIZE_H,
		hook_size_v = HOOK_SIZE_V,
		hook_nice = ENABLE_HOOK_NICE,
		hook_rotation = HOOK_ROTATION
	);
}


module hook(
	base_height = 50,
	base_width = 4.4,
	base_depth = 5,
	clip_height = 12,
	clip_pin_distance = 19,
	pin_length = 7,
	hook_size_h = 15,
	hook_size_v = 5,
	hook_nice = true,
	hook_rotation = 0,
) {
	// Base
	cube(size=[base_depth, base_height, base_width]);

	// Clip, Top
	translate([base_depth, base_height-base_depth, 0]) {
		cube(size=[base_depth, base_depth, base_width]);
	}

	// Clip, Back
	translate([base_depth*2, base_height-clip_height, 0]) {
		cube(size=[base_depth, clip_height, base_width]);
	}

	// Pin
	translate([base_depth, base_height-2*base_depth-clip_pin_distance, 0]) {
		cube(size=[7, base_depth, base_width]);
	}

	// Hook, Horizontal
	translate([-(hook_size_h-base_depth), 0, 0]) {
		cube(size=[hook_size_h-base_depth, base_depth, base_width]);
	}

	// Hook, Vertical
	if (hook_size_h > 0) {
		translate([-(hook_size_h-base_depth), 0, 0]) {
			rotate([0, 0, hook_rotation]) {
				difference() {
					cube(size=[base_depth, base_depth+hook_size_v, base_width]);
					
					if (hook_nice == true) {
						translate([0, hook_size_v+base_depth/2, -1]) {
							rotate([0, 0, 45]) {
							cube(size=[base_depth, base_depth, base_width+2]);
							}
						}
					}
				}
			}
		}
	}
}

// Library: MinkowskiRound.scad
// Version: 1.0
// Author: IrevDev
// Copyright: 2017
// License: LGPL 2.1 or later
// Url: https://github.com/Irev-Dev/Round-Anything

module minkowskiOutsideRound(r=1,enable=true,cubeSize=[500,500,500]){
    if(enable==false){//do nothing if not enabled
        children();
    } else {
        minkowski(){//expand the now positive shape
            difference(){//make the negative positive
                cube(cubeSize-[0.1,0.1,0.1],center=true);
                minkowski(){//expand the negative inwards
                    difference(){//create a negative of the children
                        cube(cubeSize,center=true);
                        children();
                    }
                    sphere(r);
                }
            }
            sphere(r);
        }
    }
}
