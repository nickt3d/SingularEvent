//Custom function for player
function setOnGround(_val = true)

{
	if _val == true
	{
		onGround = true;
		hangTimer = hangTime;
	} else {
		onGround = false;
		myFloorPlat = noone;
		hangTimer = 0;
	}
}

function checkForSemiSolidPlatform (_x, _y)
{ 
	//create a return variable
	var _rtrn = noone;
	
	//we must not not be moving upwards, and then we check for a normal collisions
	if yspd >= 0 && place_meeting(_x, _y, oSemiSolidWall)
	{
		//create a ds list to store all colliding instances of oSemiSolidWall
		var _list = ds_list_create();
		var _listSize =instance_place_list( _x, _y, oSemiSolidWall, _list, false);
		
		//loop throug the colliding instances and only return one if it's top is below the player
		for (var i = 0; i < _listSize; i++)
		{
			var _listInst = _list[| i];
			if _listInst != forgetSemiSolid && floor(bbox_bottom) <= ceil (_listInst.bbox_top - _listInst.yspd)
			{
				//Return the id of a semisolid platform
				_rtrn = _listInst
				//Exit the loop early
				i = _listSize;
			}
		}
		//Destroy ds list to free memory
		ds_list_destroy(_list);
	}
	//return our variable
	return _rtrn;
}



depth = -30;

//Control setup
controlsSetup();

//Sprites
maskSpr = sPlayer;
idleSpr = sPlayer;
walkSpr = sPlayerAni;
jumpSpr = sPlayerJ;

// Moving
face = 1
moveDir = 0;
moveSpd = 2;
xspd = 0;
yspd = 0;

// Jumping

grav = .3;
termVel = 4;
onGround = true;
jspd = -2
jumpMax = 2; //change to 1 and upgrade will set to 2
jumpCount = 0;
jumpHoldTimer = 0;

	jumpHoldFrames[0]= 18;
	jspd[0] = -3.15;
	jumpHoldFrames[1] =10;
	jspd[1] = -2

//Coyote Time
hangTime = 2;
hangTimer = 0;

hangJumpFrames = 4;
hangJumpTimer = 0;

//Moving Platforms
myFloorPlat = noone;
downSlopeSemiSolid = noone;
forgetSemiSolid = noone;
moveplayXspd = 0;









