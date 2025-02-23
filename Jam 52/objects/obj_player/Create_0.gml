/// @description Declare Variables on Creation

has_wall_jumped_left = false;
has_wall_jumped_right = false;
jump_height = -10; 
grvty = 0.5;
horspeed = 0;
verspeed = 0;
walkspeed = 5;
hp = 150;
flash = 0;
squash_x =  1;
squash_y = 1;
closest = 0;

if (room == rm_bossGhost1) {
	hp = 300;
} else if (room == rm_bossSkeleton || room == rm_bossBat) {
	hp = 500;
}

if room != rm_tutorial and room != rm_thanks and !instance_exists(obj_torchBar) instance_create_depth(x,y,-1000,obj_torchBar);

dead = false;

draw_xscale = 1;
draw_yscale = 1;

instance_create_depth(x,y,depth+1,obj_torch);
instance_create_depth(x,y,depth-2,obj_flamethrower);