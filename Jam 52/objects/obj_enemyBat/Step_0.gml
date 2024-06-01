/// @description Mechanics

if (hp <= 0) {
    sprite_index = spr_deadBat;
    if (!place_meeting(x, y + 1, obj_wall)) {
        y += 1;
    }
    return;
} else {
    sprite_index = spr_bat; 
}

// Variables for random movement and detection range modification
if (!variable_instance_exists(self, "random_move_timer")) {
    random_move_timer = 0;
}
if (!variable_instance_exists(self, "random_dir_x")) {
    random_dir_x = random_range(-1, 1);
}
if (!variable_instance_exists(self, "random_dir_y")) {
    random_dir_y = random_range(-1, 1);
}
if (!variable_instance_exists(self, "random_move_chance_timer")) {
    random_move_chance_timer = 120; 
}
if (!variable_instance_exists(self, "base_detection_range")) {
    base_detection_range = 1600;
}
if (!variable_instance_exists(self, "detection_range")) {
    detection_range = base_detection_range;
}
if (!variable_instance_exists(self, "detection_range_timer")) {
    detection_range_timer = 0;
}

// Room boundaries
var room_left = 0;
var room_right = room_width;
var room_top = 0;
var room_bottom = room_height;

// Get the distance to the player
var distance_to_player = point_distance(x, y, target.x, target.y);

if (flash > 0) flash--;

/// Function to check line of sight from the bat to the player
function has_line_of_sight(bat_x, bat_y, player_x, player_y) {
    // Check if there is a collision with an obj_wall between the bat and the player
    if (collision_line(bat_x, bat_y, player_x, player_y, obj_wall, true, true) == noone) {
        return true; 
    } else {
        return false; 
    }
}

// Main logic
if (random_move_timer <= 0) {
    // Move to the next direction
    direction_index = (direction_index + 1) % array_length(directions);
    random_move_timer = reconsider; // Reset the timer
}

// Get the current direction
var current_dir_x = lengthdir_x(1, directions[direction_index]);
var current_dir_y = lengthdir_y(1, directions[direction_index]);

// Calculate new position
var new_x = x + current_dir_x * move_speed;
var new_y = y + current_dir_y * move_speed;

// Move in the direction with collision checks
if (place_meeting(new_x, y, obj_wall)) {
    while (place_meeting(new_x, y, obj_wall)) {
        new_x -= sign(current_dir_x);
    }
    current_dir_x = -current_dir_x; // Reverse direction on collision
} else {
    x = new_x;
}

if (place_meeting(x, new_y, obj_wall)) {
    while (place_meeting(x, new_y, obj_wall)) {
        new_y -= sign(current_dir_y);
    }
    current_dir_y = -current_dir_y; // Reverse direction on collision
} else {
    y = new_y;
}

if (distance_to_player <= detection_range/2) && (has_line_of_sight(x, y, obj_player.x, obj_player.y)) {

		attacking_multipier += 0.01;
	
	
    // Get the direction towards the player with some randomness
    var dir_x = (target.x - x);
    var dir_y = (target.y - y);

    // Normalize the direction
    var distance = point_distance(x, y, target.x, target.y);
    if (distance != 0) {
        dir_x /= distance;
        dir_y /= distance;
    }

    // Apply randomness to the direction at every step
    dir_x += random_range(-0.25, 0.25);
    dir_y += random_range(-0.25, 0.25);

    // Normalize the direction again
    var random_distance = point_distance(0, 0, dir_x, dir_y);
    if (random_distance != 0) {
        dir_x /= random_distance;
        dir_y /= random_distance;
    }

    // Move towards the player with collision checks
    var new_x = x + dir_x * move_speed * attacking_multipier;
    var new_y = y + dir_y * move_speed * attacking_multipier;

    // Horizontal Collisions
	if (place_meeting(new_x, y, obj_wall)) {
        while (place_meeting(new_x, y, obj_wall)) {
            new_x -= sign(new_x - x);
        }
        // 1 in 2 chance to move in a perpendicular direction
        if (irandom(1) == 0) {
            var temp = random_dir_x;
            random_dir_x = -random_dir_y;
            random_dir_y = temp;
        } else {
            random_dir_x = -random_dir_x; // Reverse direction on collision
        }
    } else {
        x = new_x;
	}

    // Vertical Collisions
    if (place_meeting(x, new_y, obj_wall)) {
        while (place_meeting(x, new_y, obj_wall)) {
            new_y -= sign(new_y - y);
        }
        // 1 in 2 chance to move in a perpendicular direction
        if (irandom(1) == 0) {
            var temp = random_dir_y;
            random_dir_y = -random_dir_x;
            random_dir_x = temp;
        } else {
            random_dir_y = -random_dir_y; // Reverse direction on collision
        }
    } else {
        y = new_y;
    }
}
else if (!distance_to_player <= detection_range/2) && (!has_line_of_sight(x, y, obj_player.x, obj_player.y)) {
	attacking_multipier = 1;	
}

