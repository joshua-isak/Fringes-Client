/// @description Draw Ships

// Draw each of this company's ship info on right side of the screen
offset_x = 1640;
offset_y = 20;

draw_set_alpha(1);
draw_set_color(c_white);

draw_set_font(font_cascadia_12);

for (var k = ds_map_find_first(company_manager.my_ships); !is_undefined(k); k = ds_map_find_next(company_manager.my_ships, k)) {
	var ship_id = company_manager.my_ships[? k];
	var ship = ships[? ship_id];
	
	// Draw ship info outline rectangle a different color if its currently warping
	if (ship.travel_state == travel_state.WARP) { draw_set_color(c_aqua); }
	
	draw_rectangle(offset_x, offset_y, offset_x + 240, offset_y + 100, true);
	
	draw_set_color(c_white);
	
	offset_x += 5;
	offset_y += 5;
	
	// Draw ship name
	var fullname = ship.name + " (" + string(ship.id) + ")"; 
	draw_set_font(font_courierbaltic_15);
	draw_text(offset_x, offset_y, fullname);
	
	// Draw other ship info
	draw_set_font(font_cascadia_12);
	offset_y += 25;
	draw_text(offset_x, offset_y, "Reg: " + ship.registration);
	offset_y += 16;
	var destination = station_manager.stations[? ship.next_spaceport].name;
	draw_text(offset_x, offset_y, "Dest: " + destination);
	offset_y += 16;
	var time_left = max( 0, ship.arrival_time - unix_timestamp());
	draw_text(offset_x, offset_y, "ETA: " + string(time_left) + " seconds");
	offset_y += 16;
	draw_text(offset_x, offset_y, "State: " + ship_state_string(ship.travel_state));
	
	offset_x -= 5;
	offset_y += 32;
}


