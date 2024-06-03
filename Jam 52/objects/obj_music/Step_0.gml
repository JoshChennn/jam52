switch (room) {
	case rm_tutorial:
	case rm_testLevel:
	case rm_level1_:
	case rm_level2_:
	case rm_level3_:
		room_sound = snd_nightmare;
		break;
	case rm_bossGhost:
	case rm_bossBat:
	case rm_bossSkeleton:
		room_sound = snd_boss;
		break;
}

if (instance_exists(obj_torch)) {
	if (obj_torch.dreamMode and !audio_is_playing(snd_dream)) {
		audio_play_sound(snd_dream,10,true);
	}
	if (obj_torch.dreamMode) {
		audio_sound_gain(snd_dream,1,1200);
		audio_sound_gain(room_sound,0,1200);
	}
	if (!obj_torch.dreamMode) {
		audio_sound_gain(snd_dream,0,1200);
		audio_sound_gain(room_sound,1,1200);
	}
}