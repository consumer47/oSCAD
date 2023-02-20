use <Skadis_Hook_redo.scad>

		//my_negativ_hook();

difference() 
{
	
	controller_holder();
	
	scale(v = 1.01) 
		my_negativ_hook();
}

module controller_holder() {
	translate([-109, -64, -9.0]) 
	{
		rotate([0, 0, -64 +180]) 
		{
			import("include_stls/DualShock4_Mount_w_chargehole.stl");
		}
	} 
}


/* [Hidden] */
$fn = 5;

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
HOOK_SIZE_H = 12.5; // [11:100]
// Height (vertical size) of the hook.
HOOK_SIZE_V = 5; // [0:50]
// Vertical rotation of the hook.
HOOK_ROTATION = 0; // [0:90]

// 
SHIFT_OF_HOOK_2 = 20;

module my_negativ_hook() {
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
}
