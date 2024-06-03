/// @description Insert description here
// You can write your code in this editor
// Check for collision with the player
if (place_meeting(x, y, obj_player) && !obj_torch.dreamMode) {
	if (cooldown < 0) {
	    with (obj_player) {
	        hp -= other.damage;
	        flash = 3;
			cooldown = 120;
	    }
	}
}

if (!obj_torch.dreamMode) {
	with (other) {
		if (hp <= 0) return;
		hp -= 1;
		flash = 3;
	}
}