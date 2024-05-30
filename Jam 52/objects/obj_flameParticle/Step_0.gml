/// @description Behavior

// Check for collision with walls
var collided = false;

if (place_meeting(x + hspeed, y, obj_wall)) {
    hspeed = -hspeed; // Reverse horizontal speed
    collided = true;
}

if (place_meeting(x, y + vspeed, obj_wall)) {
    vspeed = -vspeed; // Reverse vertical speed
    collided = true;
}

// If a collision occurred, set the ever_collided flag to true
if (collided) {
    ever_collided = true;
}

// Random chance to destroy instance if ever_collided is true
if (ever_collided && irandom_range(0, 20) == 10) {
    instance_destroy();
} else {
    // Apply gravity
    vspeed += gravity;
    
    // Update position
    x += hspeed;
    y += vspeed;
}