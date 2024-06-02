if (!shoot) {
    if (should_shoot) {
        shoot = true;
        direction = angle;
        speed = fast;
        rotate = true;
    }
} else {
    gravity = gra;
}

// Check for collision with the player
if (place_meeting(x, y, obj_player)) {
	if (cooldown < 0) {
	    with (obj_player) {
	        hp -= other.damage;
	        flash = 3;
			cooldown = 120;
	    }
	}
}
cooldown --;
// Check for collision with walls
if (wall_collision(x, y) && !place_meeting(x, y, obj_enemySkeleton)) {
    instance_destroy(); // Destroy the spear upon collision with a wall
}