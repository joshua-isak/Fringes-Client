

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
	
	// Add cargo to ship if requirements met
	if (cargo_clicked > 0 and ship_hover > 0 and mouse_check_button_pressed(mb_left)) {
		connection_send_cargo_sp_to_ship(cargo_clicked, ship_hover);	
	}
	
	// Offset values of where first cargo info element is being drawn
	var off_x = offset_x + 8;
	var off_y = offset_y + 89;
	
	// Loop through drawn cargo manifest to check if mouse is hovering over any of them
	cargo_hover = 0;
	for (var i = 0; i < array_length(station_info.cargo); i++) {
		
		// Make sure this cargo exists in our map of all cargo
		if ( ds_map_exists(cargo_manager.cargos, station_info.cargo[i]) ) {
			
			// Check for hover
			if (point_in_rectangle(mouse_gui_x, mouse_gui_y, off_x, off_y, off_x + 450, off_y + 19)) {
				cargo_hover = cargo_manager.cargos[? station_info.cargo[i]].id;
			}
			// Check for mouse press
			if (mouse_check_button_pressed(mb_left)) {
				cargo_clicked = cargo_hover;	
			}
		}
		off_y += 19;
	}
	
	// Loop through drawn ship directory (at this station) to check if mouse is hovering over any of them
	off_x = offset_x + 508;
	off_y = offset_y + 89;
	
	// Loop through our company's ships
	ship_hover = 0;
	var company_ships = company_manager.company_struct.ships;
	for (var k = 0; k < array_length(company_ships); k++) {
		var ship = ship_manager.ships[? company_ships[k]];
		
		// Check if this ship is even at this station
		if (ship.current_spaceport != station_id or ship.travel_state != travel_state.DOCKED) { continue; }
		
		// Check for hover
		if (point_in_rectangle(mouse_gui_x, mouse_gui_y, off_x, off_y, off_x + 280, off_y + 19)) {
			ship_hover = ship.id;	
		}
		off_y += 19;
	}
}