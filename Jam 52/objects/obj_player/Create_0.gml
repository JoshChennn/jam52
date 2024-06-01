/// @description Declare Variables on Creation

has_wall_jumped_left = false;
has_wall_jumped_right = false;
jump_height = -10; 
grvty = 0.5;
horspeed = 0;
verspeed = 0;
walkspeed = 5;
hp = 30;
flash = 0;
in_bubble = false;

instance_create_depth(x,y,depth+1,obj_torch);
instance_create_layer(x,y,"Gun",obj_flamethrower);