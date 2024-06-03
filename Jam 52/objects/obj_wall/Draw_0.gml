draw_self();

if flash != 0 {
	draw_sprite_ext(spr_wall,0,x,y,image_xscale,image_yscale,0,c_red,flash);
}