/// @description Kill Player

if (hp > 0) {
	with (other) {
		if (hp <= 0) return;
		hp -= 0.2;
		flash = 3;
	}
}