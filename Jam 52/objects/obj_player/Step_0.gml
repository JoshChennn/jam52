/// @description Basic Mechanics
if(keyboard_check(ord("R"))) { game_restart(); }

// Get player input
var key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var key_jump = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));

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
		draw_yscale = 1.5;
		draw_xscale = .75;
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

if (place_meeting(x,y+1,obj_wall) and !place_meeting(x,yprevious+1,obj_wall)) {
	draw_yscale = .75; 
	draw_xscale = 1.25;
}

// Setting animation and sprite direction

if (move != 0 and place_meeting(x,y+3,obj_wall)) {
	sprite_index = spr_playerWalking;
}
else {
	sprite_index = spr_player;
}

if (horspeed > 0) {
	image_xscale = 1;
	draw_xscale = abs(draw_xscale);
}
else if (horspeed < 0) {
	image_xscale = -1;
	draw_xscale = -abs(draw_xscale);
}

draw_xscale = lerp(draw_xscale, image_xscale, .1);
draw_yscale = lerp(draw_yscale, 1, .1);

if (flash > 0) flash--;

if (hp <= 0) room_goto(0);