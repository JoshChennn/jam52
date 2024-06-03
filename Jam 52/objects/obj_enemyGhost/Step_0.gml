// If dead, float up
if (hp <= 0) {
	if sprite_index != spr_deadGhost repeat (15) { instance_create_layer(x,y,"Instances", obj_deadParticle); }
    sprite_index = spr_deadGhost;
    y -= 1;
    image_alpha = 0.5;
    return;
} else {
    sprite_index = spr_ghost;
}

// Get the distance to the player
var distance_to_player = point_distance(x, y, obj_player.x, obj_player.y);

if (distance_to_player <= detection_range / 4 && cooldown < 0 && !obj_torch.dreamMode) {
    if (buildup == 100) {
        dir_x = (obj_player.x - x);
        dir_y = (obj_player.y - y);

        // Normalize the direction
        var length = point_distance(0, 0, dir_x, dir_y);
        if (length != 0) {
            dir_x /= length;
            dir_y /= length;
        }
    } else if (buildup > 100) {
        x += dir_x * move_speed * 4;
        y += dir_y * move_speed * 4;

        if (buildup > 130) {
            buildup = 0;
            cooldown = 60;
        }
    }
    buildup++;
} else if (distance_to_player <= detection_range  && !obj_torch.dreamMode) {
    // Get the direction towards the player
    dir_x = (obj_player.x - x);
    dir_y = (obj_player.y - y);

    // Normalize the direction
    var length = point_distance(0, 0, dir_x, dir_y);
    if (length != 0) {
        dir_x /= length;
        dir_y /= length;
    }

    x += dir_x * move_speed;
    y += dir_y * move_speed;
} else {
    if (increment < 0) {
        increment = random_range(20, 80);
        dir_x = random_range(-5, 5);
        dir_y = random_range(-5, 5);

        // Normalize the direction
        var length = point_distance(0, 0, dir_x, dir_y);
        if (length != 0) {
            dir_x /= length;
            dir_y /= length;
        }
    }
    show_debug_message(dir_x);
    // Move in the random direction
    x += dir_x * move_speed;
    y += dir_y * move_speed;
}

// Ensure maximum overlap of 50% with any other obj_ghost
var ghost_list = ds_list_create();
instance_place_list(x, y, obj_enemyGhost, ghost_list, false);

for (var i = 0; i < ds_list_size(ghost_list); i++) {
    var other_ghost = ds_list_find_value(ghost_list, i);
    if (other_ghost != id) {
        var overlap_x = abs(x - other_ghost.x);
        var overlap_y = abs(y - other_ghost.y);
        if (overlap_x < sprite_width / 2 && overlap_y < sprite_height / 2) {
            x += (sprite_width / 2 - overlap_x) / 2 * sign(x - other_ghost.x);
            y += (sprite_height / 2 - overlap_y) / 2 * sign(y - other_ghost.y);
        }
    }
}

ds_list_destroy(ghost_list);

if (dir_x > 0) {
    image_xscale = 1;
} else {
    image_xscale = -1;
}

if (wall_collision(x, y)) {
    image_alpha = 0.5;
    move_speed = 1.5;
} else {
    image_alpha = 1;
    move_speed = 2;
}

cooldown--;

// Prevent the NPC from moving out of the room
if (x < 0) {
    x = 0;
}
if (x > room_width) {
    x = room_width;
}
if (y < 0) {
    y = 0;
}
if (y > room_height) {
    y = room_height;
}

increment--;
flash--;
