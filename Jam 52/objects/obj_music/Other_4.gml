switch (room) {
	case rm_level3_:
		if !audio_is_playing(snd_nightmare) audio_play_sound(snd_nightmare,10,true);
		audio_stop_sound(snd_boss);
		break;
	case rm_bossGhost:
	case rm_bossBat:
	case rm_bossSkeleton:
		if !audio_is_playing(snd_boss) audio_play_sound(snd_boss,10,true);
		audio_stop_sound(snd_nightmare);
		break;
}