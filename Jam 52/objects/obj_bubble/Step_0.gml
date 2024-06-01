if floating {
	if obj_player.in_bubble {
		var hinput = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
		var vinput = (keyboard_check(vk_down) || keyboard_check(ord("S"))) - (keyboard_check(vk_up) || keyboard_check(ord("W")));
		var hacc = 0;
		var vacc = 0;
		if hinput != 0 or vinput != 0 {
			hacc = lengthdir_x(0.2,point_direction(0,0,hinput,vinput));
			vacc = lengthdir_y(0.2,point_direction(0,0,hinput,vinput));
			hsp += hacc;
			vsp += vacc;
			if point_distance(0,0,hsp,vsp) > 15 {
				var move_dir = point_direction(0,0,hsp,vsp);
				hsp = lengthdir_x(15,move_dir);
				vsp = lengthdir_y(15,move_dir);
			}
		}
	}
	hsp *= 0.97;
	vsp *= 0.97;
	if point_distance(0,0,hsp,vsp) < 0.05 {
		hsp = 0;
		vsp = 0;
	}
	x += hsp;
	y += vsp;
	if obj_player.in_bubble {
		obj_player.x = x;
		obj_player.y = y;
	}
}