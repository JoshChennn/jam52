/// @description Basic Mechanics

// Get player input
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_jump = keyboard_check_pressed(vk_space) || keyboard_check(ord("W"));

if (keyboard_check(ord("R"))) game_restart();

if (flash > 0) flash--;

if (hp <= 0) room_goto(0);

// Calculate movement
var move = key_right - key_left;
horspeed = move * walkspeed;
verspeed = verspeed + grvty;

// Check for wall collision on left and right
var wall_left = place_meeting(x - 1, y, obj_wall);
var wall_right = place_meeting(x + 1, y, obj_wall);

// Jumping 
if (place_meeting(x, y + 1, obj_wall)) {
    if (key_jump) {
        verspeed = jump_height;
    }
    // Reset wall jump flags upon landing
    has_wall_jumped_left = false;
    has_wall_jumped_right = false;
} else if (key_jump) {
    if (wall_left && !has_wall_jumped_left) {
        verspeed = jump_height;
        horspeed = 5; // Push the player away from the left wall
        has_wall_jumped_left = true; // Mark wall jump as used on the left side
    } else if (wall_right && !has_wall_jumped_right) {
        verspeed = jump_height;
        horspeed = -5; // Push the player away from the right wall
        has_wall_jumped_right = true; // Mark wall jump as used on the right side
    }
}

// Horizontal Collisions
if (place_meeting(x + horspeed, y, obj_wall)) {
    while (!place_meeting(x + sign(horspeed), y, obj_wall)) {
        x = x + sign(horspeed);
    }
    horspeed = 0;
}

x = x + horspeed;

// Vertical Collisions
if (place_meeting(x, y + verspeed, obj_wall)) {
    while (!place_meeting(x, y + sign(verspeed), obj_wall)) {
        y = y + sign(verspeed);
    }
    verspeed = 0;
}

y = y + verspeed;
