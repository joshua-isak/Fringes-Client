/// @description Debug console engine

if(has_focus){
	// Hide the debug console by pressing the F12 key
	if(keyboard_check_pressed(_key_hide_console)){
		has_focus = false;
	}
	
	// On press of the execute key the console will store the first word in the "command"
	// variable and the rest in the arguments array. Then it will execute a script called
	// exactly as the command and pass the arguments array as first parameter to the script.
	if(keyboard_check_pressed(vk_enter)){
		log += chr(13) + "> " + keyboard_string;		
		
		var command = "";		
		var arguments = [];		
		for(var i = 1, count = -1, command_found = false;
				i <= string_length(keyboard_string) ; 
				i++){
			if(string_char_at(keyboard_string, i) != " "){
				if(!command_found){
					command += string_char_at(keyboard_string, i);
				} else {				
					arguments[count] += string_char_at(keyboard_string, i);
				}
			} else {
			    if(!command_found || string_length(arguments[count]) > 0){
					count++;
					arguments[count] = "";
					command_found = true;
				}				
			}
		}
		
		var script_index = asset_get_index(command);
		if(script_exists(script_index)){
			script_execute(script_index, arguments);
		}else{
			log += chr(13) + "Error: script not found";
		}		
		
		keyboard_string = "" ;
	}
} else {
	// Show the console if it's not already shown
	if (keyboard_check_pressed(_key_show_console)){
		keyboard_string = "";
		self.has_focus = true;
	}
}