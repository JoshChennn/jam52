// If dead, float up
if (hp <= 0) {
    repeat (50) {
		var a = instance_create_layer(x,y,"Instances", obj_deadParticle);
		a.image_blend = $BBBBBB
	}
    instance_destroy();
}

// Get the distance to the player
var distance_to_player = point_distance(x, y, obj_player.x, obj_player.y);

if (distance_to_player <= detection_range / 4 && cooldown < 0) {
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
} else if (distance_to_player <= detection_range) {
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


if (dir_x > 0) {
    image_xscale = 0.3;
} else {
    image_xscale = -0.3;
}

if (invisble_timer < 0) {
	image_alpha = 0.01;
	move_speed = 4;
	if (invisble_timer < -120) {
		move_speed = 2;
		invisble_timer = 240;
	}
} else {
	if (wall_collision(x, y)) {
		image_alpha = 0.5;
		move_speed = 1.5;
	} else {
	    image_alpha = 1;
	    move_speed = 2;
	}
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
invisble_timer --;
