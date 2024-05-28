with(instance_create_layer(x, y, "Controllers", CameraController)){
	target = other;
	state = cam_mode.follow;
}

event_inherited();

aim_dir = 0;
attackCooldown = 0;
attackSpd = 0.2;

playerHeight = 12;
jumpPower = 250;
fallSpd = 250;

jumpDelay = 1; // amount of time before the doubleJump Expires
jumpCount = 2;
jumpsLeft = 1;

sprite_map = ds_map_create();

sprite_map[? states.idle] = player_idle_spr;
sprite_map[? states.walk] = player_run_spr;
sprite_map[? states.jump] = player_jump_spr;
sprite_map[? states.fall] = player_fall_spr;