// Follow player or destroy
if (instance_exists(obj_player)) {
	x = obj_player.x;
	y = obj_player.y + 30;
	depth = obj_player.depth + 1;
	image_angle = (40 * -obj_player.image_xscale);
}
else {
	instance_destroy();
}

// Create dream effect
if (size < 0.97) {
	bigger = 1;
}
else if (size > 1.03) {
	bigger = -1;
}
grow = (0.04 - abs(1 - size)) / 50;	
size += grow * bigger;

if dreamMode scr_dream(size);
else {
	if instance_exists(obj_bubble) instance_destroy(obj_bubble);
	obj_player.in_bubble = false;
}