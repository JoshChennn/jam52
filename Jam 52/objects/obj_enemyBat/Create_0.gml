/// @description Initialization

hp = 35; 
flash = 0; 
move_speed = 2.8; 
horspeed = 0;
verspeed = 0;

hit_cooldown = 0;

reconsider = 60;
increment = random_range(20, 100);

start_loc_x = x;
start_loc_y = y;
attacking_player = false;
attacking_multipier = 1;

detection_range = 700;

direction_index = random_range(0,4);
directions = [0, 144, 288, 72, 216];