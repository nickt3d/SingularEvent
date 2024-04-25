#region movement physics variables
hspd = 0;
vspd = 0;
zspd = 0;
spd = 0;
max_spd = 100;
frict = 5;
accel = 10;
fallSpd = 0;

//directional variables
dir = 0;
aim_dir = 0;

grav = 90;
grounded = false;



#endregion

state = states.idle;