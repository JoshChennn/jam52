// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wall_collision(_x,_y){
	if instance_exists(obj_torch) and obj_torch.dreamMode {
		return place_meeting(_x,_y,obj_wallDream);
	}
	else return place_meeting(_x,_y,obj_wall);
}
function closest_edge(_x,_y,object) {
	var close_x = max(object.x,min(_x,object.x+object.sprite_width));
	var close_y = max(object.y,min(_y,object.y+object.sprite_height));
	return [close_x,close_y];
}