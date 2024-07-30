function controlsSetup()
{
	bufferTime = 4;
	
	jumpKeyBuffered = 0;
	JumpKeyBufferTimer = 0;
}

function getControls ()
{
	//Directional inputs
	rightKey = keyboard_check( ord ("D")) + keyboard_check(vk_right) + gamepad_button_check (0, gp_padr);
		rightKey = clamp (rightKey, 0, 1);
	leftKey = keyboard_check( ord ("A")) + keyboard_check(vk_left) + gamepad_button_check (0, gp_padl);
		leftKey = clamp (leftKey, 0, 1);
	downKey = keyboard_check(ord("S")) + gamepad_button_check(0, gp_padd)
		downKey = clamp( downKey, 0, 1);
		
	//Action inputs
	jumpKeyPressed = keyboard_check_pressed( vk_space) + gamepad_button_check_pressed(0, gp_face1);
		jumpKeyPressed = clamp( jumpKeyPressed, 0, 1);
	jumpKey = keyboard_check(vk_space) + gamepad_button_check (0, gp_face1);
		jumpKey = clamp (jumpKey, 0, 1);
		
	//Jump key buffering
		if jumpKeyPressed
		{
			JumpKeyBufferTimer = bufferTime;
		}
		if JumpKeyBufferTimer > 0
		{
			jumpKeyBuffered = 1;
			JumpKeyBufferTimer--;
		} else {
			jumpKeyBuffered= 0;
		}
}