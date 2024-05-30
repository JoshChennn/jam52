/// @description Basic Mechanics

if (flash > 0) flash--;
var move = 1;

// Introduce randomness to horizontal movement
if (irandom(100) < 90) {  // 5% chance to change direction
    move = irandom_range(-1, 1);  // Randomly choose -1, 0, or 1
}

if (hp <= 0) {
    sprite_index = spr_deadSkeleton;
	image_alpha = half_opacity;
	return;
} else {
    sprite_index = spr_skeleton; // Use the appropriate sprite index for alive state
}


var random_jump_chance = irandom(100);

// Calculate movement
horspeed = move * walkspeed;
verspeed = verspeed + grvty;

// Jumping 
if (place_meeting(x, y+1, obj_wall)) {
    if (random_jump_chance < 10) {  // 10% chance to jump
        verspeed -= 7;
    }
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
