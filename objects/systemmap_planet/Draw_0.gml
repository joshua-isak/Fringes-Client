
// Draw this planet if the current system being viewed belongs to us
if ((global.current_system_map_star == star_id) and (room == scene_system_map)) {
		
		// Draw planet's orbit line
		draw_set_color(c_gray)
		draw_set_alpha(1)
		draw_circle(offset_x, offset_y, grid_radius, true);
		
		// Draw planet
		draw_set_color(c_orange);
		// Change color if currently being hovered over
		if (hover) { draw_set_color(c_red); }
		// Or if current location on map
		if (current_location) { draw_set_color(c_lime); }
		if (this_planet.sp_id == 0) { draw_set_color(c_white); } // draw planet as white if this planet has no station
		draw_circle(x, y, 10, true);
		
		// Draw planet name under planet
		draw_set_font(font_cascadia_12);
		draw_text(x - 4, y + 13, string(this_planet.name));
		
}