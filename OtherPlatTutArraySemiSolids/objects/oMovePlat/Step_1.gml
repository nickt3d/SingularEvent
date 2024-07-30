//Move in a circle
dir += rotSpd;

//get our target posisitons
var _targetX = xstart + lengthdir_x( radius, dir);
var _targetY = ystart + lengthdir_y( radius, dir);

//get our xspd and yspd
xspd = _targetX - x;
yspd = _targetY - y;

//move
x += xspd;
y += yspd;