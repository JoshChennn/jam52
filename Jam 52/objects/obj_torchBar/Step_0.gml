if (instance_exists(obj_torch) and obj_torch.dreamMode) {
	time--;
}

if (time <= 0) {
	room_restart();	
}

x = obj_camera.x - 230;
y = obj_camera.y - 450;