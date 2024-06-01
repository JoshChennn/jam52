/// @description Insert description here
// You can write your code in this editor

hit_wall = true;
if (random_range(0,5) > 3) {
	instance_create_depth(x,y,depth+random_range(-1,1),obj_smoke);
}