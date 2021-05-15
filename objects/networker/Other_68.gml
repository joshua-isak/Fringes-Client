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
			var data_read = ds_map_find_value(async_load, "size")
			connection_digest(t_buffer, data_read);
            break;
        }
    }
