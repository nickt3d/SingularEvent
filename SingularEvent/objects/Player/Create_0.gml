with(instance_create_layer(x, y, "Controllers", CameraController)){
	target = other;
	state = cam_mode.follow;
}

event_inherited();

aim_dir = 0;

playerHeight = 12;
jumpPower = 250;
fallSpd = 250;

sprite_map = ds_map_create();

sprite_map[? states.idle] = player_idle_spr;
sprite_map[? states.walk] = player_run_spr;
sprite_map[? states.jump] = player_jump_spr;
sprite_map[? states.fall] = player_fall_spr;