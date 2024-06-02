repeat irandom_range(5,10) {
	var random_angle = irandom_range(0,360);
	var a = instance_create_layer(x+lengthdir_x(42*image_xscale,random_angle),y+lengthdir_y(42*image_yscale,random_angle),"Instances",obj_bubbleParticle);
	a.direction = random_angle;
}

instance_destroy();