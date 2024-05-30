// obj_skeletonSpear STEP Event
/// @description Move the spear and handle collisions

// Move the spear
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

// Check for collision with the player
if (place_meeting(x, y, obj_player)) {
    with (obj_player) {
        hp -= other.damage;
        flash = 3;
    }
    instance_destroy(); // Destroy the spear upon collision
}

// Check for collision with walls
if (place_meeting(x, y, obj_wall)) {
    instance_destroy(); // Destroy the spear upon collision with a wall
}
