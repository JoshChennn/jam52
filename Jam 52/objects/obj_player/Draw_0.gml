/// @description Flash


if (flash > 0) {
	draw_sprite_ext(sprite_index, image_index, x, y, draw_xscale, draw_yscale, 0, c_red, 1);
}
else {
	draw_sprite_ext(sprite_index, image_index, x, y, draw_xscale, draw_yscale, 0, c_white, 1);
}