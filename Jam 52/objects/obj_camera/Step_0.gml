if (instance_exists(follow)) {
    x += (follow.x - x) / 25;
    y += (follow.y - y) / 25;
    x = clamp(x, 960, room_width - 960);
    y = clamp(y, 540, room_height - 540);
    camera_set_view_pos(view_camera[0], x - 960 + random_range(-shake, shake), y - 540 + random_range(-shake, shake));
    shake *= 0.9;
}

switch (room) {
	case rm_bossBat:
		target = obj_enemyBatBoss;
		break;
	case rm_bossGhost:
		target = obj_enemyGhostBoss;
		break; 
	case rm_bossSkeleton:
		target = obj_enemySkeletonBoss;
		break;
}
if (target != noone and timer > 60) {
	if (follow == obj_player and !done) {
		follow = target;
		timer = 0;
	}
	else {
		follow = obj_player;
		done = true;
	}
}

timer ++;