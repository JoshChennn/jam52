/// @description Mechanics

// Variables to store the random offset for each ghost
if (!variable_instance_exists(self, "random_offset_x")) {
    random_offset_x = random_range(-20, 20);
}
if (!variable_instance_exists(self, "random_offset_y")) {
    random_offset_y = random_range(-20, 20);
}

// Variables for detection range modification
if (!variable_instance_exists(self, "detection_range")) {
    detection_range = base_detection_range;
}
if (!variable_instance_exists(self, "detection_range_timer")) {
    detection_range_timer = 0;
}

// Timer for random movement
if (!variable_instance_exists(self, "random_move_timer")) {
    random_move_timer = 0;
}

// Random direction for movement
if (!variable_instance_exists(self, "random_dir_x")) {
    random_dir_x = random_range(-1, 1);
}
if (!variable_instance_exists(self, "random_dir_y")) {
    random_dir_y = random_range(-1, 1);
}

// Probability counter for random movement and detection range modification
if (!variable_instance_exists(self, "random_move_chance_timer")) {
    random_move_chance_timer = 120; // 2 seconds at 60 fps
}

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
    return;
} else {
    sprite_index = spr_ghost; // Use the appropriate sprite index for alive state
}

// Random movement logic
var random_movement = false;
if (random_move_timer > 0) {
    random_movement = true;
    random_move_timer--;
} else if (random_move_chance_timer <= 0) {
    // 1 in 5 chance for random movement even if within detection range
    if (irandom(4) == 0) {
        random_movement = true;
        random_move_timer = 120; // 2 seconds at 60 fps
    }
    // 1 in 5 chance for quadrupling detection range for 4 seconds
    if (irandom(frequency_of_increase) == 0) {
        detection_range = base_detection_range * increase_in_detection_range;
        detection_range_timer = increase_time; // 4 seconds at 60 fps
    }
    random_move_chance_timer = 120; // Reset the chance timer
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
} else if (distance_to_player <= detection_range) {
    // Get the direction towards the player with some randomness
    var dir_x = (target.x - x) + random_offset_x;
    var dir_y = (target.y - y) + random_offset_y;

    // Normalize the direction
    if (distance_to_player != 0) {
        dir_x /= distance_to_player;
        dir_y /= distance_to_player;
    }

    // Move towards the player
    x += dir_x * move_speed;
    y += dir_y * move_speed;
} else {
    // Normal random movement when not aware of the player
    if (random_move_timer <= 0) {
        // Pick a new random direction
        random_dir_x = random_range(-1, 1);
        random_dir_y = random_range(-1, 1);

        // Reset the timer (120 steps = 2 seconds at 60 fps)
        random_move_timer = 120;
    }

    // Normalize the random direction
    var random_distance = point_distance(0, 0, random_dir_x, random_dir_y);
    if (random_distance != 0) {
        random_dir_x /= random_distance;
        random_dir_y /= random_distance;
    }

    // Move in the random direction
    x += random_dir_x * move_speed;
    y += random_dir_y * move_speed;

    // Decrease the timer
    random_move_timer--;
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
}

// Collision with walls
if (place_meeting(x, y, obj_wall)) {
    image_alpha = half_opacity; // Set opacity to 50%
    move_speed = 1;
} else {
    image_alpha = normal_opacity; // Set opacity to normal
    move_speed = 2;
}
