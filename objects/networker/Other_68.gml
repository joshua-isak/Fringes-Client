/// @description Read TCP Data

var n_id = ds_map_find_value(async_load, "id");

if (n_id == game_socket) {
    var t = ds_map_find_value(async_load, "type");
    switch(t)
        {
			
        //case network_type_connect:
        //    var sock = ds_map_find_value(async_load, "socket");
        //    ds_list_add(socketlist, sock);
        //    break;
			
        case network_type_disconnect:
			server_disconnect();
            break;
			
        case network_type_data:
            var t_buffer = ds_map_find_value(async_load, "buffer")
			var data_size = ds_map_find_value(async_load, "size")
			
			// Add this new data to the ds_queue of arrived packets
			var new_buf = buffer_create(data_size, buffer_fixed, 1);
			buffer_copy(t_buffer, 0, data_size, new_buf, 0);
			ds_queue_enqueue(new_packets, new_buf);
			packet_count += 1;
			
			//buffer_copy(t_buffer, 0, data_size, network_buffer, buffer_tell(network_buffer));
			//network_unread += data_size;
			console_print("Got packet! Size: " + string(data_size));
			//connection_digest(t_buffer, data_size);
			buffer_delete(t_buffer);
			ds_map_destroy(async_load);
            break;
        }
    }
