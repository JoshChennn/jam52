x += (obj_player.x - x) / 25;
x = clamp(x,960,room_width-960);
y += (obj_player.y - y) / 25;
y = clamp(y,540,room_height-540);

camera_set_view_pos(view_camera[0],x-960 + random_range(-shake,shake),y-540+random_range(-shake,shake));

shake *= 0.9;