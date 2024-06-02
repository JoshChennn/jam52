for (var i = 2; i < 32; i += 1) {
    var xPos = i * 32;
    var yPos = scr_spear_path(xPos, fast, angle, 0, 0, gra);
    
    // Calculate the tangent angle
    var nextXPos = (i + 1) * 32;
    var nextYPos = scr_spear_path(nextXPos, fast, angle, 0, 0, gra);
    var dx = nextXPos - xPos;
    var dy = nextYPos - yPos;
    var tangentAngle = arctan2(dy, dx) * 180 / pi;
	
    if (rotate) {
		if (angle = 115) { image_angle = 180; }
		else if ( angle = 45 ) { image_angle = 0; }
    }
}