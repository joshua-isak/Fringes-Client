/// @description Digest Network Buffer

// Add any new packets to the network buffer
var new_packet_buf = ds_queue_dequeue(new_packets)
if (new_packet_buf != undefined) {
	var new_buf_size = buffer_get_size(new_packet_buf)
	var _old_seek = buffer_tell(network_buffer);
	buffer_copy(new_packet_buf, 0, new_buf_size, network_buffer, _old_seek + network_unread);
	network_unread += new_buf_size;
	buffer_seek(network_buffer, buffer_seek_start, _old_seek);
	buffer_delete(new_packet_buf);
	//show_debug_message(_old_seek)
}

//show_debug_message(network_unread);

if (network_unread > 0) {
	// Read in the frame length
	var frame_len = buffer_read(network_buffer, buffer_u16);

	if (frame_len >= network_unread) {
		//show_debug_message("network buffer misaligned with frame! waiting for more data...");
		//show_debug_message("frame_len: " + string(frame_len));
		//show_debug_message("network_unread: " + string(network_unread));
		buffer_seek(network_buffer, buffer_seek_relative, -2);
	}
	else {
		network_unread -= 2;
		// Read in the command
		var command_len = buffer_read(network_buffer, buffer_u8);
		var command = buffer_read(network_buffer, buffer_string);
		//show_debug_message(command);
	
		switch(command) 
			{
			
			case "WELCOME":
				connection_handle_welcome();
				network_unread -= frame_len;
				break;
			
			case "SYNC_SHIP":
				connection_handle_shipsync(network_buffer);
				network_unread -= frame_len;
				break;
			
			case "SYNC_STATION":
				connection_handle_stationsync(network_buffer);
				network_unread -= frame_len;
				break;
				
			case "SEND_ERROR":
				connection_handle_error(network_buffer);
				network_unread -= frame_len;
				break;
		}
	}
}

if (network_unread == 0) {
	buffer_seek(network_buffer, buffer_seek_start, 0);	
}