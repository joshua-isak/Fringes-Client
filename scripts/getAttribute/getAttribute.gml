function getAttribute(argument0) {
	// @description Shows the value of an attribute for a given object
	// @param arguments an array containing any arguments needed by the script

	var object = asset_get_index(argument0[0]);
	var attribute = argument0[1];

	if (object == -1 ){
		log += chr(13) + "Error: Object "+ string(object) +" not found."
	
	}else{	
		with(object){
			var value = variable_instance_get(id, attribute);		
		}
		log += chr(13) + "[Object: " + argument0[0] + "] has " +
			 attribute + " = "+ string(value);
	}

}
