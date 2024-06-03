/// @description Mechanics
// Position
x = obj_player.x;
y = obj_player.y - 31;

// New flamethrower
if (obj_torch.dreamMode) {
	if mouse_check_button(mb_left) {
		direction = point_direction(x,y,mouse_x,mouse_y);
		if irandom(1) == 1 instance_create_depth(x+lengthdir_x(28,direction),y+lengthdir_y(28,direction),depth+1,obj_bubble);
		//obj_camera.shake = 1;
	}
	sprite_index = spr_bubbleBlower;
}
else {
	if (mouse_check_button(mb_left)) {
		just_hit = 0;
		instance_create_depth(x+lengthdir_x(25,image_angle),y+lengthdir_y(25,image_angle),depth+1,obj_flame);
		obj_camera.shake = 3.5;
		//if !audio_is_playing(snd_flame) audio_play_sound(snd_flame, 1, false);
	} else if (just_hit > 40) { audio_stop_sound(snd_flame); }
	sprite_index = spr_flamethrower;
	image_angle = point_direction(x, y, mouse_x, mouse_y);
	if mouse_x < x image_yscale = -1;
	else image_yscale = 1;
	just_hit ++;
}

/* FOR TESTING

firingdelay = firingdelay - 1;
recoil = max(0, recoil - 1);

if (mouse_check_button(mb_left) && firingdelay < 0) {
    recoil = 4;
    firingdelay = 5;
    
    // Shoot 10 bullets
    var bullet_count = 20;
    var angle_step = 1; // Spread angle (change this value to control the spread)
    var start_angle = -angle_step * (bullet_count - 1) / 2;
    
    for (var i = 0; i < bullet_count; i++) {
        var angle_offset = start_angle + i * angle_step;
        
        var bullet = instance_create_layer(x, y, "Bullets", obj_flameParticle);
        bullet.speed = 12;
        bullet.direction = image_angle + angle_offset;
        bullet.image_angle = bullet.direction;
        bullet.gravity = 0.6; 
        bullet.gravity_direction = 270;
    }
}
*/

// Adjust position for recoil
x = x - lengthdir_x(recoil, image_angle);
y = y - lengthdir_y(recoil, image_angle);