// Draw each ship's current warp path
for (var k = ds_map_find_first(ships); !is_undefined(k); k = ds_map_find_next(ships, k)) {
	var ship = ships[? k];
	
	// Check if this ship belongs to this client's company
	var our_ship = false;
	if (ship.company_id == company_manager.company_id) { our_ship = true; }
	
	// Skip this ship if it is not warping
	if (ship.travel_state != travel_state.WARP) { continue; }
	
	var source = station_manager.stations[? ship.last_spaceport];
	var destination = station_manager.stations[? ship.next_spaceport];
	
	// Check if the two stations are in the same system
	var is_same_system = false;
	if (source.address.star_id == destination.address.star_id) {
		is_same_system = true;
	}
	
	// Draw intrastellar ship paths
	if (is_same_system and room == scene_system_map and global.current_system_map_star == source.address.star_id) {
		
		// Calculate ship's current position along line
		var total_travel_time = ship.arrival_time -  ship.departure_time;
		var time_left = ship.arrival_time - unix_timestamp();
		var percent_complete = time_left/total_travel_time;
		
		// Calculate source and destination points
		var s_x = planet_manager.systemmap_planets[? source.address.planet_id].x;
		var s_y = planet_manager.systemmap_planets[? source.address.planet_id].y;
		var d_x = planet_manager.systemmap_planets[? destination.address.planet_id].x;
		var d_y = planet_manager.systemmap_planets[? destination.address.planet_id].y;
		
		var dir = point_direction(s_x, s_y, d_x, d_y);
		var len = point_distance(s_x, s_y, d_x, d_y);
		var distance_complete = len * percent_complete;
		
		// Draw ship icon
		var ship_icon_x = d_x - lengthdir_x(distance_complete, dir);
		var ship_icon_y = d_y - lengthdir_y(distance_complete, dir);
		
		draw_set_alpha(1);
		draw_set_color(c_white);
		if (our_ship) { draw_set_color(c_lime); }		// draw ship with green circle if it belongs to this client's company
		draw_circle(ship_icon_x, ship_icon_y, 6, true);
		
		// Draw a line from the ship's source to its desitnation
		if (our_ship or draw_other_labels) {
			draw_set_color(c_white);
			draw_line(s_x, s_y, ship_icon_x, ship_icon_y);
			draw_set_color(c_aqua);
			var thickness = 2;
			if (!our_ship) { draw_set_color(c_white); thickness = 1; }
			draw_line_width(ship_icon_x, ship_icon_y, d_x, d_y, thickness);
		}
	
		// Draw ship registration along path
		if (our_ship or draw_other_lines) {
			draw_set_color(c_ltgray);
			if (our_ship) { draw_set_color(c_lime); }		// draw ship with green registration color if it belongs to this client's company
			draw_set_font(font_consolas_12);
			draw_text(ship_icon_x + 15, ship_icon_y - 25, ship.registration);
		}
	}
	
	
	// Draw Interstellar ship paths
	if (room == scene_star_map and !is_same_system) {
		
		// Calculate ship's current position along line
		var total_travel_time = ship.arrival_time -  ship.departure_time;
		var time_left = ship.arrival_time - unix_timestamp();
		var percent_complete = time_left/total_travel_time;
		
		// Calculate source and destination points
		var s_x = star_manager.starmap_stars[? source.address.star_id].x;
		var s_y = star_manager.starmap_stars[? source.address.star_id].y;
		var d_x = star_manager.starmap_stars[? destination.address.star_id].x;
		var d_y = star_manager.starmap_stars[? destination.address.star_id].y;
		
		var dir = point_direction(s_x, s_y, d_x, d_y);
		var len = point_distance(s_x, s_y, d_x, d_y);
		var distance_complete = len * percent_complete;
		
		// Draw ship icon
		var ship_icon_x = d_x - lengthdir_x(distance_complete, dir);
		var ship_icon_y = d_y - lengthdir_y(distance_complete, dir);
		
		draw_set_alpha(1);
		draw_set_color(c_white);
		if (our_ship) { draw_set_color(c_lime); }		// draw ship with green circle if it belongs to this client's company
		draw_circle(ship_icon_x, ship_icon_y, 6, true);
		
		// Draw a line from the ship's source to its desitnation
		if (our_ship or draw_other_labels) {
			draw_set_color(c_white);
			draw_line(s_x, s_y, ship_icon_x, ship_icon_y);
			draw_set_color(c_aqua);
			var thickness = 2;
			if (!our_ship) { draw_set_color(c_white); thickness = 1; }
			draw_line_width(ship_icon_x, ship_icon_y, d_x, d_y, thickness);
		}
	
		// Draw ship registration along path
		if (our_ship or draw_other_lines) {
			draw_set_color(c_ltgray);
			if (our_ship) { draw_set_color(c_lime); }		// draw ship with green registration color if it belongs to this client's company
			draw_set_font(font_consolas_12);
			draw_text(ship_icon_x + 15, ship_icon_y - 25, ship.registration);
		}
	}
	
	
	
	
	//var dir = point_direction(source.s_x, source.s_y, destination.s_x, destination.s_y);
	//var len = point_distance(source.s_x, source.s_y, destination.s_x, destination.s_y);
	//var distance_complete = len * percent_complete;
	
	//var ship_icon_x = destination.s_x - lengthdir_x(distance_complete, dir);
	//var ship_icon_y = destination.s_y - lengthdir_y(distance_complete, dir);
	
	//draw_set_alpha(1);
	//draw_set_color(c_white);
	//if (our_ship) { draw_set_color(c_lime); }		// draw ship with green circle if it belongs to this client's company
	//draw_circle(ship_icon_x, ship_icon_y, 6, true);
	
	// Draw a line from the ship's source to its desitnation
	//if (our_ship or draw_other_labels) {
	//	draw_set_color(c_white);
	//	draw_line(source.s_x, source.s_y, ship_icon_x, ship_icon_y);
	//	draw_set_color(c_aqua);
	//	var thickness = 2;
	//	if (!our_ship) { draw_set_color(c_white); thickness = 1; }
	//	draw_line_width(ship_icon_x, ship_icon_y, destination.s_x, destination.s_y, thickness);
	//}
	
	// Draw ship registration along path
	//if (our_ship or draw_other_lines) {
	//	draw_set_color(c_ltgray);
	//	if (our_ship) { draw_set_color(c_lime); }		// draw ship with green registration color if it belongs to this client's company
	//	draw_set_font(font_consolas_12);
	//	draw_text(ship_icon_x + 15, ship_icon_y - 25, ship.registration);
	//}
	
}