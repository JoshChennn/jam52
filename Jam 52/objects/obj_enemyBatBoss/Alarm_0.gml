// Call the spawn function

if ( hp > 0 ) {
	spawn_enemy_bat(x, y);
}
// Reset the alarm to trigger again in 5 seconds
alarm[0] = random_range(180, 360);
