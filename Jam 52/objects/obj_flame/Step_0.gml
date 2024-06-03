var grow = random_range(0.1,0.3);

x += obj_player.horspeed;
y += obj_player.verspeed;

if (hit_wall) {
	if (image_xscale < 0.05) {
		instance_destroy();
	} else if (image_xscale > 1) {
		image_xscale -= 0.01;
	} else {
		image_xscale += grow - 0.1;
		image_yscale = image_xscale;
	}
	image_yscale = image_xscale;
	if (random_range(0,5) > 1) and (speed > 0) {
		speed -= 2;
	}
} else {
	image_xscale += grow;
	image_yscale = image_xscale;
}