x += (x - xTo) / 15;
y += (y - yTo) / 15;

var cam = camera_get_default();
camera_set_view_pos(cam, x, y);