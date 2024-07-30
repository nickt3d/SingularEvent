// Get Inputs
getControls ()

//Get out of solid moveplats that have positioned themselves into the player in the begin step
var _rightWall = noone;
var _leftWall = noone;
var _bottomWall = noone;
var _list = ds_list_create();
var _listSize = instance_place_list(x, y, oMovePlat, _list, false);

//loop through all colliding move plats
	for(var i = 0; i < _listSize; i++ )
	{
		var _listInst = _list[| i]
		
		//Find closest walls in each diretion
		//Right Wall
		//If there is a wall to the right of me, get the closest one
		if _listInst.bbox_left - _listInst.xspd >= bbox_right-1
		{
			if !instance_exists(_rightWall) || _listInst.bbox_left < _rightWall.bbox_left
			{
				_rightWall = _listInst;
			}
		}
		//Left Walls
		if _listInst.bbox_right - _listInst.xspd <= bbox_left+1
		{
			if !instance_exists(_leftWall) || _listInst.bbox_right > _leftWall.bbox_right
			{
				_leftWall = _listInst;
			}
	}
		//bottom Wall
		if _listInst.bbox_top - _listInst.yspd >= bbox_bottom-1
		{
			if !_bottomWall || _listInst.bbox_top < _bottomWall.bbox_top
			{ 
				_bottomWall = _listInst;
			}
	}
	}
//Destroy the ds list to free memory
ds_list_destroy(_list)


//get out of the walls
//Right Wall
if instance_exists(_rightWall)
{
	var _rightDist = bbox_right - x;
	x = _rightWall.bbox_left - _rightDist;
	
}
//Left Wall
if instance_exists(_leftWall)
{
	var _leftDist = x - bbox_left ;
	x = _leftWall.bbox_right - _leftDist
}

//Bottom Wall
if instance_exists(_bottomWall)
{
	var _bottomDist = bbox_bottom - y;
	y = _bottomWall.bbox_top - _bottomDist
}


// X Movement
	//Direction
	moveDir = rightKey - leftKey;
//Get my face
if moveDir != 0 {face = moveDir};
	// Get xspd
	xspd = moveDir * moveSpd;

	// X collision
	var _subPixel = .5;
	if place_meeting(x + xspd, y, oWall)
	{
		//First check if there is a slope to go up 
		if !place_meeting (x + xspd, y - abs(xspd)-1, oWall)
		{
			while place_meeting( x + xspd, y, oWall ) {y -= _subPixel;};
		}
		//If there is  no slope, regular collision
		else
		{
		//Ceiling Slopes //times Xspd for higher degree slopes
		if !place_meeting( x + xspd, y + abs(xspd)+1, oWall)
		{
			while place_meeting( x + xspd, y, oWall) { y += _subPixel; };
		}
		else
		{
		//Scoot up to the wall
		var _pixelCheck = _subPixel * sign(xspd);
		while !place_meeting(x + _pixelCheck, y, oWall)
		{
			x += _pixelCheck;
		}
	
		//Set xspd to zero to "collide"
		xspd = 0
		}
	}
}

//Go down slopes
downSlopeSemiSolid = noone;
	if yspd >= 0 && !place_meeting( x + xspd, y + 1, oWall ) && place_meeting(x + xspd, y + abs(xspd)+1, oWall)
	{
		//Check for a semisolid in the way
		downSlopeSemiSolid = checkForSemiSolidPlatform(x + xspd, y + abs(xspd)+1);
		//precisely move down slop if there isn't a semilsolid in the way
		if !instance_exists(downSlopeSemiSolid)
		{
			while !place_meeting(x + xspd, y + _subPixel, oWall ) { y += _subPixel; };
		}
	}
	//Move
	x += xspd;

