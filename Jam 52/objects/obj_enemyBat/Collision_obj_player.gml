/// @description Kill Player

hit_cooldown = 20;
var damage = 2;
if (instance_exists(obj_torch) and !obj_torch.dreamMode) {
	if (hp > 0) {
		with (other) {
			if (hp <= 0) return;
			hp -= damage;
			flash = 3;
		}
	}
}