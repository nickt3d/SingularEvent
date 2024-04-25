#region skip past the spash screen room
if(room == splash_rm){
	room_goto(mainmenu_rm);	
}
#endregion

#region toggle debug mode
if(keyboard_check_pressed(vk_f1)){
	global.debug = !global.debug;	
	show_debug_overlay(global.debug);
}

if(keyboard_check_pressed(vk_f2)){
	show_debug_overlay(false);
}

if(keyboard_check_pressed(vk_f3)){
	show_debug_overlay(true);
}
#endregion

if(keyboard_check_released(vk_escape)){
	if(room == mainmenu_rm){
		game_end();
	} else {
		room_goto(mainmenu_rm);	
	}
}