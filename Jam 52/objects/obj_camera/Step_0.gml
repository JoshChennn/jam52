//if (!mouse_check_button(mb_left) or obj_torch.dreamMode) {
	x += (obj_player.x - x) / 25;
	x = clamp(x,960,room_width-960);
	y = 540;
//}

camera_set_view_pos(view_camera[0],x-960,y-540);