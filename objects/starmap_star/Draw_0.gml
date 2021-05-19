
// Draw this star on map if we are currently viewing the starmap
if (room == scene_star_map) {

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
	//draw_text(s_x, s_y + 29, d_name);		// don't draw star id
	draw_set_halign(fa_left);
	
}

// Draw this star in center of screen if we are currently viewing its systemmap
else if (room == scene_system_map and global.current_system_map_star == star_id) {
	
	// Draw a star in the middle of the system 
	draw_set_font(font_courierbaltic_15);
	draw_set_color(c_yellow);
	draw_circle(offset_x, offset_y, 25, false);
	
	// Draw its name underneath as well
	draw_set_halign(fa_middle);
	draw_text(offset_x, offset_y + 34, this_star.name);
	draw_set_halign(fa_left);

}

