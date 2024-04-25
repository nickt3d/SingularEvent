/// @description Insert description here
// You can write your code in this editor

draw_self();

draw_set_color(c_red);
draw_line(x, y-playerHeight, x+lengthdir_x(5, aim_dir), y-playerHeight+lengthdir_y(5, aim_dir));
draw_set_color(c_white);