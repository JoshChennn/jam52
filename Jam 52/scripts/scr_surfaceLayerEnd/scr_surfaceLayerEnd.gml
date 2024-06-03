function scr_surfaceLayerEnd() {
	draw_sprite(spr_player,0,0,0);
	if surface_get_target() == nightmare surface_reset_target();
}