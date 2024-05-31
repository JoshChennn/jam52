var grow = random_range(0.01,0.03);

if (hit_wall) {
	speed = 0;
	image_xscale += grow-0.01;
	image_yscale = image_xscale;
} else {
	image_xscale += grow;
	image_yscale = image_xscale;
}