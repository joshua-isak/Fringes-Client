/// @func   seconds_to_clock([seconds])
///
/// @desc   Returns a string formatted MM:SS for the int seconds
///
/// @param  {real}      [seconds]  number of seconds

function seconds_to_clock(seconds){
	
	var minutes = seconds div 60;
	var new_sec = seconds mod 60;
	
	var output = "";
	
	output += string(minutes) + ":";
	
	if (new_sec < 10) {
		output += "0";	
	}
	
	if (new_sec < 0) {
		new_sec = 0;	// don't return a negative time
	}
	
	output += string(new_sec);
	
	return output;

}