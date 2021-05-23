
// Box Dimensions 800x500

width = 800;
height = 500;

offset_x = (display_get_gui_width() / 2) - 400;
offset_y = (display_get_gui_height() / 2) - 250;

show_debug_message(offset_x);
show_debug_message(offset_y);

ship_id = 0;
ship_info = {};

// Variables for send button
send_btn_x = offset_x + 800 - 60 - 8;
send_btn_y = offset_y + 8;

// if true next planet clicked will send current ship_id to it
send_button_hover = false;
send_ship = false;

show_infobox = false;		// whether or not to draw the infobox

// Ship variables to display, these varialble needs to be updated every step
ship_name = "";
ship_travel_state = travel_state.DOCKED;
ship_registration = "";
ship_eta = 0;	// this varialble needs to be updated every step