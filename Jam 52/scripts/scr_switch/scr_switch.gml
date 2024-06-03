function scr_switch (){
	if (instance_exists(obj_torch) and !obj_torch.dreamMode) {
		layer_set_visible("N_Sky",true);
		layer_set_visible("N_Moon",true);
		layer_set_visible("N_Mountains2",true);
		layer_set_visible("N_Mountains",true);
		layer_set_visible("N_Trees2",true);
		layer_set_visible("N_Trees",true);
		layer_set_visible("N_Sky",true);
		layer_set_visible("N_Grass",true);
		layer_set_visible("Nightmare",true);
		layer_set_visible("N_Tiles",true);
		layer_set_visible("N_Tiles2",true);
	}
}