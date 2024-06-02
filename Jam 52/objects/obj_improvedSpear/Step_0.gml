if (!shoot) {
    if (should_shoot) {
        shoot = true;
        direction = angle;
        speed = fast;
        rotate = true;
    }
} else {
    gravity = gra;
}