/// @description Draw Ships

// Draw each ship's info on right side of the screen
offset_x = 1640;
offset_y = 20;

draw_set_alpha(1);
draw_set_color(c_white);

for (var k = ds_map_find_first(ships); !is_undefined(k); k = ds_map_find_next(ships, k)) {
	var ship = ships[? k];
	
	// Draw ship info outline rectangle a different color if its currently warping
	if (ship.travel_state == travel_state.WARP) { draw_set_color(c_aqua); }
	
	draw_rectangle(offset_x, offset_y, offset_x + 240, offset_y + 100, true);
	
	draw_set_color(c_white);
	
	offset_x += 5;
	offset_y += 5;
	
	var fullname = ship.name + " (" + string(ship.id) + ")"; 
	draw_text(offset_x, offset_y, fullname);
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
	
	// Skip this ship if it is not warping
	if (ship.travel_state != travel_state.WARP) { continue; }
	
	var source = station_manager.stations[? ship.last_spaceport];
	var destination = station_manager.stations[? ship.next_spaceport];

	// Draw ship's current position along line
	var total_travel_time = ship.arrival_time -  ship.departure_time;
	var time_left = ship.arrival_time - unix_timestamp();
	var percent_complete = time_left/total_travel_time;
	
	var dir = point_direction(source.s_x, source.s_y, destination.s_x, destination.s_y);
	var len = point_distance(source.s_x, source.s_y, destination.s_x, destination.s_y);
	var distance_complete = len * percent_complete;
	
	var ship_icon_x = destination.s_x - lengthdir_x(distance_complete, dir);
	var ship_icon_y = destination.s_y - lengthdir_y(distance_complete, dir);
	
	draw_set_color(c_white);
	draw_circle(ship_icon_x, ship_icon_y, 6, true);
	draw_text(ship_icon_x + 15, ship_icon_y - 25, ship.registration);
	
	// Draw a line from the ship's source to its desitnation
	//draw_set_color(c_green);
	draw_line(source.s_x, source.s_y, ship_icon_x, ship_icon_y);
	draw_set_color(c_aqua);
	draw_line_width(ship_icon_x, ship_icon_y, destination.s_x, destination.s_y, 2);
	
}