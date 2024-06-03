if (!surface_exists(nightmare)) {
	nightmare = surface_create(room_width,room_height);
}
draw_surface(nightmare,0,0);

surface_set_target(nightmare);
draw_sprite(spr_backgroundNightmare,0,obj_camera.x-960,obj_camera.y-540);
surface_reset_target();