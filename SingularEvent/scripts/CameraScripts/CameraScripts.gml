function init_camera_enum() {
	enum cam_mode{
		idle,
		follow,
		mouse_drag,
		mouse_border,
		mouse_peek,
		move_to_target,
		move_to_follow_target
	}
}

function camera_get_x() {
	if(instance_exists(CameraController)){
		return	CameraController.cx;
	} else {
		return 0;	
	}
}

function camera_get_y() {
	if(instance_exists(CameraController)){
		return	CameraController.cy;
	} else {
		return 0;	
	}
}

function camera_get_height() {
	if(instance_exists(CameraController)){
		return	CameraController.vy;
	} else {
		return 0;	
	}
}

function camera_get_width() {
	if(instance_exists(CameraController)){
		return	CameraController.vx;
	} else {
		return 0;	
	}
}

function camera_follow() {
	cx = lerp(cx, target.x, smoothing_level);
	cy = lerp(cy, target.y, smoothing_level);
}

function camera_edge() {
	if(!point_in_rectangle(mouse_x, mouse_y, cx+(vx*0.1), cy+(vy*0.1), cx+(vx*0.9), cy+(vy*0.9))){
		cx = lerp(cx, mouse_x-(vx/2), 0.05);
		cy = lerp(cy, mouse_y-(vy/2), 0.05);
	}
}

function camera_drag() {
	var mx = mouse_x;
	var my = mouse_y;
	if(mouse_check_button(mb_left)){
		cx += (mxp - mx);
		cy += (myp - my);
	} else {
		mxp = mx;
		myp = my;
	}
}

function camera_set_mode() {
	with(CameraController){
		state = argument[0];
		switch(state){
			case cam_mode.move_to_target:
				target_x = argument[1];
				target_y = argument[2];
			break;		
			case cam_mode.follow:
			case cam_mode.move_to_follow_target:
				follow = argument[1];
			break;
		}
	}
}

function camera_update() {
	with(CameraController){
		if(target != noone){
			vx = window_size.x/zoom;
			vy = window_size.y/zoom;

			var pm = matrix_build_projection_ortho(vx, vy, -100000, 100000.0);
			camera_set_proj_mat(camera, pm);
			
			var vm = matrix_build_lookat(cx + cxoffset, cy + cyoffset, -z_dist*zoom, cx + cxoffset, cy + cyoffset, 0, 0, 1, 0);
			//var pm = matrix_build_projection_ortho(vx, vy, -100, 10000);
			camera_set_view_mat(camera, vm);
			//camera_set_proj_mat(camera, pm);
		} else {
			vx = window_size.x/zoom;
			vy = window_size.y/zoom;

			var pm = matrix_build_projection_ortho(vx, vy, -100000, 100000.0);
			camera_set_proj_mat(camera, pm);
			
			var vm = matrix_build_lookat(cx + cxoffset, cy + cyoffset, -z_dist*zoom, cx + cxoffset, cy + cyoffset, 0, 0, 1, 0);
			//var pm = matrix_build_projection_ortho(vx, vy, -100, 10000);
			camera_set_view_mat(camera, vm);
			//camera_set_proj_mat(camera, pm);
		}  
	}
}

function camera_shake(argument0) {
	var s = argument0;
	var xx = choose(-1, 1)*s;
	var yy = choose(-1, 1)*s;

	if(instance_exists(CameraController)){
		with(CameraController){
			cx += xx;
			cy += yy;
			var vm = matrix_build_lookat(cx, cy, 0 - z_dist*zoom, cx, cy, 0 + z_dist*zoom, 0, 1, 0);
			camera_set_view_mat(camera, vm);
		}
	}
}

function camera_move_to_follow_target() {
	cx = lerp(cx, follow.x, 0.1);
	cy = lerp(cy, follow.y, 0.1);

	if(point_distance(cx, cy, follow.x, follow.y) < 1){
		state = cam_mode.follow;	
	}
}

function camera_get_zoom() {
	if(instance_exists(CameraController)){
		return	CameraController.zoom;
	} else {
		return -1;	
	}
}