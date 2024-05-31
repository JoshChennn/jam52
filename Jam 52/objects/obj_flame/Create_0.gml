// Start small
image_xscale = 0.1;
image_yscale = image_xscale;

// Set colour
var col = irandom_range(0,10);
if (col < 6) {
	image_index = 0;
}
else if (col < 9) {
	image_index = 1;
}
else {
	image_index = 2;
}

var dir = irandom_range(-5,5);
direction = obj_flamethrower.image_angle + dir;
speed = random_range(7,11);

var destroy = random_range(10,25);
alarm_set(0, destroy);