
offset_x = display_get_gui_width() - 260 //1660; // +240
offset_y = display_get_gui_height()// - 20;   // +50

// Whether mouse is hovering over the infolet
hover = false;

// Used to pass in argument when infolet is created
ship_id = global.new_infolet_ship_id;

// Ship variables to display, these varialble needs to be updated every step
ship_name = "";
ship_travel_state = travel_state.DOCKED;
ship_registration = "";
ship_eta = 0;	// this varialble needs to be updated every step


