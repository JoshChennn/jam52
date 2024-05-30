/// @description Damage and Flash 

with (other) {
	if (hp <= 0) return;
	hp -= 1;
	flash = 3;
}

instance_destroy();