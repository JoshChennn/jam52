/// @description Insert description here
// You can write your code in this editor
instance_create_layer(x,y,"Instances",obj_smoke);

if (!object_exists(obj_flame)) {
	audio_stop_sound(snd_flame);
}
instance_destroy();