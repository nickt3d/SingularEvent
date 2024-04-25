
if(point_distance(x, y, Player.x, Player.y) <= 80){
	state = states.attack;
} else if (point_distance(x, y, Player.x, Player.y) >= 100) {
	state = states.walk;
}

switch(state){
	case states.attack:
		dir = point_direction(x, y, Player.x, Player.y)
		spd = 50;
		hspd = lengthdir_x(spd, dir);
		vspd = lengthdir_y(spd, dir);

		x += hspd*dt;
		y += vspd*dt;
	break;
	
	case states.idle:
		
	break;
		
	case states.walk:
		//slowly returns to spawn point
		dir = point_direction(x, y, spawnX, spawnY);
		spd = 25;
		
		hspd = lengthdir_x(spd, dir);
		vspd = lengthdir_y(spd, dir);
		
		x += hspd*dt;
		y += vspd*dt;
		
		if(x == spawnX && y == spawnY){
			state = states.idle;
		}

	break;
}



