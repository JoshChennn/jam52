/// @description Basic Mechanics

if (hp <= 0) {
    // Handle the skeleton's death state
    sprite_index = spr_deadSkeleton;
    image_alpha = 0.5; // Set to half opacity
    if (my_spear != noone) {
        if (spear_in_hand) {
            instance_destroy(my_spear); // Destroy the spear if it's in hand
        }
    }
    while (!wall_collision(x, y + 1)) {
        y += 1; // Make the skeleton fall to the ground
    }
    return;
} else {
    sprite_index = spr_skeleton; // Set to the alive skeleton sprite
}

if (flash > 0) flash--; // Decrease flash counter if it's greater than 0

// Manage spear creation and throwing
if (!spear_in_hand) {
    if (spear_throw_cooldown <= 0) {
        my_spear = instance_create_depth(x, y, depth - 1, obj_improvedSpear); // Create spear
        spear_in_hand = true; // Set spear in hand
    }
}

if (spear_in_hand) {
    // Update spear direction and position to follow the player
    my_spear.image_angle = point_direction(x, y, obj_player.x, obj_player.y);
    my_spear.x = x;
    my_spear.y = y - 10;

    // Handle spear throwing
    if (spear_throw_cooldown <= -120) {
        if (!collision_line(x, y, obj_player.x, obj_player.y, obj_wall, true, true)) {
            spear_throw_cooldown = random_range(60, spear_throw_interval); // Reset cooldown

            var distance_to_player = point_distance(x, y, obj_player.x, obj_player.y);
			var angle_to_player = point_direction(x, y, obj_player.x, obj_player.y);
			
			my_spear.fast = abs((obj_player.x - x)) / 25;
			
			if (distance_to_player > 0)
			if (obj_player.x - x > 0) {
				my_spear.angle = 45;
			} else {
				my_spear.angle = 115;
			}
			my_spear.should_shoot = true;
            
            // Detach spear from skeleton
            my_spear = noone;
            spear_in_hand = false;
        }
    }
}

spear_throw_cooldown--; // Decrease cooldown counter

if (jump_cooldown > 0) { jump_strength = 0; }
else { jump_strength = 10; }
jump_cooldown --;

// Variables for movement decision
if (!variable_instance_exists(self, "decision_timer")) {
    decision_timer = 0;
}
if (!variable_instance_exists(self, "random_movement")) {
    random_movement = false;
}

if (wall_collision(x + horspeed, y)) {
    verspeed = -jump_strength;
	jump_strength = 0;
	jump_cooldown = 60;
    horspeed = sign(horspeed) * walkspeed;
}

// Decide direction and whether to jump every 0.5 seconds
if (decision_timer <= 0) {
    decision_timer = 30;
    
    // Calculate direction towards player
    var dx_to_player = target.x - x;
    var dy_to_player = target.y - y;
    far_away_randomness = (dx_to_player > 400) && (dy_to_player > 400) ? 10 : 5;
    
    if (random_range(0, far_away_randomness) > 4) {
        random_movement = true;
        horspeed = random_range(-walkspeed, walkspeed);
        
        if (random_range(0, 3) > 2) {
            verspeed = -jump_strength;
            jump_strength = 0;
            jump_cooldown = 60;
        } else {
            verspeed = 0;
        }
    } else {
        random_movement = false;
        
        // Set horizontal speed to move towards the player
        if (dx_to_player > 0) {
            horspeed = walkspeed;
        } else if (dx_to_player < 0) {
            horspeed = -walkspeed;
        } else {
            horspeed = 0;
        }
        
        // Jumping if near player and on the ground
        if (wall_collision(x, y + 1) && abs(dy_to_player) > 48) {
            verspeed = -jump_strength;
            jump_strength = 0;
            jump_cooldown = 60;
        } else {
            verspeed = 0;
        }
    }

    // Avoid other skeletons within a distance of 30
    var nearest_skeleton = instance_nearest(x, y, obj_enemySkeleton);
    if (nearest_skeleton != noone && nearest_skeleton != self) {
        var distance_to_skeleton = point_distance(x, y, nearest_skeleton.x, nearest_skeleton.y);
        if (distance_to_skeleton < 30) {
            if (irandom(4) < 1) {
                var dir_away_x = x - nearest_skeleton.x;
                var dir_away_y = y - nearest_skeleton.y;

                // Normalize the direction away from the other skeleton
                var distance_away = point_distance(0, 0, dir_away_x, dir_away_y);
                if (distance_away != 0) {
                    dir_away_x /= distance_away;
                    dir_away_y /= distance_away;
                }

                // Adjust horizontal and vertical speed to move away from the other skeleton
                horspeed = dir_away_x * walkspeed;
                verspeed = dir_away_y * jump_strength;

                random_movement = true;
            }
        }
    }
} else {
    decision_timer--;
}


// Apply gravity
verspeed += grvty;

// Horizontal Collisions
if (wall_collision(x + horspeed, y)) {
    while (!wall_collision(x + sign(horspeed), y)) {
        x += sign(horspeed);
    }
    // Try to jump over the wall
    verspeed = -jump_strength;
	jump_strength = 0;
	jump_cooldown = 60;
    horspeed = sign(horspeed) * walkspeed;
    if (wall_collision(x + horspeed, y)) {
        // If still colliding, turn around
        horspeed = 0;
    }
}

x += horspeed;

// Vertical Collisions
if (wall_collision(x, y + verspeed)) {
    while (!wall_collision(x, y + sign(verspeed))) {
        y += sign(verspeed);
    }
    verspeed = 0;
}
if wall_collision(x,y+1) and !wall_collision(x,yprevious+1) {
	repeat (20)  { 
		var a = instance_create_layer(x+random_range(-20,20),y+27,"Instances",obj_groundParticle); 
		a.direction = random(20)+choose(0,160);
	}
}
if horspeed != 0 and wall_collision(x,y+1) {
	if irandom(2) == 0 {
		var a = instance_create_layer(x+random_range(-20,20),y+27,"Instances",obj_groundParticle);
		a.direction = random(20)+(image_xscale == 1 ? 160 : 0);
	}
}

y += verspeed;
