function scr_surfaceLayer(){
	if (!surface_exists(nightmare)) {
		nightmare = surface_create(room_width,room_height);
	}
	surface_set_target(nightmare);
}