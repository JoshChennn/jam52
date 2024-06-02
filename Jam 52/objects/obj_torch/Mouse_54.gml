dreamMode = !dreamMode;
with(obj_player) {
	var closest = 0;
	if other.dreamMode {
		closest = instance_nearest(x,y-41,obj_wallDream);
	}
	else {
		closest = instance_nearest(x,y-41,obj_wall);
	}
	if wall_collision(x,y) {
		if point_distance(x,y-41,closest.x,closest.y) > 50 {
			var move_dir = point_direction(closest.x,closest.y,x,y-41);
			while place_meeting(x,y,closest) {
				x += lengthdir_x(1,move_dir);
				y += lengthdir_y(1,move_dir);
				show_debug_message("Womp Womp");
			}
		}
		else {
			room_restart();
		}
	}
}