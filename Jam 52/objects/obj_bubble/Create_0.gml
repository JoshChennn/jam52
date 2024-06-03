// Start small
origin_scale = random_range(0.3,0.5);
image_xscale = origin_scale;
image_yscale = origin_scale;
wobble = 0;
wobble_speed = random_range(0.5,1.2)/100;

var dir = irandom_range(-5,5);
direction = obj_flamethrower.direction + dir;
speed = random_range(4,7);

var destroy = random_range(40,100);
alarm_set(0, destroy);