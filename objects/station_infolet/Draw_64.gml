
var off_x = offset_x;
var off_y = offset_y;

if(show) {
	
	// Draw infolet fill and outline
	draw_set_alpha(0.9);
	draw_set_color(c_black);
	draw_rectangle(off_x, off_y, off_x + width, off_y + height, false);
	draw_set_alpha(1);
	draw_set_color(c_red);
	draw_rectangle(off_x, off_y, off_x + width, off_y + height, true);
	
	// Draw station name
	off_x += 5;
	off_y += 5;
	draw_set_color(c_white);
	draw_set_font(font_courierbaltic_15);
	draw_text(off_x, off_y, station_name);
	
}

exit;
//// Draw ship name again
//	info_x += 5;
//	info_y += 5;
//	draw_set_color(c_white);
//	draw_set_font(font_courierbaltic_15);
//	draw_text(info_x, info_y, ship_name);
	
//	// Draw ship registration
//	draw_set_font(font_cascadia_12);
//	info_y += 21;
//	draw_text(info_x, info_y, ship_registration);
	
//	// Draw ship destination very pretty
//	info_y += 25;
//	if (ship_travel_state == travel_state.WARP) { draw_text(info_x, info_y, "Destination:"); }
//	else { draw_text(info_x, info_y, "Current Location:"); }
//	info_y += 17;
	
//	// Get destination info
//	var dest_id = ship_manager.ships[? ship_id].next_spaceport;
//	var star_id = station_manager.stations[? dest_id].address.star_id;
//	var station_name = station_manager.stations[? dest_id].name;
//	var planet_id = station_manager.stations[? dest_id].address.planet_id;
//	var star_name = star_manager.stars[? star_id].name;
//	var planet_name = planet_manager.planets[? planet_id].name;
	
//	// Draw destination star
//	draw_set_color(c_yellow);
//	draw_text(info_x, info_y, star_name);
//	info_y += 17;
	
//	// Draw destination planet
//	draw_set_color(c_orange);
//	draw_text(info_x, info_y, planet_name);
//	info_y += 17;
	
//	// Draw destination station name
//	draw_set_color(c_grey);
//	draw_text(info_x, info_y, station_name);