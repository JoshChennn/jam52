/// @description Variables 

// Initialize variables
target = obj_player;
move_speed = 2; 
hp = 20;
max_overlap = 5; 
normal_opacity = 1;
half_opacity = 0.5;
flash = 0; 
detection_range = 500;
increase_in_detection_range = 10;
frequency_of_increase = 3; // 1/frequency_of_increase
base_detection_range = 1000;
increase_time = 4; 

// Pathfinding variables
path = ds_list_create();
current_node = 0;
path_update_timer = 0;

// Random movement variables
random_offset_x = random_range(-20, 20);
random_offset_y = random_range(-20, 20);
random_move_timer = 0;
random_dir_x = random_range(-1, 1);
random_dir_y = random_range(-1, 1);
random_move_chance_timer = 120; // 2 seconds at 60 fps

// Detection range modification variables
detection_range = base_detection_range;
detection_range_timer = 0;
