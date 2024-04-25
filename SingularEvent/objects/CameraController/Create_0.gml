/********************************CAMERA USAGE*********************************/
#region camera usage
/*
camera_update() - checks the current camera position and zoom level and resets the view matrix
camera_follow() - follows the current camera target
change_camera_mode()
camera_move_to_follow_target()
camera_edge
camera_drag
camera_get_x
camera_get_y
camera_get_width
camera_get_height
camera_shake(shake force) - offsets the camera by a specified force variable to create a camera shake effect
*/
#endregion

/*****************************************************************************/

//create the camera
camera = camera_create();

window_size = new vec2(1280, 1152);

#region zoom
minzoom = 0;			//the minimum zoom level
maxzoom = 20;			//the maximum zoom level
zoom	= 8;			//the starting zoom level
canZoom = false;
vx = window_size.x/zoom;
vy = window_size.y/zoom;
#endregion

cx = 0;			//the camera x position
cy = 0;			//the camera y position
cz = 0;

cxoffset = 0;
cyoffset = -16;

z_dist = 50;
dir = 0;
pitch = 0;
cursor_index = 0;
cursor_visible = true;

//set the view width and height based on the screen size
var pm = matrix_build_projection_ortho(vx, vy, -10000.0, 10000.0);

//set the camera projection matrix
camera_set_proj_mat(camera, pm);

//set the room viewport
view_visible[0] = true;
view_enabled = true;
view_set_camera(0, camera);
view_camera[0] = camera;

//default starting state
state = cam_mode.idle;

//the object this camera is attached to
target = noone;

mxp = 1;
myp = 1;

//smooth the movement
smoothing_level = 0.25;

//the camera update script
camera_set_update_script(camera, camera_update);
