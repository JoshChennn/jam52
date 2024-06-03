function scr_surfaceLayer(){	
	if event_type == ev_draw
    {
        if (event_number == 0)
        {
            if (!surface_exists(nightmare)) {
				nightmare = surface_create(room_width,room_height);
			}
			surface_set_target(nightmare);
        }
    }
}