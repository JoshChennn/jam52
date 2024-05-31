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