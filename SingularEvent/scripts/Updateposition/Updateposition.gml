///@func update_position
///@desc update entity positions, calculates collision, and applies other movement physics to the entity
//The object calling this function requires spd, dir, grav, frict, (true direction will handle the vertical offset for vertical isometric view)
function update_position() {
	
	if(!grounded){
		vspd = approach(vspd, fallSpd, grav/10);
	}
	
	#region Entity Collisions
		//horizontal collisions with collider object
		if (place_meeting(x+hspd*dt, y, TileCollider)) {
		    while (!place_meeting(x+sign(hspd)*dt, y, TileCollider)){
		        x += sign(hspd)*dt;
		    }
		   hspd = 0;
		}

		//vertical collisions with collider object
		 if (place_meeting(x, y+vspd*dt, TileCollider)) {
			while(!place_meeting(x, y+sign(vspd), TileCollider)){
		        y += sign(vspd);
		    }
		    vspd = 0;
			grounded = true;
		} else {
			grounded = false;
			if(vspd > 0){
				state = states.fall;
			}
		}
			
			
	#endregion

	x += hspd*dt;
	y += vspd*dt;
	

}