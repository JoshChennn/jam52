// If bat dies, it falls to ground
if (hp <= 0) {
	repeat (15) { 
		var a = instance_create_layer(x,y,"Instances", obj_deadParticle);
		a.image_blend = $353535
	}
    instance_destroy();
}

function has_line_of_sight(bat_x, bat_y, player_x, player_y) {
    if (collision_line(bat_x, bat_y, player_x, player_y - 30, obj_wall, true, true) == noone) {
        return true; 
    } else {
        return false; 
    }
}

var distance_to_player = point_distance(x, y, obj_player.x, obj_player.y);

if (distance_to_player < detection_range / 4 && has_line_of_sight(x, y, obj_player.x, obj_player.y)) {
    show_debug_message("I see you");
	
	if (attacking_multipier < 2) {
		attacking_multipier += 0.1;
	}
    
    increment = 0;
    // find player direction
    var dir_x = (obj_player.x - x);
    var dir_y = (obj_player.y - y);
    // normalize (turn to magnitude of 1)
    var distance = point_distance(x, y, obj_player.x, obj_player.y);
    if (distance != 0) {
        dir_x /= distance;
        dir_y /= distance;
    }
	
	    // Apply randomness to the direction
    dir_x += random_range(-0.25, 0.25);
    dir_y += random_range(-0.25, 0.25);

    // Normalize the direction again
    var random_distance = point_distance(0, 0, dir_x, dir_y);
    if (random_distance != 0) {
        dir_x /= random_distance;
        dir_y /= random_distance;
    }
        
    var new_x = x + dir_x * move_speed * attacking_multipier;
    var new_y = y + dir_y * move_speed * attacking_multipier;
    
	if (hit_cooldown > 0) {
		if (wall_collision(x - dir_x * move_speed * attacking_multipier, y)) {
	        x = new_x;
			hit_cooldown = -1;
	    } else { x = x - dir_x * move_speed * attacking_multipier; }

	    if (wall_collision(x, y - dir_y * move_speed * attacking_multipier)) {
	      y = new_y;
		  hit_cooldown = -1;
	    } else { y =  y - dir_y * move_speed * attacking_multipier; }
	}
	else {
	    if (wall_collision(new_x, y)) {
	        x = x - dir_x * move_speed * attacking_multipier;  
	    } else {
	        x = new_x;
	    }

	    if (wall_collision(x, new_y)) {
	        y =  y - dir_y * move_speed * attacking_multipier; 
	    } else {
	        y = new_y;
	    }
	}
	
} else if (distance_to_player < detection_range) {
	if (attacking_multipier > 1) { attacking_multipier -= 0.05; }

    // find player direction
    var dir_x = (obj_player.x - x);
    var dir_y = (obj_player.y - y);
    // normalize (turn to magnitude of 1)
    var distance = point_distance(x, y, obj_player.x, obj_player.y);
    if (distance != 0) {
        dir_x /= distance;
        dir_y /= distance;
    }
	
	// Apply randomness to the direction
    dir_x += random_range(-0.5, 0.5);
    dir_y += random_range(-0.5, 0.5);

    // Normalize the direction again
    var random_distance = point_distance(0, 0, dir_x, dir_y);
    if (random_distance != 0) {
        dir_x /= random_distance;
        dir_y /= random_distance;
    }
        
    var new_x = x + dir_x * move_speed * attacking_multipier;
    var new_y = y + dir_y * move_speed * attacking_multipier;
        
    if (wall_collision(new_x, y)) {
        x = x - dir_x * move_speed * attacking_multipier; 
    } else {
        x = new_x;
    }

    if (wall_collision(x, new_y)) {
        y = y - dir_y * move_speed * attacking_multipier; 
    } else {
        y = new_y;
    }
} 

// Main logic
if (increment <= 0) {
    // Move to the next direction
    direction_index = (direction_index + 1) % array_length(directions);
    increment = random_range(40,80); 
}

// If the player is not within detection range
if (distance_to_player > detection_range) {
	if (attacking_multipier > 1) { attacking_multipier -= 0.05; }
	
    var angle = directions[direction_index];
    var current_dir_x = cos(degtorad(angle));
    var current_dir_y = sin(degtorad(angle));
    
    // Calculate new position
    var new_x = x + current_dir_x * move_speed;
    var new_y = y + current_dir_y * move_speed;

    // Move in the direction with collision checks
    if (wall_collision(new_x, y)) {
        // Invert direction if there's a collision
        current_dir_x = -current_dir_x; 
    } else {
        x = new_x;
    }

    if (wall_collision(x, new_y)) {
        // Invert direction if there's a collision
        current_dir_y = -current_dir_y; 
    } else {
        y = new_y;
    }
}

increment--;
flash --;
hit_cooldown --;

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
