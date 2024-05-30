/// @description Flash

draw_self();

if (flash > 0) {
	shader_set(shRed);
	draw_self();
	shader_reset();
}