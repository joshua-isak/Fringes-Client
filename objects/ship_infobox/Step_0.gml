

if (show_infobox) {

	// Get latest ship struct
	delete(ship_struct);		// delete last struct
	ship_info = ship_manager.ships[? ship_id];
	
	
	// Close the infobox if "C" is pressed
	if (keyboard_check(ord("C"))) {
		show_infobox = false;	
	}
	
	// Check if send ship button is being hovered over
	if ( point_in_rectangle(mouse_gui_x, mouse_gui_y, send_btn_x, send_btn_y, send_btn_x + 60, send_btn_y + 30) ) {
		send_button_hover = true;
	
		// Ignore press if ship is currently warping
		if (ship_info.travel_state == travel_state.WARP) { exit; }
	
		// Check if send ship button has been pressed
		if (mouse_check_button(mb_left)) {
			send_ship = true;	
			show_infobox = false;
			room_goto(scene_star_map);
		}
	} 
	else { 
		send_button_hover = false; 
	}

}