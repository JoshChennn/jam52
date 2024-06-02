/// @description Initialization

hp = 15; 
flash = 0; 
move_speed = 1.5; 
horspeed = 0;
verspeed = 0;

reconsider = 60;
increment = 100;

start_loc_x = x;
start_loc_y = y;
attacking_player = false;
attacking_multipier = 1;

detection_range = 1000;

direction_index = random_range(0,4);
directions = [0, 144, 288, 72, 216];