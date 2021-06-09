/// @description Digest Network Buffer

// Add any new packets to the network buffer
var new_packet_buf = ds_queue_dequeue(new_packets)
if (new_packet_buf != undefined) {
	var new_buf_size = buffer_get_size(new_packet_buf)
	var _old_seek = buffer_tell(network_buffer);
	buffer_copy(new_packet_buf, 0, new_buf_size, network_buffer, _old_seek + network_unread);
	network_unread += new_buf_size;
	bytes_received += new_buf_size;
	buffer_seek(network_buffer, buffer_seek_start, _old_seek);
	buffer_delete(new_packet_buf);
	if (network_unread > max_network_unread) { max_network_unread = network_unread; }
}

//--TODO--// Update this to keep processing packets until it cannot anymore for this cycle!!!
if (network_unread > 0) {
	// Read in the frame length
	var frame_len = buffer_read(network_buffer, buffer_u16);

	if (frame_len >= network_unread) {
		buffer_seek(network_buffer, buffer_seek_relative, -2);
	}
	else {
		network_unread -= 2;
		// Read in the command
		var command_len = buffer_read(network_buffer, buffer_u8);
		var command = buffer_read(network_buffer, buffer_string);
	
		switch(command) 
			{
			
			case "WELCOME":
				connection_handle_welcome();
				network_unread -= frame_len;
				break;
				
			case "SYNC_STAR":
				connection_handle_starsync(network_buffer);
				network_unread -= frame_len;
				break;
				
			case "SYNC_PLANET":
				connection_handle_planetsync(network_buffer);
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
				
			case "SYNC_COMPANY":
				connection_handle_companysync(network_buffer);
				network_unread -= frame_len;
				break;
				
			case "SYNC_CARGO":
				connection_handle_cargosync(network_buffer);
				network_unread -= frame_len;
				break;
				
			case "SEND_ERROR":
				connection_handle_error(network_buffer);
				network_unread -= frame_len;
				break;
		}
	}
}

// Reset the seek of the network buffer if there aren't any new frames to digest this step
if (network_unread == 0) {
	buffer_seek(network_buffer, buffer_seek_start, 0);	
}