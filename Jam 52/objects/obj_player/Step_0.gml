/// @description Basic Mechanics

// Get player input
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_jump = keyboard_check_pressed(vk_space) || keyboard_check(ord("W"));

// Calculate movement
var move = key_right - key_left;
horspeed = move * walkspeed;
verspeed = verspeed + grvty;


// Jumping 
if (place_meeting(x, y+1, obj_wall) && key_jump) {
	verspeed -= 7;
}

// Horizontal Collisions
if(place_meeting(x+horspeed, y, obj_wall)) {
	while(!place_meeting(x+sign(horspeed), y, obj_wall)) {
		x = x + sign(horspeed);
	}
	horspeed = 0;
}

x = x + horspeed;

// Vertical Collisions
if(place_meeting(x, y+verspeed, obj_wall)) {
	while(!place_meeting(x, y+sign(verspeed), obj_wall)) {
		y = y + sign(verspeed);
	}
	verspeed = 0;
}

y = y + verspeed;