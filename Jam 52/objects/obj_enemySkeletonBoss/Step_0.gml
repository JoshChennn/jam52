// If dead
if (hp <= 0) {
    sprite_index = spr_deadSkeleton;
    image_alpha = 0.5; 
    if (my_spear != noone) {
        if (spear_in_hand) {
            instance_destroy(my_spear); 
        }
    }
    while (!wall_collision(x, y + 1)) {
        y += 1; 
    }
    return;
} else {
    sprite_index = spr_skeletonBoss; // Set to the alive skeleton sprite
}

var distance_to_player = point_distance(x, y, obj_player.x, obj_player.y);

if (distance_to_player < detection_range && !obj_torch.dreamMode) {
    if (obj_player.x - x > 0) {
        horspeed = 2;
        
        // avoid jumping off cliffs
        if (!wall_collision(x + 50, y + 200)) {
            horspeed = 0;
        }
        // if there is a barrier, jump
        if (wall_collision(x + 40, y) && !wall_collision(x + 40, y - 150)) {
            should_jump = true;
        }
    } else { 
        horspeed = -2;
        
        if (!wall_collision(x - 50, y + 200)) {
            horspeed = 0;
        }
        if (wall_collision(x - 40, y) && !wall_collision(x - 40, y - 150)) {
            should_jump = true;
        }
    }
} else {
    if (move_time <= 0) {
        move_direction = choose(-1, 1); 
        move_time = irandom_range(40, 120);
    }
	
	if (move_direction > 0) {
		// avoid cliffs
	    if (!wall_collision(x + 50, y + 200)) {
            horspeed = 0;
        }
        // if there is a barrier, jump
        if (wall_collision(x + 40, y) && !wall_collision(x + 40, y - 150)) {
            should_jump = true;
        }
	} else {
		if (!wall_collision(x - 50, y + 200)) {
            horspeed = 0;
        }
        if (wall_collision(x - 40, y) && !wall_collision(x - 40, y - 150)) {
            should_jump = true;
        }
	}
	
    horspeed = 2 * move_direction;

    move_time--;
}

if (distance_to_player < throw_range) {
	should_throw = true;
}

if (!my_spear) spear_in_hand = false;

if (spear_in_hand) {
    // Update spear direction and position to follow the player
	if(!obj_torch.dreamMode) {
	    my_spear.image_angle = point_direction(x, y, obj_player.x, obj_player.y);
	} else {
		if (move_direction > 0) {
			my_spear.image_angle = 0;
		} else { my_spear.image_angle = 180; }
	}
    my_spear.x = x;
    my_spear.y = y - 10;
	
	if (spear_throw_cooldown <= -40) {
		if (obj_torch.dreamMode) {
			should_throw = false;
		}
        if (should_throw) {
            spear_throw_cooldown = random_range(10, spear_throw_interval); // Reset cooldown

			var angle_to_player = point_direction(x, y, obj_player.x, obj_player.y);
			
			to_do = throw_strength(distance_to_player, angle_to_player);
			my_spear.fast = to_do[0];
			my_spear.angle = to_do[1];
			my_spear.should_shoot = to_do[2];
			show_debug_message(to_do);
			
			if (to_do[2]) {
	            // Detach spear from skeleton
	            my_spear = noone;
	            spear_in_hand = false;
			}
        }
	}
} else {
	if (spear_throw_cooldown <= 0) {
		my_spear = instance_create_depth(x, y, depth - 1, obj_improvedSpear);
		my_spear.image_xscale = 2.5;
		my_spear.image_yscale = 2.5;
		my_spear.damage = 10;
		spear_in_hand = true;
	}
}

if (should_jump && jump_cooldown < 0) {
	verspeed = -jump_strength;
	should_jump = false;
	jump_cooldown = 60;
}

if (wall_collision(x + horspeed, y)) {
    while (!wall_collision(x + sign(horspeed), y)) {
        x += sign(horspeed);
    }
    if (wall_collision(x + horspeed, y)) {
        horspeed = 0;
    }
}

if (wall_collision(x, y + verspeed)) {
    while (!wall_collision(x, y + sign(verspeed))) {
        y += sign(verspeed);
    }
    verspeed = 0;
}

x += horspeed;
y += verspeed;

spear_throw_cooldown--;
jump_cooldown --;
flash--;
verspeed += grvty;

