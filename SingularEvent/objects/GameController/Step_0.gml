#region skip past the spash screen room
if(room == splash_rm){
	room_goto(mainmenu_rm);
	global.gameState = gameState.menu;
}
#endregion

if(keyboard_check_released(vk_escape)){
	if(room == mainmenu_rm){
		game_end();
	} else {
		room_goto(mainmenu_rm);	
	}
}