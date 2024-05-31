/// @description Move the spear and handle collisions

// Move the spear
x += hspeed;
y += vspeed;

// Update image angle to match direction of movement
if (hspeed > 0) {
	image_angle = point_direction(0, 0, hspeed, vspeed);
}

// Check for collision with the player
if (place_meeting(x, y, obj_player)) {
    with (obj_player) {
        hp -= other.damage;
        flash = 3;
    }
    if (!place_meeting(x, y, obj_enemySkeleton)) instance_destroy();
}

// Check for collision with walls
if (place_meeting(x, y, obj_wall) && !place_meeting(x, y, obj_enemySkeleton)) {
    instance_destroy(); // Destroy the spear upon collision with a wall
}

if (abs(hspeed) < resistance) {
    hspeed = 0;
} else {
    hspeed -= sign(hspeed) * resistance;
}

vspeed += gravity;
y += vspeed;
