//make the controlls switch from gamepad to keyboard if hitting a keyboard or mouse button,
//make the controls switch from keyboard to gamepad when hitting a controller button

#region Controller Inputs	
	if(gamepad_is_connected(0)){
		global.using_gamepad = true;
		gamepad_set_axis_deadzone(0, 0.35);
		
		gp_left_xaxis = gamepad_axis_value(0, gp_axislh);
		gp_left_yaxis = gamepad_axis_value(0, gp_axislv);
		
		gp_right_xaxis = gamepad_axis_value(0, gp_axisrh);
		gp_right_yaxis = gamepad_axis_value(0, gp_axisrv);
	
		gp_start_press = gamepad_button_check_pressed(0, gp_start);
		gp_select_press = gamepad_button_check_pressed(0, gp_select);
	
		gp_trigger_r = gamepad_button_check(0, gp_shoulderr);
		gp_trigger_l = gamepad_button_check(0, gp_shoulderl);
	
		//face buttons
		gp_a_button_press = gamepad_button_check_pressed(0, gp_face1);
		gp_b_button_press = gamepad_button_check_pressed(0, gp_face2);
		gp_x_button_press = gamepad_button_check_pressed(0, gp_face3);
		gp_y_button_press = gamepad_button_check_pressed(0, gp_face4);
	
		gp_a_button_held = gamepad_button_check_pressed(0, gp_face1);
		gp_b_button_held = gamepad_button_check_pressed(0, gp_face2);
		gp_x_button_held = gamepad_button_check_pressed(0, gp_face3);
		gp_y_button_held = gamepad_button_check_pressed(0, gp_face4);
	
		gp_a_button_released = gamepad_button_check_pressed(0, gp_face1);
		gp_b_button_released = gamepad_button_check_pressed(0, gp_face2);
		gp_x_button_released = gamepad_button_check_pressed(0, gp_face3);
		gp_y_button_released = gamepad_button_check_pressed(0, gp_face4);
		
		gp_zoom_up = gamepad_button_check_pressed(0, gp_padu);
		gp_zoom_down = gamepad_button_check_pressed(0, gp_padd);

	} else {
		global.using_gamepad = false;
		global.cursor_visible = true;
	}
#endregion

#region Keyboard	
		kb_left_xaxis = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		kb_left_yaxis = keyboard_check(ord("S")) - keyboard_check(ord("W"));
		
		kb_right_xaxis = keyboard_check(vk_right) - keyboard_check(vk_left);
		kb_right_yaxis = keyboard_check(vk_up) - keyboard_check(vk_down);
	
		kb_start_press = keyboard_check(vk_enter);
		kb_select_press = keyboard_check(vk_backspace);
	
		//trigger_r = keyboard_check(ord("I"));
		//trigger_l = keyboard_check(ord("J"));
	

		kb_space_press = keyboard_check_pressed(vk_space);
		kb_shift = keyboard_check(vk_shift);
		kb_control_press = keyboard_check_pressed(vk_control);
		
		kb_mouse_left = mouse_check_button_pressed(mb_left);
		kb_mouse_left_held = mouse_check_button(mb_left);
		kb_mouse_right = mouse_check_button_pressed(mb_right);
		kb_mouse_right_held = mouse_check_button(mb_right);
		
		
		kb_space_held = keyboard_check(vk_space);

		kb_b_key_press = keyboard_check_pressed(ord("B"));
		
		kb_zoom_up = mouse_wheel_up();
		kb_zoom_down = mouse_wheel_down();

#endregion



#region convert key presses to configured controls
if(global.using_gamepad){
	global.i_start  = gp_start_press;
	global.i_select = gp_select_press;

	global.i_move_x = gp_left_xaxis;
	global.i_move_y = gp_left_yaxis;
	global.i_aim_x  = gp_right_yaxis;
	global.i_aim_y  = gp_right_yaxis;
	
	global.i_jump	   = gp_y_button_press;
	global.i_jump_held = gp_y_button_held;
	global.i_attack    = gp_x_button_press;
	
	global.i_zoom_up	= gp_zoom_up;
	global.i_zoom_down  = gp_zoom_down;
} else {
	global.i_start  = kb_start_press;
	global.i_select = kb_select_press;

	global.i_move_x = kb_left_xaxis;
	global.i_move_y = kb_left_yaxis;
	global.i_aim_x  = kb_right_yaxis;
	global.i_aim_y  = kb_right_yaxis;
	
	global.i_jump	   = kb_space_press;
	global.i_jump_held = kb_space_held;
	//global.i_target    = kb_mouse_left;
	global.i_attack    = kb_mouse_left_held;
	
	global.i_open_pack = kb_b_key_press;
	
	global.i_zoom_up	= kb_zoom_up;
	global.i_zoom_down  = kb_zoom_down;

}
#endregion



