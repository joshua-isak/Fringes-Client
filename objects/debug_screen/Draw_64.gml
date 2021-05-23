/// @description Draw debug variables

var temp_y = pos_y;

if (draw_debug) {
	
	draw_set_font(font_consolas_12);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	// Draw current ticks per second
	var info = string(fps);
	draw_text(pos_x, temp_y, "tick_rate: " + info);
	temp_y += 15;
	
	// Draw maximum network buffer size reached
	var info = string(networker.max_network_unread)
	draw_text(pos_x, temp_y, "max_network_unread: " + info);
	temp_y += 15;
	
	// Draw number of packets recieved (calls to async networking really...)
	var info = string(networker.packet_count);
	draw_text(pos_x, temp_y, "network_calls: " + info);
	temp_y += 15;
	
	// Draw number of bytes recieved
	var info = string(networker.bytes_received);
	draw_text(pos_x, temp_y, "bytes_received: " + info);
	temp_y += 15;
	
	// Draw current server ip
	var info = string(networker.ip);
	draw_text(pos_x, temp_y, "server_ip: " + info);
	temp_y += 15;
	
	// Draw the current scene name
	var info = string(room);
	draw_text(pos_x, temp_y, "current_scene: " + info);
	temp_y += 15;
	
	// Draw the current mouse gui x coord
	var info = string(mouse_gui_x);
	draw_text(pos_x, temp_y, "mouse_gui_x: " + info);
	temp_y += 15;
	
	// Draw the current mosue gui y coord
	var info = string(mouse_gui_y);
	draw_text(pos_x, temp_y, "mouse_gui_y: " + info);
	temp_y += 15;
	
	// Draw whether next planet click will send ship
	var info = string(ship_infobox.send_ship);
	draw_text(pos_x, temp_y, "send_ship: " + info);
	temp_y += 15;
}