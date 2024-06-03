var _cx = camera_get_view_x(view_camera[0]);
var _xspd = 3 * (keyboard_check(vk_right) - keyboard_check(vk_left));
_cx += _xspd
camera_set_view_pos(view_camera[0], _cx, 0);

var _b = ds_map_find_first(background_map);
repeat(ds_map_size(background_map))
    {
    layer_x(_b, background_map[? _b] * _cx);
    _b = ds_map_find_next(background_map, _b);
    }

if (instance_exists(obj_torch)) {
	if (obj_torch.dreamMode) {
		layer_set_visible("N_Sky",false);
		layer_set_visible("N_Moon",false);
		layer_set_visible("N_Mountains2",false);
		layer_set_visible("N_Mountains",false);
		layer_set_visible("N_Trees2",false);
		layer_set_visible("N_Trees",false);
		layer_set_visible("N_Grass",false);
		layer_set_visible("Nightmare",false);
		layer_set_visible("N_Tiles",false);
		layer_set_visible("N_Tiles2",false);
		
		layer_set_visible("D_Sky",true);
		layer_set_visible("D_Sun",true);
		layer_set_visible("D_Mountains2",true);
		layer_set_visible("D_Mountains",true);
		layer_set_visible("D_Trees2",true);
		layer_set_visible("D_Trees",true);
		//layer_set_visible("D_Grass",true);
		layer_set_visible("Dream",true);
		layer_set_visible("D_Tiles",true);
	}
	else {
		layer_set_visible("N_Sky",true);
		layer_set_visible("N_Moon",true);
		layer_set_visible("N_Mountains2",true);
		layer_set_visible("N_Mountains",true);
		layer_set_visible("N_Trees2",true);
		layer_set_visible("N_Trees",true);
		layer_set_visible("N_Grass",true);
		layer_set_visible("Nightmare",true);
		layer_set_visible("N_Tiles",true);
		layer_set_visible("N_Tiles2",true);
		
		layer_set_visible("D_Sky",false);
		layer_set_visible("D_Sun",false);
		layer_set_visible("D_Mountains2",false);
		layer_set_visible("D_Mountains",false);
		layer_set_visible("D_Trees2",false);
		layer_set_visible("D_Trees",false);
		layer_set_visible("D_Grass",false);
		layer_set_visible("Dream",false);
		layer_set_visible("D_Tiles",false);
	}
}
