if wobble >= 0 wobble_speed -= 0.003;
else wobble_speed += 0.003
wobble += wobble_speed;

x += obj_player.horspeed/2;
y += obj_player.verspeed/2;

image_xscale = origin_scale + wobble;
image_yscale = origin_scale - wobble;

wobble_speed *= 0.99;
direction += angle_difference(90,direction)/80;