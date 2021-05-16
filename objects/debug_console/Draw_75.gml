/// @description Draw console overlay

if(self.has_focus){
	// Draw the console background
	draw_set_alpha(_log_background_alpha);
	draw_set_color(_log_background_color);		
	draw_rectangle(0, 0, screen_w, screen_h/3, false);	
	
	// Draw console log, aka previous commands
	draw_set_alpha(_log_text_alpha);
	draw_set_color(_log_text_color);	
    draw_set_valign(fa_bottom);
    draw_text(10, screen_h/3, log);
	// Draw current command background
	draw_set_alpha(_command_background_alpha);
	draw_set_color(_command_background_color);	
    draw_set_valign(fa_top);
	draw_rectangle(0, screen_h/3, screen_w, (screen_h/3) + 20, false);
	draw_set_alpha(_command_text_alpha);
	draw_set_color(_command_text_color);	
    draw_text(10, screen_h/3, "$ " + keyboard_string);	 
}
////TODO REMOVE
else {
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_text(100,100, "Press ~ to open console");
}