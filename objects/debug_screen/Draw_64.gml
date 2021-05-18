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
	
	// Draw number of packets recieved
	var info = string(networker.packet_count);
	draw_text(pos_x, temp_y, "packets_received: " + info);
	temp_y += 15;
	
	// Draw current server ip
	var info = string(networker.ip);
	draw_text(pos_x, temp_y, "server_ip: " + info);
	temp_y += 15;
}