/// @description Basic Mechanics
if(keyboard_check(ord("R"))) { room_restart(); }

// Get player input
var key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var key_jump = keyboard_check(vk_up) || keyboard_check(ord("W"));

// Calculate movement
var move = key_right - key_left;
horspeed = move * walkspeed;
verspeed = verspeed + grvty;

// Check for wall collision on left and right
var wall_left = wall_collision(x - 1, y);
var wall_right = wall_collision(x + 1, y);

// Jumping 
if (wall_collision(x, y + 1)) {
	if (key_jump) {
	    verspeed = jump_height;
		draw_yscale = 1.5;
		draw_xscale = .75*image_xscale;
	}
}
with obj_airPlatform {
	if x-100 < other.x and x+100 > other.x and other.y < y and other.y > y-400 other.verspeed -= 0.8;
}

// Horizontal Collisions
if (wall_collision(x + horspeed, y)) {
	while (!wall_collision(x + sign(horspeed), y)) {
	    x = x + sign(horspeed);
	}
	horspeed = 0;
}

x = x + horspeed;

// Vertical Collisions
if (wall_collision(x, y + verspeed)) {
	while (!wall_collision(x, y + sign(verspeed))) {
	    y = y + sign(verspeed);
	}
	verspeed = 0;
}

y = y + verspeed;

if horspeed == 0 {
	squash_x = 1.1;
	squash_y = 0.95;
}
else {
	squash_x = 1;
	squash_y = 1;
}

if (wall_collision(x,y+1) and !wall_collision(x,yprevious+1)) {
	draw_yscale = .65; 
	draw_xscale = 1.4*image_xscale;
	repeat (20)  { 
		var a = instance_create_layer(x+random_range(-20,20),y-5,"Instances",obj_groundParticle); 
		a.direction = random(20)+choose(0,160);
	}
}

// Setting animation and sprite direction

if (move != 0 and wall_collision(x,y+3)) {
	sprite_index = spr_playerWalking;
	if irandom(2) == 0 {
		var a = instance_create_layer(x+random_range(-20,20),y-5,"Instances",obj_groundParticle);
		a.direction = random(20)+(image_xscale == 1 ? 160 : 0);
	}
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

draw_xscale = lerp(draw_xscale, image_xscale*squash_x, .09);
draw_yscale = lerp(draw_yscale, squash_y, .09);

if (flash > 0) flash--;

if (hp <= 0) room_goto(0);