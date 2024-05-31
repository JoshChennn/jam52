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
    my_spear.x = x;
    my_spear.y = y;
    my_spear.image_angle = point_direction(x, y, obj_player.x, obj_player.y);

    if (spear_throw_cooldown <= -120) {
        if (!collision_line(x, y, target.x, target.y, obj_wall, true, true)) {
            spear_throw_cooldown = spear_throw_interval;

            // Calculate direction to player
            var dx_to_player = target.x - x;
            var dy_to_player = target.y - y;
            var distance_to_player = point_distance(x, y, target.x, target.y);

            if (distance_to_player > 0) {
                var spear_speed = 5;
                var arc_height = -5;  
                var spear_dir_x = (dx_to_player / distance_to_player) * spear_speed;
                var spear_dir_y = (dy_to_player / distance_to_player) * (spear_speed / 2);

                // Create the arc effect by modifying the initial vertical speed
                spear_dir_y += arc_height;

                // Set the spear's speed
                my_spear.hspeed = spear_dir_x;
                my_spear.vspeed = spear_dir_y;

                // Detach spear from skeleton
                my_spear = noone;
                spear_in_hand = false;
            }
        }
    }
}

spear_throw_cooldown--;

// Calculate direction towards player
var dx_to_player = target.x - x;
var dy_to_player = target.y - y;

// Set horizontal speed to move towards the player
if (dx_to_player > 0) {
    horspeed = walkspeed;
} else if (dx_to_player < 0) {
    horspeed = -walkspeed;
} else {
    horspeed = 0;
}

// Apply gravity
verspeed += grvty;

// Jumping if near player and on the ground
if (place_meeting(x, y + 1, obj_wall)) {
    if (abs(dy_to_player) > 48) {  
        verspeed = -jump_strength;
    }
}

// Horizontal Collisions
if (place_meeting(x + horspeed, y, obj_wall)) {
    while (!place_meeting(x + sign(horspeed), y, obj_wall)) {
        x += sign(horspeed);
    }
    horspeed = 0;
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
