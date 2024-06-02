function scr_surfaces() {
	if (!surface_exists(nightmare)) {
		nightmare = surface_create(room_width,room_height);
	}
	surface_set_target(nightmare);
	
	switch (object_index) {
		// for each object that changes, draw the nightmare-state sprite
		case obj_enemyBat:
			draw_sprite(spr_bat,image_index,x,y);
			break;
	}
	
	surface_reset_target();
}