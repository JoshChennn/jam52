switch (room) {
	case rm_tutorial:
	case rm_level1:
	case rm_level2:
	case rm_level3:
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
		//if (!audio_is_playing(room_sound)) audio_play_sound(room_sound,10,true);
		audio_sound_gain(snd_dream,0,1200);
		audio_sound_gain(room_sound,1,1200);
	}
}