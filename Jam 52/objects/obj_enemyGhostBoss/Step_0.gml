// Add this at the beginning of the Step event
show_debug_message("Ghost Step Event: Start");

// Room boundaries
var room_left = 0;
var room_right = room_width;
var room_top = 0;
var room_bottom = room_height;

// Get the distance to the player
var distance_to_player = point_distance(x, y, target.x, target.y);

if (flash > 0) flash--;

if (hp <= 0) {
    sprite_index = spr_deadGhost;
    y -= 1;
    image_alpha = half_opacity;
    show_debug_message("Ghost is dead");
    return;
} else {
    sprite_index = spr_ghostBoss; // Use the appropriate sprite index for alive state
}

// Random movement logic
var random_movement = false;
if (random_move_timer > 0) {
    random_movement = true;
    random_move_timer--;
} else if (random_move_chance_timer <= 0) {
    // 1 in 5 chance for random movement even if within detection range
    random_move_chance_timer = 20; // Reset the chance timer
} else {
    random_move_chance_timer--;
}

// Reset detection range if timer expires
if (detection_range_timer > 0) {
    detection_range_timer--;
} else {
    detection_range = base_detection_range;
}

if (random_movement) {
    // Normalize the random direction
    var random_distance = point_distance(0, 0, random_dir_x, random_dir_y);
    if (random_distance != 0) {
        random_dir_x /= random_distance;
        random_dir_y /= random_distance;
    }

    // Move in the random direction
    x += random_dir_x * move_speed;
    y += random_dir_y * move_speed;
    show_debug_message("Ghost moving randomly");
} else if (distance_to_player <= detection_range) {
    show_debug_message("Player detected");

    // Increase detection range and set timer
    detection_range = base_detection_range * 4;
    detection_range_timer = 120; // 2 seconds at 60 fps

    // Move towards the player with some randomness
    var dir_x = (target.x - x) + random_offset_x;
    var dir_y = (target.y - y) + random_offset_y;

    // Normalize the direction
    var dir_distance = point_distance(0, 0, dir_x, dir_y);
    if (dir_distance != 0) {
        dir_x /= dir_distance;
        dir_y /= dir_distance;
    }

    // Move towards the player
    x += dir_x * move_speed;
    y += dir_y * move_speed;
} else {
    show_debug_message("Player not detected, no movement");
}

// Prevent the ghost from moving out of the room
if (x < room_left) {
    x = room_left;
}
if (x > room_right) {
    x = room_right;
}
if (y < room_top) {
    y = room_top;
}
if (y > room_bottom) {
    y = room_bottom;
}

// Collision with player
if (place_meeting(x, y, obj_player)) {
    image_alpha = half_opacity;
    show_debug_message("Collision with player");
}

// Collision with walls
if (place_meeting(x, y, obj_wall)) {
    image_alpha = half_opacity; // Set opacity to 50%
    move_speed = 1;
    show_debug_message("Collision with wall");
} else {
    image_alpha = normal_opacity; // Set opacity to normal
    move_speed = 2;
}

// Setting sprite direction
if (variable_instance_exists(self, "dir_x")) {
    if (x < obj_player) {    
        image_xscale = 1;
    }
    else {
        image_xscale = -1;    
    }
} else {
    if (random_dir_x > 0) {    
        image_xscale = 1;
    } else {
        image_xscale = -1;    
    }
}

show_debug_message("Ghost Step Event: End");
