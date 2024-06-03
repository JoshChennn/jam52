obj_torch.dreamMode = !obj_torch.dreamMode;
if obj_torch.dreamMode {
	with obj_wallDream sprite_index = spr_wallDream;
}
else with obj_wall sprite_index = spr_wall;
if (obj_torch.dreamMode and position_meeting(x,y-41,obj_wallDream)) {
	with obj_wallDream {
		if place_meeting(x,y,obj_player) {
			flash = 1;
		}
	}
	obj_torch.dreamMode = !obj_torch.dreamMode;
}
else if (!obj_torch.dreamMode and position_meeting(x,y-41,obj_wall)) {
	with obj_wall {
		if place_meeting(x,y,obj_player) {
			flash = 1;
		}
	}
	obj_torch.dreamMode = !obj_torch.dreamMode;
}

//scr_switch();