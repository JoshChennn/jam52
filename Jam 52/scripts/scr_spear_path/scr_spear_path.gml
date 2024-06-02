function scr_spear_path(xx, spd, ang, x0, y0, gr) {

	anguse = degtorad(ang);
	
	var posY = 0;
	if(cos(anguse) != 0 && spd != 0) {
		posY = -(gr/2)*(power(xx-x0,2) / (power(spd,2)*power(cos(anguse),2))) + tan(anguse)*(xx-x0) + y0;
	} else {
		posY = 0;	
	}

	return posY;
}


function calculate_throw_parameters(distance, height_difference, launch_angle_degrees) {
    var g = 6; 

    var launch_angle_radians = launch_angle_degrees * (pi / 180);
 
    var sin_theta = sin(launch_angle_radians);
    var cos_theta = cos(launch_angle_radians);
    var term1 = g * distance * distance;
    var term2 = 2 * cos_theta * cos_theta * (distance * tan(launch_angle_radians) - height_difference);

    if (term2 <= 0) {
        return [-1, launch_angle_degrees];
    }

    var initial_velocity = sqrt(term1 / term2);
	show_debug_message(launch_angle_degrees);

    return [initial_velocity, launch_angle_degrees];
}