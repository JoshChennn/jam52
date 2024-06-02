
// lotta fucking math jesus

function arctan2(dy, dx) {
    if (dx > 0) {
        return arctan(dy / dx);
    } else if (dx < 0 && dy >= 0) {
        return arctan(dy / dx) + pi;
    } else if (dx < 0 && dy < 0) {
        return arctan(dy / dx) - pi;
    } else if (dx == 0 && dy > 0) {
        return pi / 2;
    } else if (dx == 0 && dy < 0) {
        return -pi / 2;
    } else {
        return 0; // When dx == 0 and dy == 0
    }
}