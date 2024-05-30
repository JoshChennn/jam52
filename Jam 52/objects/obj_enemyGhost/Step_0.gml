/// @description Mechanics

// Get the direction towards the player
var dir_x = target.x - x;
var dir_y = target.y - y;

if (flash > 0) flash--;

if (hp <= 0) {
    sprite_index = spr_deadGhost;
	y -= 1;
	image_alpha = half_opacity;
	return;
} else {
    sprite_index = spr_ghost; // Use the appropriate sprite index for alive state
}

// Normalize the direction
var distance = point_distance(x, y, target.x, target.y);
if (distance != 0) {
    dir_x /= distance;
    dir_y /= distance;
}

// Move towards the player
x += dir_x * move_speed;
y += dir_y * move_speed;

// Collision with player
if (place_meeting(x, y, obj_player)) {
    var overlap_x = abs(x - target.x);
    var overlap_y = abs(y - target.y);
    
    // Prevent overlap more than 5 pixels
    if (overlap_x > max_overlap) {
        x = target.x + sign(x - target.x) * max_overlap;
    }
    if (overlap_y > max_overlap) {
        y = target.y + sign(y - target.y) * max_overlap;
    }
}

// Collision with walls
if (place_meeting(x, y, obj_wall)) {
    image_alpha = half_opacity; // Set opacity to 50%
} else {
    image_alpha = normal_opacity; // Set opacity to normal
}