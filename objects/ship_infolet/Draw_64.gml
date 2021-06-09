// Draw each of this company's ship info on right side of the screen
var off_x = offset_x;
var off_y = offset_y;

draw_set_color(c_white);

// draw slightly transparent fill rectangle
draw_set_alpha(0.8);
draw_set_color(c_black)
draw_rectangle(offset_x, offset_y, offset_x + 240, offset_y + 50, false);
draw_set_alpha(1);

draw_set_color(c_white);
// Draw ship info outline rectangle a different color if its currently warping
if (ship_travel_state == travel_state.WARP) { draw_set_color(c_aqua); }

// Draw box outline red if this object is currently being hovered over by the mouse
if (hover) { draw_set_color(c_red); }

draw_rectangle(offset_x, offset_y, offset_x + 240, offset_y + 50, true);

off_x += 5;
off_y += 5;

// Draw ship name
draw_set_color(c_white);
draw_set_font(font_courierbaltic_15);
draw_text(off_x, off_y, ship_name);

// Draw ship registration
draw_set_font(font_cascadia_12);
off_y += 21;
draw_text(off_x, off_y, ship_registration);

// Draw ship ETA
if (ship_eta != 0) {
	off_x += 170
	var info = "[" + seconds_to_clock(ship_eta) + "]";
	draw_text(off_x, off_y, info);
}

// Draw ship expanded infobox on hover
if (hover) {
	var info_x = offset_x - 240;
	var info_y = _gui_parent.ship_infolet_y;
	
	// draw slightly transparent fill rectangle
	draw_set_alpha(0.8);
	draw_set_color(c_black)
	draw_rectangle(info_x, info_y, info_x + 230, info_y + 250, false);
	// draw red outline
	draw_set_alpha(1);
	draw_set_color(c_red);
	draw_rectangle(info_x, info_y, info_x + 230, info_y + 250, true);
	
	// Draw ship name again
	info_x += 5;
	info_y += 5;
	draw_set_color(c_white);
	draw_set_font(font_courierbaltic_15);
	draw_text(info_x, info_y, ship_name);
	
	// Draw ship registration
	draw_set_font(font_cascadia_12);
	info_y += 21;
	draw_text(info_x, info_y, ship_registration);
	
	// Draw ship destination very pretty
	info_y += 25;
	if (ship_travel_state == travel_state.WARP) { draw_text(info_x, info_y, "Destination:"); }
	else { draw_text(info_x, info_y, "Current Location:"); }
	info_y += 17;
	
	// Get destination info
	var dest_id = ship_manager.ships[? ship_id].next_spaceport;
	var star_id = station_manager.stations[? dest_id].address.star_id;
	var station_name = station_manager.stations[? dest_id].name;
	var planet_id = station_manager.stations[? dest_id].address.planet_id;
	var star_name = star_manager.stars[? star_id].name;
	var planet_name = planet_manager.planets[? planet_id].name;
	
	// Draw destination star
	draw_set_color(c_yellow);
	draw_text(info_x, info_y, star_name);
	info_y += 17;
	
	// Draw destination planet
	draw_set_color(c_orange);
	draw_text(info_x, info_y, planet_name);
	info_y += 17;
	
	// Draw destination station name
	draw_set_color(c_grey);
	draw_text(info_x, info_y, station_name);
	
	// Draw WARPING infotext and ETA if the ship is warping
	if (ship_travel_state == travel_state.WARP) {
		info_y += 25;
		draw_set_color(c_aqua);
		draw_text(info_x, info_y, "WARPING");
		
		info_y += 17;
		draw_set_color(c_white);
		draw_text(info_x, info_y, "ETA: " + seconds_to_clock(ship_eta) );
	}
	
}