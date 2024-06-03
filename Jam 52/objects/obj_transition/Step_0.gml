image_alpha += fade_rate;
x = camera_get_view_x(view_camera[0]);
y = camera_get_view_y(view_camera[0]);
if fade_rate < 0 and image_alpha <= 0 {
	fade_rate = 0;
	image_alpha = 0;
}
if fade_rate > 0 and image_alpha >= 1 {
	fade_rate *= -1;
	image_alpha = 1;
	if moving_on room_goto_next();
	else room_restart();
	moving_on = false;
}