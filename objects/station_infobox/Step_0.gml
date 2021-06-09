

if (show_infobox) {

	// Get latest station struct
	delete(station_info);						// delete last struct
	station_info = station_manager.stations[? station_id];
	
	
	// Close the infobox if escape is pressed
	if (keyboard_check(vk_escape)) {
		show_infobox = false;	
	}
	
	
	// Update station/planet variables
	var star_id = station_info.address.star_id;
	var planet_id = station_info.address.planet_id;
	star_name = star_manager.stars[? star_id].name;
	planet_name = planet_manager.planets[? planet_id].name;

	station_name = station_info.name;
	station_level = station_info.station_level;
	cargo = station_info.cargo;
	next_manifest_update = 0;		//--TODO--// UPDATE TO INCLUDE THIS
	top_product = 0;				//--TODO--// UPDATE TO INCLUDE THIS
	num_ships_present = 0;			//--TODO--// UPDATE TO INCLUDE THIS

}