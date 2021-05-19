
// Draw this star on map if we are currently viewing the starmap
if (room == scene_star_map) {
	
	//// Get the struct for this star
	//var this_star = star_manager.stars[? star_id];


	// Draw star on map
	draw_set_font(font_cascadia_12);
	draw_set_alpha(1);
	draw_set_color(c_yellow);
	
	// Change color of circle if mouse is hovering over this object
	if (hover) { draw_set_color(c_red); }
	
	draw_circle(s_x, s_y, 10, true);
	draw_set_halign(fa_middle);
	var d_name = "(" + string(this_star.id) + ")";
	draw_text(s_x, s_y + 11, this_star.name);
	draw_text(s_x, s_y + 29, d_name);
	draw_set_halign(fa_left);
	
}






//for (var k = ds_map_find_first(stations); !is_undefined(k); k = ds_map_find_next(stations, k)) {
//	var station = stations[? k];
	
//	var s_x = (station.address.pos_x * grid_size) + offset_x;
//	var s_y = (station.address.pos_y * grid_size) + offset_y;
	
//	draw_circle(station.s_x, station.s_y, 10, true);
//	draw_set_halign(fa_middle);
//	var d_name = "(" + string(station.id) + ")";
//	draw_text(station.s_x, station.s_y + 11, station.address.star_name);
//	draw_text(station.s_x, station.s_y + 29, d_name);
//	draw_set_halign(fa_left);
//}

//station_struct.s_x = (station_struct.address.pos_x * station_manager.grid_size) + station_manager.offset_x;
//station_struct.s_y = (station_struct.address.pos_y * station_manager.grid_size) + station_manager.offset_y;