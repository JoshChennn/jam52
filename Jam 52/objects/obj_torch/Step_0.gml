// Follow player or destroy
if (instance_exists(obj_player)) {
	x = obj_player.x;
	y = obj_player.y - 10;
	depth = obj_player.depth + 1;
	image_angle = (40 * -obj_player.image_xscale);
}
else {
	instance_destroy();
}