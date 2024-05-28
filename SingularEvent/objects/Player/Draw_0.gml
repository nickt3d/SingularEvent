////Shoulder Front
//draw_sprite_ext(player_shoulderL_spr, 0, x, y-48, 1, 1, 0, c_white, 1);

////Gun
//draw_sprite_ext(player_arm_gun_spr, 0, x, y-48, 1, 1, 0, c_white, 1);

////Shoulder Back
//draw_sprite_ext(player_shoulderR_spr, 0, x, y-48, 1, 1, 0, c_white, 1);

////Arm
//draw_sprite_ext(player_arm_spr, 0, x, y-48, 1, 1, 0, c_white, 1);

draw_self();
//gun arm
draw_ik(x-6, y-32, x+lengthdir_x(32, aim_dir), y-32+lengthdir_y(32, aim_dir), 8, 8, 0, player_shoulder_gun_spr, player_arm_gun_spr);
//other arm
//draw_ik();

//Debug aim Line
draw_set_color(c_red);
draw_line(x, y-playerHeight, x+lengthdir_x(5, aim_dir), y-playerHeight+lengthdir_y(5, aim_dir));


//draw_target
draw_set_color(c_red);
draw_point(x+lengthdir_x(32, aim_dir), y-32+lengthdir_y(32, aim_dir));
draw_set_color(c_white);
