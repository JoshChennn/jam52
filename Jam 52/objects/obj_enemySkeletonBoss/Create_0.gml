/// @description Variables 

walkspeed = 2; 
hp = 500;
jump_strength = 22;
grvty = 0.5;
flash = 0;
verspeed = 0;
horspeed = 0;
jump_cooldown = 20;
should_jump = false;
random_timer = 100;
move_direction = 0;
move_time = 0; 
damage = 50;

image_xscale = 0.5;
image_yscale = 0.5;

my_spear = noone;
spear_throw_cooldown = 0;
spear_throw_interval = 60; 
should_throw = false;
spear_in_hand = false;

detection_range = 800;
throw_range = 600;

function throw_strength(how_far_to_player, what_angle) {
    var to_strength = 10;
    var to_angle = 0;
    var to_throw = true;

    // Determine strength based on distance
    if (how_far_to_player > 550) {
        to_strength = 22;
    } else if (how_far_to_player > 500) {
        to_strength = 21;
    } else if (how_far_to_player > 450) {
        to_strength = 20;
    } else if (how_far_to_player > 400) {
        to_strength = 19;
    } else if (how_far_to_player > 350) {
        to_strength = 18;
    } else if (how_far_to_player > 300) {
        to_strength = 17;
    } else if (how_far_to_player > 250) {
        to_strength = 16;
    } else if (how_far_to_player > 200) {
        to_strength = 15;
    } else if (how_far_to_player > 150) {
        to_strength = 14;
    } else {
        to_strength = 12;
    }

    // Determine angle and modify strength based on angle
    if (what_angle < 20) {
        to_angle = 40;
    } else if (what_angle < 50) {
        to_angle = 45;
        to_strength *= 1.5;
    } else if (what_angle < 120) {
        to_throw = false;
    } else if (what_angle < 160) {
        to_angle = 105;
        to_strength *= 1.3;
    } else if (what_angle < 180) {
        to_angle = 120;
    } else if (what_angle < 220) {
        to_angle = 115;
    } else if (what_angle < 320) {
        to_throw = false;
    } else if (what_angle < 360) {
        to_angle = 5;
    }

    // Adjust angle if player is close
	if (how_far_to_player < 100) {
	    if (what_angle < 90 || what_angle > 270) {
	        to_angle = 20;
	    } else if (what_angle >= 90 && what_angle <= 270) {
	        to_angle = 160; 
	    }
	}


    return [to_strength, to_angle, to_throw];
}
