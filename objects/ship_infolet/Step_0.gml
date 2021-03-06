

// Make sure all ship information is latest
var ship_info = ship_manager.ships[? ship_id];

ship_name = ship_info.name;
ship_registration = ship_info.registration;
ship_travel_state = ship_info.travel_state;
ship_eta = max( 0, ship_info.arrival_time - unix_timestamp());

// delete struct to avoid memory leaks
delete(ship_info);

// Check if mouse is hovering over this info

if (point_in_rectangle(mouse_gui_x, mouse_gui_y, offset_x, offset_y, offset_x + 240, offset_y + 50)) {
	hover = true;	
	
	// Check if the box is clicked
	if (mouse_check_button(mb_left)) {
		ship_infobox.show_infobox = true;
		ship_infobox.ship_id = ship_id;
		ship_infobox.send_ship = false;
		
		// Close station infobox if open
		station_infobox.show_infobox = false;
	}
	
	
} else {
	hover = false;
}