///@func appraoch(a, b, amount)
///@desc this is similar to a lerp, but instead the amount value is also a real number
///@arg0 the starting value
///@arg1 the target value
///@arg2 the amount the starting value should move towards the target value
function approach(_a, _b, _amount){
	if (_a < _b)
	{
	    _a += _amount;
	    if (_a > _b)
	        return _b;
	}
	else
	{
	    _a -= _amount;
	    if (_a < _b)
	        return _b;
	}
	return _a;
}