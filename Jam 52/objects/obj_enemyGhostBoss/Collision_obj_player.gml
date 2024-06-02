/// @description Kill Player

invisble_timer = 240
if (instance_exists(obj_torch) and !obj_torch.dreamMode) {
	if (hp > 0) {
		with (other) {
			if (hp <= 0) return;
			hp -= 0.2;
			flash = 3;
		}
	}
}