/// @description Init

// GUI box dimensions
width = 350;
height = 220;

// Pixels to draw padded from edge of screen
edge_padding = 20;

// Whether to draw the infolet
show = false;

// Located in bottom left of screen
offset_x = edge_padding; //display_get_gui_width()
offset_y = display_get_gui_height() - height - edge_padding;

// Used to detect the station information to draw, and whether to show this object
last_planet_hovered = 0;
//last_planet_hover = false;

// Variables needed to display station information
station_id = 0;

// Need to be updated every step
station_name = "";
star_name = "";
planet_name = "";
station_level = 0;
cargo = [];					// array containing station's cargo manifest
next_bulletin_update = "";
top_product = 0;
num_ships_present = 0;

