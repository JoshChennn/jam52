//Create background
/*var d_grass = layer_create(-330,"D_Grass");
var d_trees = layer_create(-340,"D_Trees");
var d_trees2 = layer_create(-350,"D_Trees2");
var d_mountains = layer_create(-360,"D_Mountains");
var d_mountains2 = layer_create(-370,"D_Mountains2");
var d_sun = layer_create(-380,"D_Sun");
var d_sky = layer_create(-390,"D_Sky");

layer_background_sprite(layer_background_get_id(d_grass),spr_grassDream);
layer_background_sprite(layer_background_get_id(d_trees),spr_treesDream);
layer_background_sprite(layer_background_get_id(d_trees2),spr_backTreesDream);
layer_background_sprite(layer_background_get_id(d_mountains),spr_mountainsDream);
layer_background_sprite(layer_background_get_id(d_mountains2),spr_mountains2Dream);
layer_background_sprite(layer_background_get_id(d_sun),spr_sun);*/




background_map = ds_map_create();
background_map[? layer_get_id("N_Sky")] = 1;
background_map[? layer_get_id("N_Moon")] = 1;
background_map[? layer_get_id("N_Mountains2")] = 0.5;
background_map[? layer_get_id("N_Mountains")] = 0.4;
background_map[? layer_get_id("N_Trees2")] = 0.3;
background_map[? layer_get_id("N_Trees")] = 0.2;
background_map[? layer_get_id("N_Grass")] = 0.1;

background_map2 = ds_map_create();
background_map2[? layer_get_id("D_Sky")] = 1;
background_map2[? layer_get_id("D_Sun")] = 1;
background_map2[? layer_get_id("D_Mountains2")] = 0.5;
background_map2[? layer_get_id("D_Mountains")] = 0.4;
background_map2[? layer_get_id("D_Trees2")] = 0.3;
background_map2[? layer_get_id("D_Trees")] = 0.2;