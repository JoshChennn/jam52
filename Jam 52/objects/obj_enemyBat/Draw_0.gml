/// @description Flash
draw_self();

if (flash > 0) && (hp > 0) {
	shader_set(shWhite);
	draw_self();
	shader_reset();
}

depth = -1010;
scr_surfaces();
depth = 200;