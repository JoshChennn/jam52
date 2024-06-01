/// @description Mechanics
if !obj_player.in_bubble {
	// Position
	x = obj_player.x;
	y = obj_player.y + 10;

	image_angle = point_direction(x, y, mouse_x, mouse_y);

	// New flamethrower test
	if (obj_torch.dreamMode) {
		if mouse_check_button(mb_left) {
			if !instance_exists(obj_bubble) {
				instance_create_layer(x,y,"Instances", obj_bubble);
			}
			with (obj_bubble) {
				if !floating {
					image_xscale += 0.01;
					image_yscale = image_xscale;
					if image_xscale >= 1 {
						floating = true;
						hsp = lengthdir_x(2,other.image_angle);
						vsp = lengthdir_y(2,other.image_angle);
					}
					else {
						x = other.x + lengthdir_x(30+80*image_xscale,other.image_angle);
						y = other.y + lengthdir_y(30+80*image_yscale,other.image_angle);
					}
				}
			}
		}
	}
	else {
		if instance_exists(obj_bubble) {
			instance_destroy(obj_bubble);
			obj_player.in_bubble = false;
		}
		if (mouse_check_button(mb_left)) {
			instance_create_depth(x,y,depth+1,obj_flame);
		}
	}
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
