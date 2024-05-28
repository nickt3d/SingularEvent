draw_self();

//draw_text(x, y-8, point_distance(x, y, Player.x, Player.y));

//Debug_draw

//Aggro range
draw_set_color(c_yellow);
draw_circle(x, y, sight_range/2, 1);

//Attack range
draw_set_color(c_red);
draw_circle(x, y, 80/2, 1);
draw_set_color(c_white);