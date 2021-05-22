
offset_x = 1660; // +240
offset_y = 20;   // +50

// Whether mouse is hovering over the infolet
hover = false;

// Maybe have this only be declared once?
//enum travel_state {
//	DEPARTING,
//	ARRIVING,
//	WARP,
//	DOCKED
//}

ship_id = global.new_infolet_ship_id;

// Ship variables to display, these varialble needs to be updated every step
ship_name = "";
ship_travel_state = travel_state.DOCKED;
ship_registration = "";
ship_eta = 0;	// this varialble needs to be updated every step


