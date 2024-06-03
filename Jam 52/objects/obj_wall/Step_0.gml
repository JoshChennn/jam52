// TEMPORARY
if (instance_exists(obj_torch)) {
	if (!obj_torch.dreamMode) {
		sprite_index = spr_wall;
	}
	else {
		sprite_index = noone;
	}
}

flash = clamp(flash-0.02,0,1);
if flash != 0 depth = obj_wallDream.depth-200;
else depth = old_depth;