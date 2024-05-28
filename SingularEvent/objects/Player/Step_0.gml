input();

//get the direction from the player to the cursor
aim_dir = point_direction(x, y, mouse_x, mouse_y);

#region simple movement
	if(global.i_move_x != 0 || global.i_move_y != 0){
		if(grounded){
			state = states.walk;
		}
		hspd = approach(hspd, max_spd*global.i_move_x, accel);
	} else { 
		if(grounded){
			state = states.idle;	
		}
		hspd = approach(hspd, 0, frict);
	}
#endregion

if(global.i_jump_held && grounded){
	vspd -= jumpPower;
	grounded = false;
	state = states.jump;
}

sprite_index = sprite_map[? state];

update_position();

if(mouse_check_button(mb_left) && attackCooldown == 0){
	with(instance_create_layer(x, y-playerHeight, layer, Projectile)){
		spd = 300;
		dir = other.aim_dir;
		hspd = lengthdir_x(spd, dir);
		vspd = lengthdir_y(spd, dir);
	}
	attackCooldown = attackSpd;
}

if(mouse_check_button_released(mb_left) && attackCooldown != 0){
	attackCooldown = 0; //releasing the button makes the cooldown reset
}

attackCooldown = approach(attackCooldown, 0, dt);