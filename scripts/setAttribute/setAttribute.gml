function setAttribute(argument0) {
	// @description Sets an attribute of an object to a given value
	// @param arguments an array containing any arguments needed by the script

	var object = asset_get_index(argument0[0]);
	var attribute = argument0[1];
	var value = argument0[2];


	if (object == -1 ){
		log += chr(13) + "Error: Object "+ string(object) +" not found."
	
	}else{
		if(string(real(value)) == string(value)){
			value = real(value);
		}
		with(object){
			variable_instance_set(id, attribute, value);		
		}
		log += chr(13) + "[Object: " + argument0[0] + "] set " +
			 attribute + " = "+ string(value);
	
	}


}
