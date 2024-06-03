/// @description Declare Variables on Creation

has_wall_jumped_left = false;
has_wall_jumped_right = false;
jump_height = -10; 
grvty = 0.5;
horspeed = 0;
verspeed = 0;
walkspeed = 5;
hp = 400;
flash = 0;
squash_x =  1;
squash_y = 1;
closest = 0;

dead = false;

draw_xscale = 1;
draw_yscale = 1;

instance_create_depth(x,y,depth+1,obj_torch);
instance_create_depth(x,y,depth-2,obj_flamethrower);