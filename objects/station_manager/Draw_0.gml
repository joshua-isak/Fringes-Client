/// @description Draw station map

// Draw a directory of all spaceports on the left side of the screen

// Offset to draw this text from;
var t_off_x = 10;
var t_off_y = 600;

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(font_courierbaltic_15);
draw_text(t_off_x, t_off_y, "Station Directory:");
draw_set_font(font_cascadia_12);
t_off_y += 20;

// Iterate through all stations and draw their information
for (var k = ds_map_find_first(stations); !is_undefined(k); k = ds_map_find_next(stations, k)) {
	var this_station = stations[? k];
	
	//var star_name = star_manager.stars[? this_station.address.star_id].name;
	var station_name = this_station.name;
	var station_id = string(this_station.id);
	var station_info = station_name + " (" + station_id + ")";
	
	draw_text(t_off_x, t_off_y, station_info);

	t_off_y += 17;	
}

