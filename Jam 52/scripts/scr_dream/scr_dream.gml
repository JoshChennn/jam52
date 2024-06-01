function scr_dream(size) {
	if (!surface_exists(nightmare)) {
		nightmare = surface_create(room_width,room_height);
	}
	surface_set_target(nightmare);
	gpu_set_blendmode(bm_subtract);
	
	// Subtract the torch light
	draw_sprite_ext(spr_circle,0,obj_player.x,obj_player.y,size,size,0,c_white,1);
	
	surface_reset_target();
	gpu_set_blendmode(bm_normal);
}