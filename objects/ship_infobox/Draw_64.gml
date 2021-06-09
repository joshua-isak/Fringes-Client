
var off_x = offset_x;
var off_y = offset_y;

if (show_infobox) {
	
	// Draw infobox box fill and outline
	draw_set_alpha(0.9);
	draw_set_color(c_black);
	draw_rectangle(off_x, off_y, off_x + width, off_y + height, false);
	draw_set_alpha(1);
	draw_set_color(c_white)
	draw_rectangle(off_x, off_y, off_x + width, off_y + height, true);

	// Draw ship name and registration
	draw_set_font(font_courierbaltic_25);
	off_x += 8; off_y += 5;
	draw_text(off_x, off_y, ship_info.name);
	off_y += 30;
	draw_set_font(font_courierbaltic_15);
	draw_text(off_x, off_y, ship_info.registration);
	
	// Draw other ship information
	draw_set_font(font_cascadia_12);
	off_y += 30;
	var info = string(ship_info.warps)
	draw_text(off_x, off_y, "Total warps: " + info);
	off_y += 17;
	info = string(ship_info.reliability);
	draw_text(off_x, off_y, "Reliability: " + info);
	off_y += 17;
	draw_text(off_x, off_y, "Warp drive:  Class II");
	
	// Draw ship cargo manifest
	off_y += 60;
	draw_set_font(font_courierbaltic_15);
	draw_text(off_x, off_y, "Cargo Manifest:   0/4");
	
	// draw manifest box
	off_y += 25;
	draw_rectangle(off_x, off_y, off_x + 350, off_y + 310, true);
	
	
	// Draw send button
	draw_set_color(c_aqua);
	if (send_button_hover) { draw_set_color(c_red); }
	if (ship_info.travel_state == travel_state.WARP) { draw_set_color(c_red); }
	draw_rectangle(send_btn_x, send_btn_y, send_btn_x + 60, send_btn_y + 30, true);
	draw_set_font(font_courierbaltic_15);
	draw_text(send_btn_x + 6, send_btn_y + 4, "SEND");
	
	
	// Draw ship destination very pretty
	draw_set_font(font_cascadia_12);
	draw_set_color(c_white);
	var info_x = offset_x + 250;
	var info_y = offset_y + 65;
	if (ship_info.travel_state == travel_state.WARP) { draw_text(info_x, info_y, "Destination:"); }
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
	
}

// Draw info on top of screen that next planet click will send ship to it
if (send_ship) {
	draw_set_font(font_courierbaltic_25);
	draw_set_color(c_fuchsia);
	draw_set_halign(fa_center);
	var info = ship_info.registration;
	draw_text(display_get_gui_width()/ 2, 25, "Select destination for " + info + ":");
	draw_set_halign(fa_left);
}
