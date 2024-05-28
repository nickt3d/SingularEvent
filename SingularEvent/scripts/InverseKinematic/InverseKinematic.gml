function draw_ik(orig_x, orig_y, target_x, target_y, length1, length2, flip, sprite1, sprite2){
	var dist = point_distance(orig_x, orig_y, target_x, target_y);
	var base_angle = -arctan2(target_y - orig_y, target_x - orig_x);

	var cos_a = (length1 * length1) + (dist * dist) - (length2 * length2);
	cos_a = cos_a / (2 * length1 * dist);
	cos_a = min(1, max(-1, cos_a));
	var angle = arccos(cos_a);

	if(flip)
	{
	    angle = -angle;
	}

	var angle_1 = radtodeg(base_angle + angle);

	var b2_x = orig_x + lengthdir_x(length1, angle_1);
	var b2_y = orig_y + lengthdir_y(length1, angle_1);

	var angle_2 = radtodeg(-arctan2(target_y - b2_y, target_x - b2_x));

	draw_sprite_ext(sprite1, 0, orig_x, orig_y, 1, 1, angle_1, c_white, 1);
	draw_sprite_ext(sprite2, 0, b2_x, b2_y, 1, 1, angle_2, c_white, 1);
}