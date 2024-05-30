/// @description Mechanics

if (hp <= 0) {
    sprite_index = spr_deadBat;
    if (!place_meeting(x, y + 1, obj_wall)) {
        y += 1;
    }
    return;
} else {
    sprite_index = spr_bat; // Use the appropriate sprite index for alive state
}

// Variable declarations
if (!variable_global_exists("dir_x")) {
    global.dir_x = 1;
    global.dir_y = 1;
}
if (!variable_global_exists("change_time")) {
    global.change_time = 30;
}

// Directions to player with added randomness at every step
global.change_time--;
if (global.change_time <= 0) {
    global.change_time = 60;
    global.dir_x = target.x - x;
    global.dir_y = target.y - y;

    // Normalize the direction
    var distance = point_distance(x, y, x + global.dir_x, y + global.dir_y);
    if (distance != 0) {
        global.dir_x /= distance;
        global.dir_y /= distance;
    }
}

// Apply randomness to the direction at every step
global.dir_x += random_range(-0.25, 0.25);
global.dir_y += random_range(-0.25, 0.25);

// Normalize the direction again
var distance = point_distance(0, 0, global.dir_x, global.dir_y);
if (distance != 0) {
    global.dir_x /= distance;
    global.dir_y /= distance;
}

if (flash > 0) flash--;

// Move towards the player with collision checks
var new_x = x + global.dir_x * move_speed;
var new_y = y + global.dir_y * move_speed;

// Horizontal Collisions
if (place_meeting(new_x, y, obj_wall)) {
    while (place_meeting(new_x, y, obj_wall)) {
        new_x -= sign(global.dir_x);
    }
    global.dir_x = -global.dir_x; // Reverse direction on collision
} else {
    x = new_x;
}

// Vertical Collisions
if (place_meeting(x, new_y, obj_wall)) {
    while (place_meeting(x, new_y, obj_wall)) {
        new_y -= sign(global.dir_y);
    }
    global.dir_y = -global.dir_y; // Reverse direction on collision
} else {
    y = new_y;
}
