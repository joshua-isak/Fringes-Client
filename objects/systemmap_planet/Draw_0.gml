
// Draw this planet if the current system being viewed belongs to us
if ((global.current_system_map_star == star_id) and (room == scene_system_map)) {
		
		// Draw a star in the middle of the system //TODO// PUT SOMEHWERE ELSE SO ONLY CALLED ONCE PER FRAME
		draw_set_color(c_yellow);
		draw_circle(offset_x, offset_y, 30, false);
		
		// Draw planet's orbit line
		draw_set_color(c_white)
		draw_set_alpha(1)
		draw_circle(offset_x, offset_y, grid_radius, true);
		
		// Draw planet
		draw_set_color(c_lime);
		draw_circle(x, y, 13, true);
		
		// Draw planet name under planet
		draw_set_font(font_cascadia_12);
		draw_text(x - 5, y + 16, string(this_planet.name));
		
}