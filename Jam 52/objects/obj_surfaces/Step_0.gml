// Create dream effect
if (size < 0.97) {
	bigger = 1;
}
else if (size > 1.03) {
	bigger = -1;
}
grow = (0.04 - abs(1 - size)) / 50;	
size += grow * bigger;

if (instance_exists(obj_torch)) {
	if obj_torch.dreamMode scr_dream(size);
}
/*
with (obj_enemyBat) {
scr_surfaces();
}