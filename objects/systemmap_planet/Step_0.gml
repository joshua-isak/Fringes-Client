///////////////////// EVERY PLANET OBJECT SHOULD NOT BE CHECKING THIS //////////////////
if (keyboard_check_pressed(vk_f8)) {
	grid_size -= 10;	
}

if (keyboard_check_pressed(vk_f7)) {
	grid_size += 10;	
}


if (mouse_wheel_down()) {
	grid_size -= 5;	
}

if (mouse_wheel_up()) {
	grid_size += 5;	
}

///////////////////////////////////////////////////////////////////////////////////////


// Check if this planet should be drawn
if (global.current_system_map_star == star_id) {
	current_location = false;
	hover = false;
	update_orbit = !update_orbit;	// unneded, remove at some point
	
	// Re-get the struct for this planet
	delete(this_planet);
	this_planet = planet_manager.planets[? planet_id];

	// Do some trig to find this object's x and y coordinates
	var tempx = this_planet.orb_radius * cos(degtorad(this_planet.orb_degree));
	var tempy =	this_planet.orb_radius * sin(degtorad(this_planet.orb_degree));

	// Convert coordinates to grid offset size
	x = (tempx * grid_size) + offset_x
	y = (tempy * grid_size) + offset_y

	// Planet distance from star corrected to draw grid size
	grid_radius = grid_size * this_planet.orb_radius;
	
	
	// Check if this planet is being hovered over
	if (position_meeting(mouse_x, mouse_y, id)) {
		// Ignore this code if ship_infobox is currently open
		if (ship_infobox.show_infobox) { exit; }
		
		hover = true;
		
		// If mouse clicked while this object is being hovered over...
		if (mouse_check_button(mb_left)) {
			
			// Tell the server to send ship to this planet
			connection_send_sendship(ship_infobox.ship_id, this_planet.sp_id);
			ship_infobox.send_ship = false;
		}
	}
	
	// Show that this planet is the current location if selecting ship destination
	if (ship_infobox.send_ship) {
		var ship_loc = ship_manager.ships[? ship_infobox.ship_id].current_spaceport;
		var loc_addr = station_manager.stations[? ship_loc].address.planet_id;
		if (loc_addr == planet_id) { current_location = true; }
	}

}




