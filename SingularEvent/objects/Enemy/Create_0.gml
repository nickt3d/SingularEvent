//Current Behaviour
//simple floating/flying enemy
//seek the player when in range
//return to spawn point when player leave range

spawnX = x;
spawnY = y;

state = states.idle;

spd = 0;
dir = 0;
hspd = 0;
vspd = 0;

hp = 2;

takeDamage = function(dmg){
	hp -= dmg;	
	if(hp <= 0){
		instance_destroy();	
	}
}

sight_range = 100;

//TODO:
//Stay at least a few tiles above the ground
//Add a hovering effect