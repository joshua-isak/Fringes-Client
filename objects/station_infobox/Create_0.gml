/// @description Init

// Box Dimensions 800x500

width = 800;
height = 500;

offset_x = (display_get_gui_width() / 2) - 400;
offset_y = (display_get_gui_height() / 2) - 250;



station_id = 0;


// Whether or not to draw the infobox
show_infobox = false;		

// Station variables to display, these varialble needs to be updated every step
station_info = {};		// station info struct

station_name = "";
star_name = "";
planet_name = "";

station_level = 0;
cargo = [];					// array containing station's cargo manifest
next_manifest_update = 0;
top_product = 0;
num_ships_present = 0;

// Id of cargo information currently being hovered over
cargo_hover = 0;
cargo_clicked = 0;

ship_hover = 0;
