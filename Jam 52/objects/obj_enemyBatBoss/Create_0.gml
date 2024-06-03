/// @description Initialization

hp = 300; 
flash = 0; 
move_speed = 1.8; 
horspeed = 0;
verspeed = 0;
image_xscale = 0.7;
image_yscale = 0.7;

hit_cooldown = 0;

reconsider = 60;
increment = random_range(20, 100);

start_loc_x = x;
start_loc_y = y;
attacking_player = false;
attacking_multipier = 1;

detection_range = 2000;

direction_index = random_range(0,4);
directions = [0, 144, 288, 72, 216];

function spawn_enemy_bat(boss_x, boss_y) {
    var spawn_x, spawn_y;

    // Keep trying to find a valid spawn location within 300 units of the boss bat
    repeat (100) {
        spawn_x = random_range(boss_x - 300, boss_x + 300);
        spawn_y = random_range(boss_y - 300, boss_y + 300);

        // Ensure the bat does not spawn inside a wall and is within room bounds
        if (!place_meeting(spawn_x, spawn_y, obj_wall) &&
            spawn_x >= 0 && spawn_x <= room_width &&
            spawn_y >= 0 && spawn_y <= room_height) {
            var new_bat = instance_create_layer(spawn_x, spawn_y, "Instances", obj_enemyBat);
            new_bat.move_speed = 2.5;
			new_bat.detection_range = 1000;
            break;
        }
    }
}

// Set the alarm to trigger in 5 seconds (5 * room_speed frames)
alarm[0] = 60;