// Y Movement
	// Gravity
	if hangTimer > 0
	{
		hangTimer--;
	} else {
		//apply gravity to player
	yspd += grav;
	//No longer on the ground
	setOnGround(false)
	}
	
	//Reset jump count
	if onGround
	{
		jumpCount = 0;
		hangJumpTimer = hangJumpFrames;
	} else {
		//If the player is in the air, make sure they can't do an extra jump
		hangJumpTimer --;
		if jumpCount == 0 && hangJumpTimer <= 0 {jumpCount = 1; };
	}
	
	//Start the Jump
	if jumpKeyBuffered && !downKey &&  jumpCount < jumpMax
	{
		//Reset the buffer
		jumpKeyBuffered = false;
		JumpKeyBufferTimer = 0;
		//increase the number of jumps preformered
		jumpCount++;
		//Set the Jump Hold Timer
		jumpHoldTimer = jumpHoldFrames[jumpCount-1];
		//Tell ourselves we are no longer on the ground
		setOnGround(false)
	}
	
	//Cut off the jump
	if !jumpKey 
	{
		jumpHoldTimer = 0;
	}
	
	//Jump based on the timer / holding button
	if jumpHoldTimer > 0
	{
	yspd = jspd[jumpCount-1];
	//Count down the timer
	jumpHoldTimer --;
	}
	//Cap falling speed
	if yspd > termVel {yspd = termVel;}
	
	// Y Collision
	_subPixel = .5;
	
	//Upwards Y Collision (with ceiling slopes)
	if yspd = 0 && place_meeting( x, y + yspd, oWall)
	{
		//Jump into Sloped cielings
		var _slopeSlide = false;
		
		//Slide up left slopes
		if moveDir == 0 && !place_meeting( x - abs(yspd)-1, y + yspd, oWall)
		{
			while place_meeting( x, y + yspd, oWall) {x -= 1;};
			_slopeSlide = true;
		}
		
		//Slide Up Right slope
		if moveDir == 0 && !place_meeting (x + abs(yspd)+1, y + yspd, oWall)
		{
		while place_meeting(x, y +yspd, oWall) {x += 1;};
		_slopeSlide = true; 
		}

	//Normal Y Collision
	if !_slopeSlide 
	{
		var _pixelCheck = _subPixel * sign(yspd)
		while !place_meeting(x, y + _pixelCheck, oWall)
		{ 
			y += _pixelCheck;
		}
		yspd = 0;
	}
	}
	// Downwards Y Collision head bonk?
	if yspd >= 0
	
		//Head bonk
		if yspd < 0
		{
			jumpHoldTimer = 0
		}
			
		//Floor Collisions
		
		//Check for solid and semisold platforms under me
		var _clampYspd = max(0, yspd);
		var _list = ds_list_create(); //create a DS list to store all the objects we run into
		var _array = array_create(0);
		array_push( _array, oWall, oSemiSolidWall );
		
		//Do the actual check and add objects to list
		var _listSize = instance_place_list(x, y+1 + _clampYspd + termVel, _array, _list, false );
		
		/////////////////FIX FOR HIGH REZ / HIGH SPEED PROJECTS - Check for a semisold plat below me
		var _yCheck = y+1 + _clampYspd;
		if instance_exists(myFloorPlat) { _yCheck += max(0, myFloorPlat.yspd) };
		var _semiSolid = checkForSemiSolidPlatform(x, _yCheck);
		
		//Loop through the colliding instances and only return one if it's top is below the player
		for(var i = 0; i < _listSize; i++)
		{
			//Get and inststace of oWall or oSemiSolidWall from the list
			var _listInst = _list[| i]
			
			//Avoid magnetism
			if (_listInst != forgetSemiSolid
			&& ( _listInst.yspd <= yspd || instance_exists(myFloorPlat) )
			&& ( _listInst.yspd > 0 || place_meeting(x,y+1 + _clampYspd, _listInst) ) ) 
			|| (_listInst == _semiSolid) ////High speed fix
			{
			//Return a solid wall or any semisolid walls that are below the player
			if _listInst.object_index == oWall
			|| object_is_ancestor( _listInst.object_index, oWall )
			|| floor(bbox_bottom) <= ceil( _listInst.bbox_top - _listInst.yspd )
			{
				//Return the highest wall object
				if !instance_exists(myFloorPlat)
				|| _listInst.bbox_top + _listInst.yspd <= myFloorPlat.bbox_top + myFloorPlat.yspd
				|| _listInst.bbox_top + _listInst.yspd <= bbox_bottom
				{
					myFloorPlat = _listInst;
				}
		}
		}
	}	
		//Destroy the DS list to avoid a memory leak
		ds_list_destroy(_list);
		
		//Downslope semisolid for making sure we don't miss semisolids while going down slopes
		if instance_exists(downSlopeSemiSolid) { myFloorPlat = downSlopeSemiSolid};
		
		//One last check to make sure the floor platform is actually below us
		if instance_exists(myFloorPlat) && !place_meeting( x, y + termVel, myFloorPlat)
		{ 
			myFloorPlat = noone;
		}
		
		//Land on the ground platform if there is one
		if instance_exists(myFloorPlat)
{
	//Scoot up to our wall precisely
	_subPixel = .5
	while !place_meeting( x, y + _subPixel, myFloorPlat) && !place_meeting(x, y, oWall) {y += _subPixel;}
	//Make sure we don't end up below the top of a semilsolid
	if myFloorPlat.object_index == oSemiSolidWall || object_is_ancestor(myFloorPlat.object_index, oSemiSolidWall)
	{
		while place_meeting( x, y, myFloorPlat ) {y -= _subPixel;};	
	}
	
	//Floor the y variable
	y = floor(y);
	
	//collision with the ground
	yspd = 0
	setOnGround(true);
}


