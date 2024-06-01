if !in_bubble and other.hsp == 0 and other.vsp == 0 and other.floating {
	in_bubble = true;
	horspeed = 0;
	verspeed = 0;
	sprite_index = spr_player;
}