#region macros
	#macro dt delta_time/1000000
	//display width and height
	#macro dh display_get_height()
	#macro dw display_get_width()

	//room width and height
	#macro rh room_height
	#macro rw room_width

	#macro guiw display_get_gui_width()
	#macro guih display_get_gui_height()

	#macro winW window_get_width()
	#macro winH window_get_height()
#endregion

global.gameState = gameState.loading;

#region enums
	enum states {
		idle,
		walk,
		jump,
		fall,
		attack,
		recoil,
		dead,
		length
	}
	enum gameState {
		loading,
		menu,
		paused,
		playing
	}
#endregion