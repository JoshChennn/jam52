if wobble >= 0 wobble_speed -= 0.003;
else wobble_speed += 0.003
wobble += wobble_speed;

image_xscale = origin_scale + wobble;
image_yscale = origin_scale - wobble;

wobble_speed *= 0.99;