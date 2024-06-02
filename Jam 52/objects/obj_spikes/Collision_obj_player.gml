with (obj_player) {
	if (instance_exists(obj_torch) and !obj_torch.dreamMode and !dead) {
		dead = true;
		instance_destroy(obj_flamethrower);
		repeat (25) { instance_create_layer(x,y-41,"Instances", obj_deadParticle); }
		alarm_set(0,60);
		hp = 0;
	}
}