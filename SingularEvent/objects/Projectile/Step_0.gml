/// @description Insert description here
// You can write your code in this editor
//horizontal collisions with collider object
if (place_meeting(x+hspd*dt, y, TileCollider)) {
	timer = 0;
}

//vertical collisions with collider object
 if (place_meeting(x, y+vspd*dt, TileCollider)) {
	timer = 0;
}

timer -= dt;
if(timer < 0){
	instance_destroy();	
}

if(place_meeting(x, y, Enemy)){
	with(instance_place(x, y, Enemy)){
		//deal damage to enemy
		Enemy.takeDamage(1);
		instance_destroy(other);
	}
}



x += hspd*dt;
y += vspd*dt;

