/// @description Draw station map

// Draw visual map of all stations in center of screen

// offset of center of station map
offset_x = 1920 / 2;
offset_y = 1080 / 2;

draw_set_font(font_cascadia_12);

draw_set_alpha(1);
draw_set_color(c_yellow);

for (var k = ds_map_find_first(stations); !is_undefined(k); k = ds_map_find_next(stations, k)) {
	var station = stations[? k];
	
	//var s_x = (station.address.pos_x * grid_size) + offset_x;
	//var s_y = (station.address.pos_y * grid_size) + offset_y;
	
	draw_circle(station.s_x, station.s_y, 10, true);
	draw_set_halign(fa_middle);
	var d_name = "(" + string(station.id) + ")";
	draw_text(station.s_x, station.s_y + 11, station.address.star_name);
	draw_text(station.s_x, station.s_y + 29, d_name);
	draw_set_halign(fa_left);
}