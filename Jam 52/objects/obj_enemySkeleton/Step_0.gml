/// @description Basic Mechanics

if (hp <= 0) {
    sprite_index = spr_deadSkeleton;
    image_alpha = half_opacity;
    if (my_spear != noone) {
        if (spear_in_hand) {
            instance_destroy(my_spear);
        }
    }
    while (!place_meeting(x, y + 1, obj_wall)) {
        y = y + 1;
    }
    return;
} else {
    sprite_index = spr_skeleton;
}

if (flash > 0) flash--;

// Manage spear creation and throwing
if (!spear_in_hand) {
    if (spear_throw_cooldown <= 0) {
        my_spear = instance_create_layer(x, y, "Spears", obj_skeletonSpear);
        spear_in_hand = true;
    }
}

if (spear_in_hand) {
    my_spear.image_angle = point_direction(x, y, obj_player.x, obj_player.y);
    my_spear.x = x;
    my_spear.y = y - 10;

    if (spear_throw_cooldown <= -120) {
        if (!collision_line(x, y, target.x, target.y, obj_wall, true, true)) {
            spear_throw_cooldown = random_range(60, spear_throw_interval);

            var dx_to_player = target.x - x;
            var dy_to_player = target.y - y;
            var distance_to_player = point_distance(x, y, target.x, target.y);

            if (distance_to_player > 150) {
                my_spear.speed = 12;
                my_spear.gravity = 0.05;
                my_spear.resistance = 0.1;
                my_spear.direction = point_direction(x, y, target.x, target.y) - 15;
                my_spear.hspeed = lengthdir_x(my_spear.speed, my_spear.direction) / 1.8;
                my_spear.vspeed = lengthdir_y(my_spear.speed, my_spear.direction) / 1.8;

                // Detach spear from skeleton
                my_spear = noone;
                spear_in_hand = false;
            } else if (distance_to_player > 0) {
                my_spear.speed = 12;
                my_spear.gravity = 0.05;
                my_spear.resistance = 0.1;
                my_spear.direction = point_direction(x, y, target.x, target.y);
                my_spear.hspeed = lengthdir_x(my_spear.speed, my_spear.direction) / 1.8;
                my_spear.vspeed = lengthdir_y(my_spear.speed, my_spear.direction) / 1.8;

                // Detach spear from skeleton
                my_spear = noone;
                spear_in_hand = false;
            }
        }
    }
}

spear_throw_cooldown--;

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

if (place_meeting(x + horspeed, y, obj_wall)) {
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
        if (place_meeting(x, y + 1, obj_wall) && abs(dy_to_player) > 48) {
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
if (place_meeting(x + horspeed, y, obj_wall)) {
    while (!place_meeting(x + sign(horspeed), y, obj_wall)) {
        x += sign(horspeed);
    }
    // Try to jump over the wall
    verspeed = -jump_strength;
	jump_strength = 0;
	jump_cooldown = 60;
    horspeed = sign(horspeed) * walkspeed;
    if (place_meeting(x + horspeed, y, obj_wall)) {
        // If still colliding, turn around
        horspeed = 0;
    }
}

x += horspeed;

// Vertical Collisions
if (place_meeting(x, y + verspeed, obj_wall)) {
    while (!place_meeting(x, y + sign(verspeed), obj_wall)) {
        y += sign(verspeed);
    }
    verspeed = 0;
}

y += verspeed;
