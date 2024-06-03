if obj_torch.dreamMode {
	image_index = 1;
}
else {
	image_index = 0;
}
if (obj_torch.dreamMode and start_mode > 0) or (!obj_torch.dreamMode and (start_mode == 0 or start_mode == 2)) depth = -100;
else depth = 100;
if !instance_exists(obj_allEnemies) and startY == y and obj_camera.x >= room_width-960 moving = true;
if moving {
	y -= 2;
	obj_camera.shake = 8;
	if y <= startY-256 {
		y = startY-256;
		moving = false;
	}
}