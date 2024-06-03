/// @description Damage and Flash 

with (other) {
	if (hp <= 0) return;
	hp -= 1;
	flash = 3;
}

if (!object_exists(obj_flame)) {
	audio_stop_sound(snd_flame);
}
instance_destroy();