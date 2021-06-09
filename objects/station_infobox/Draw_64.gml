
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
	
	// Draw station name
	off_x += 8; off_y += 5;
	scribble("[font_courierbaltic_25]" + station_info.name).draw(off_x, off_y);
	
	// Draw station location
	off_y += 30;
	scribble("[font_courierbaltic_15][c_yellow]" + star_name + " [c_orange]" + planet_name).draw(off_x, off_y);
	
	// Draw station cargo bulletin (and next refresh time
	off_y += 30;
	var time_to_refresh = "[[" + seconds_to_clock(station_info.cu_time - unix_timestamp()) + "]";
	scribble("[font_courierbaltic_15]Cargo Bulletin:  " + time_to_refresh).draw(off_x, off_y);
	off_y += 5;
	// Loop through the station's array of cargo
	for (var i = 0; i < array_length(station_info.cargo); i++) {
		
		// Make sure this cargo exists in our map of all cargo
		if ( ds_map_exists(cargo_manager.cargos, station_info.cargo[i]) ) {
				var output = "[font_consolas_12]";	// string to draw
				off_y += 19;
				var this_cargo = cargo_manager.cargos[? station_info.cargo[i]];
				
				// Add cargo id to output
				output += "[[" + string(this_cargo.id) + "] ";
				
				// Add name to output
				output += cargo_manager.products[? this_cargo.info_id].name;
				
				// Add destination to output
				var dest_station_address = station_manager.stations[? this_cargo.dest_id].address;
				output += " ->[c_yellow] " + star_manager.stars[? dest_station_address.star_id].name;
				output += "[c_orange] " + planet_manager.planets[? dest_station_address.planet_id].name;
				
				// Draw cargo information
				scribble(output).draw(off_x, off_y);
				
				// Draw Cargo value
				var output_value = "[font_consolas_12][c_lime] CR " + string(this_cargo.value);
				scribble(output_value).draw(off_x + 285, off_y);
				
				// Delete helper structs
				delete(dest_station_address);
				delete(this_cargo);
		}
			
	}
}