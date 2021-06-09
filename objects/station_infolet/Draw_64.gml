
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
	scribble("[font_courierbaltic_15]" + station_name).draw(off_x, off_y);
	
	// Draw station star and planet names
	off_y += 20;
	scribble("[font_cascadia_12][c_yellow]" + star_name + " [c_orange]" + planet_name).draw(off_x, off_y);
	
	// Don't draw station info if there isn't any
	if(station_id == 0) { exit; }
	
	// Draw station level
	off_y += 17 + 5;
	scribble("[font_cascadia_12]Station level: " + string(station_level)).draw(off_x, off_y);
	
	// Draw station cargo bulletin size info
	off_y += 17;
	var cargo_len = string(array_length(cargo));
	var cargo_tot = string(station_level*10) + " ";
	scribble("[font_cascadia_12]Bulletin: " + cargo_len + "/" + cargo_tot + next_bulletin_update).draw(off_x, off_y);
}