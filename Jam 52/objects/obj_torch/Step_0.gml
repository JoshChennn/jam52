// Follow player or destroy
if (instance_exists(obj_player)) {
	x = obj_player.x;
	y = obj_player.y;
	depth = obj_player.depth + 1;
}
else {
	instance_destroy();
}

// Create dream effect
if dreamMode scr_dream();
else {
	if instance_exists(obj_bubble) instance_destroy(obj_bubble);
	obj_player.in_bubble = false;
}