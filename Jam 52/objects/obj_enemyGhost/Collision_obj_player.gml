/// @description Kill Player

if (instance_exists(obj_torch) and !obj_torch.dreamMode) {
	move_speed = 0.2;
	if (hp > 0) {
		with (other) {
			if (hp <= 0) return;
			hp -= 1;
			flash = 3;
		}
	}
}