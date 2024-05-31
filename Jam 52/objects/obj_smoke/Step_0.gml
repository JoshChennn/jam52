var grow = random_range(0.0, 0.01);
var guess= random_range(0, 6);


if (guess > 4) {
	direction += random_range(-5,5)
}
if (guess > 3) {
	image_index = image_index + random_range(-3,3);
}

image_xscale += grow;
image_yscale = image_xscale;