//Manually fall through a semisold platform
	if downKey && jumpKeyPressed
	{
			//Make sure we have a floor platform that is a semisolid
		if instance_exists(myFloorPlat)
		&& (myFloorPlat.object_index == oSemiSolidWall || object_is_ancestor(myFloorPlat.object_index, oSemiSolidWall) )
		{
			//Check if we can go below the semi soldi
			 _yCheck = y + max( 1, myFloorPlat.yspd+1);
			if !place_meeting(x, y + _yCheck, oWall)
			{
				//Me below the platform
				y += 1;
				
				//inherit any downard speed from my floor platform so it doesn't catch me
				yspd = _yCheck-1;
				
				//Forget this platform for a brief time so we don't get caught again
				forgetSemiSolid = myFloorPlat;
				
				//No more floor platform
				setOnGround(false);
			}
		}	
	}
	
	
	//Move
	y += yspd;
	
	//reset forgetSemiSolid
	if instance_exists(forgetSemiSolid) && !place_meeting(x, y, forgetSemiSolid)
	{
		forgetSemiSolid = noone;
	}
	
//Final moving platform collisisons and movement	
	//X - movePlatXspd
	//Get the movePlatXspd
	moveplayXspd = 0
	if instance_exists(myFloorPlat) {moveplayXspd = myFloorPlat.xspd; };
	//Move with movePlatXspd
	if place_meeting(x + moveplayXspd, y, oWall)
	{
		//Scoot up to the wall precisely
		_subPixel = .5;
		var _pixelCheck = _subPixel * sign(moveplayXspd);
		while !place_meeting(x + _pixelCheck, y, oWall)
		{
			x += _pixelCheck
		}
		//Set movePlatXspd to 0 to finish collision
		moveplayXspd = 0;
	}
		//move
		x += moveplayXspd;
	
	//Y -Snap myself to myFloorPlat if it's moving vertically
	if instance_exists(myFloorPlat) 
	&& ( myFloorPlat.yspd != 0
	|| myFloorPlat.object_index == oMovePlat
	|| object_is_ancestor(myFloorPlat.object_index, oMovePlat)
	|| myFloorPlat.object_index == oSemiSolidPlatMove
	|| object_is_ancestor(myFloorPlat.object_index, oSemiSolidPlatMove) )
	{
		if !place_meeting(x, myFloorPlat.bbox_top, oWall)
		&& myFloorPlat.bbox_top >= bbox_bottom - termVel
		{
			y = myFloorPlat.bbox_top;
		}
		
		//Going up into a solid wall while on a semisolid platform
		if myFloorPlat.yspd < 0 && place_meeting( x, y +myFloorPlat.yspd, oWall)
		{
			//Get pushed down through the semisold floor platform
			if myFloorPlat.object_index == oSemiSolidWall || object_is_ancestor(myFloorPlat.object_index, oSemiSolidWall)
			{
				//Get pushed down through the semisold
				while place_meeting( x, y + myFloorPlat.yspd, oWall) { y+= _subPixel; };
				//If we got pushed into a solid wall while going downwards, push outselves back out
				while place_meeting(x, y, oWall) { y -= _subPixel; };
				y = round(y);
			}
			//cancel myFloorPlat variable
			setOnGround(false);
		}
	}
	
//sprite control
	//Walking
	if abs(xspd) > 0 {sprite_index = walkSpr}
	//Not moving
	if xspd == 0 {sprite_index = idleSpr}
	//in the Air
	if !onGround {sprite_index = jumpSpr }
		//set collision mask
		mask_index = maskSpr; 