else if (distance_to_player <= detection_range) {
	
    // Get the direction towards the player with some randomness
    var dir_x = (target.x - x);
    var dir_y = (target.y - y);

    // Normalize the direction
    var distance = point_distance(x, y, target.x, target.y);
    if (distance != 0) {
        dir_x /= distance;
        dir_y /= distance;
    }

    // Apply randomness to the direction at every step
    dir_x += random_range(-0.5, 0.5);
    dir_y += random_range(-0.5, 0.5);

    // Normalize the direction again
    var random_distance = point_distance(0, 0, dir_x, dir_y);
    if (random_distance != 0) {
        dir_x /= random_distance;
        dir_y /= random_distance;
    }

    // Move towards the player with collision checks
    var new_x = x + dir_x * move_speed;
    var new_y = y + dir_y * move_speed;

    // Horizontal Collisions
	if (place_meeting(new_x, y, obj_wall)) {
        while (place_meeting(new_x, y, obj_wall)) {
            new_x -= sign(new_x - x);
        }
        // 1 in 2 chance to move in a perpendicular direction
        if (irandom(1) == 0) {
            var temp = random_dir_x;
            random_dir_x = -random_dir_y;
            random_dir_y = temp;
        } else {
            random_dir_x = -random_dir_x; // Reverse direction on collision
        }
    } else {
        x = new_x;
    }

    // Vertical Collisions
    if (place_meeting(x, new_y, obj_wall)) {
        while (place_meeting(x, new_y, obj_wall)) {
            new_y -= sign(new_y - y);
        }
        // 1 in 2 chance to move in a perpendicular direction
        if (irandom(1) == 0) {
            var temp = random_dir_y;
            random_dir_y = -random_dir_x;
            random_dir_x = temp;
        } else {
            random_dir_y = -random_dir_y; // Reverse direction on collision
        }
    } else {
        y = new_y;
    }
} else {
    // Normal random movement when not aware of the player
if (random_move_timer <= 0) {
	if (direction_index == undefined) {
    direction_index = 0;
	}
    // Move to the next direction
    direction_index = (direction_index + 1) % 6;
    random_move_timer = reconsider; // Reset the timer
}

// Get the current direction
var current_dir_x = directions[direction_index];
var current_dir_y = directions[direction_index];

// Normalize the direction
var random_distance = point_distance(0, 0, current_dir_x, current_dir_y);
if (random_distance != 0) {
    current_dir_x /= random_distance;
    current_dir_y /= random_distance;
}

// Calculate new position
var new_x = x + current_dir_x * move_speed;
var new_y = y + current_dir_y * move_speed;

// Move in the direction with collision checks
if (place_meeting(new_x, y, obj_wall)) {
    while (place_meeting(new_x, y, obj_wall)) {
        new_x -= sign(current_dir_x);
    }
    current_dir_x = -current_dir_x; // Reverse direction on collision
} else {
    x = new_x;
}

if (place_meeting(x, new_y, obj_wall)) {
    while (place_meeting(x, new_y, obj_wall)) {
        new_y -= sign(current_dir_y);
    }
    current_dir_y = -current_dir_y; // Reverse direction on collision
} else {
    y = new_y;
}
}

random_move_timer--;

// Prevent the NPC from moving out of the room
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