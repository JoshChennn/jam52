/// @description Insert description here

image_xscale = random_range(0.4, 1.5);
image_yscale = image_xscale;
image_alpha = random_range(0.2, 0.5);

gun_range = 35;

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
direction = 90 + dir;
speed = random_range(1,4);

var destroy = random_range(10, 70);
alarm_set(0, destroy);