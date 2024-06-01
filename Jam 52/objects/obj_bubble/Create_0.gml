// Start small
image_xscale = random_range(0.3,0.5);
image_yscale = image_xscale;

var dir = irandom_range(-5,5);
direction = obj_flamethrower.image_angle + dir;
speed = random_range(5,7);

var destroy = random_range(30,40);
alarm_set(0, destroy);