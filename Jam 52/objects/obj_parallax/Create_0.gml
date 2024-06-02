background_map = ds_map_create();
background_map[? layer_get_id("B_Sky")] = 1;
background_map[? layer_get_id("B_Moon")] = 1;
background_map[? layer_get_id("B_Mountains2")] = 0.5;
background_map[? layer_get_id("B_Mountains")] = 0.4;
background_map[? layer_get_id("B_Trees2")] = 0.3;
background_map[? layer_get_id("B_Trees")] = 0.2;
background_map[? layer_get_id("B_Grass")] = 0.1;