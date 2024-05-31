/// @description Behavior
if (lifespan == 0) {
    image_index = 0;
} else if (lifespan % 2 == 1) {
    image_index = 1;
} else {
    image_index = 2;
}

lifespan += 1;

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
if (ever_collided && irandom_range(0, 5) == 3) {
    instance_destroy();
} else {
    // Apply gravity
    vspeed += gravity;
    
    // Update position
    x += hspeed;
    y += vspeed;
}