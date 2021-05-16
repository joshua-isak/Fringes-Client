
function server_connect(ip, username, password) {
	///@description connect to a server, returns -1 for failure
	
	//Check if we're already connected
	if (networker.is_connected) {
		console_print("Error: already connected to " + networker.ip);
		return -1;
	}
		
	networker.ip = ip;
	//networker.port = 4296; //networker has this defined by default in create
	networker.username = username;
	networker.password = password;
	
	// Create a new TCP socket and connect to the server
	networker.game_socket = network_create_socket(network_socket_tcp);
	err = network_connect_raw(networker.game_socket, ip, networker.port);
	
	// If the connection fails...
	if (err < 0) {
		console_print("Error: failed to connect to server");
		return -1;
	}
	
	// Send HELLO command to server
	if (connection_send_hello(username, password) < 0) {
		console_print("Error: failed to send HELLO to server");
		return -1;
	}
	
	// Notify console of connection success
	console_print("Authenticating connection...");
	networker.is_connected = true;
	
}
	

function server_disconnect() {
	//@description Disconnect from the currently connected server
	
	// Check if we're connected
	if (networker.is_connected == false) {
		console_print("Error: not currently connected to any server");
		return -1;
	}
	
	// Close the socket if we are connected
	networker.is_connected = false;
	network_destroy(networker.game_socket);
	console_print("Disconnected from " + networker.ip);
	
	// Clear manager data!
	ds_map_clear(ship_manager.ships);
	ds_map_clear(station_manager.stations);
	
}


function connection_send_hello(username, password) {
	//@description send the HELLO command to the server
	//@param username
	//@param password
	//returns result of network_sending the data to the server
	
	var command = "HELLO";
	var command_len = string_length(command) + 1;		// +1 to include string null terminated char
	var ver_len = string_length(global.version) + 1;
	var username_len = string_length(username) + 1;
	var password_len = string_length(password) + 1;
	
	var len = command_len + ver_len + username_len + password_len + 4		// +4 to include the 4 uint8s
	
	// Buffer to contain outgoing network data
	outbuf = buffer_create(len, buffer_grow, 1);
	buffer_seek(outbuf, buffer_seek_start, 0);			
	
	// Write frame size (buffersize - 2)
	buffer_write(outbuf, buffer_u16, len);
	
	// Write command
	buffer_write(outbuf, buffer_u8, command_len);
	buffer_write(outbuf, buffer_string, command);
	
	// Write version
	buffer_write(outbuf, buffer_u8, ver_len);
	buffer_write(outbuf, buffer_string, global.version);
	
	// Write username
	buffer_write(outbuf, buffer_u8, username_len);
	buffer_write(outbuf, buffer_string, username);
	
	// Write password
	buffer_write(outbuf, buffer_u8, password_len);
	buffer_write(outbuf, buffer_string, password);
	//buffer_seek(outbuf, buffer_seek_relative, -1);
	
	
	// Send the data to the server
	var err = network_send_raw(networker.game_socket, outbuf, buffer_tell(outbuf));
	
	buffer_delete(outbuf);	// delete buffer to avoid memory leaks
	
	return err;
}


function connection_digest(inbuf, bytes_left) {
	//@description digest incoming TCP data
	if (bytes_left == 0) {
		buffer_delete(inbuf);
		return;
	}
	
	// Read in the frame length
	var frame_len = buffer_read(inbuf, buffer_u16);
	
	// Read in the command
	var command_len = buffer_read(inbuf, buffer_u8);
	var command = buffer_read(inbuf, buffer_string);
	
	switch(command) 
		{
			
		case "WELCOME":
			connection_handle_welcome();
			bytes_left = buffer_get_size(inbuf) - buffer_tell(inbuf);
			connection_digest(inbuf, bytes_left);
			break;
			
		case "SYNC_SHIP":
			connection_handle_shipsync(inbuf);
			bytes_left = buffer_get_size(inbuf) - buffer_tell(inbuf);
			connection_digest(inbuf, bytes_left)
			break;
			
		case "SYNC_STATION":
			connection_handle_stationsync(inbuf);
			bytes_left = buffer_get_size(inbuf) - buffer_tell(inbuf);
			connection_digest(inbuf, bytes_left)
			break;
	}
	
}


function connection_handle_welcome() {
	//@description handle the WELCOME server message
	console_print("Connected to " + networker.ip);	
}


function connection_handle_shipsync(inbuf) {
	//@description handle the SYNC_STATION server message
	
	// Read in the sync_type
	var command_len = buffer_read(inbuf, buffer_u8);
	var command = buffer_read(inbuf, buffer_string);
	
	// Read in the ship json data
	var json_len = buffer_read(inbuf, buffer_u16);
	var json = buffer_read(inbuf, buffer_string);
	show_debug_message(json);
	
	// Translate json string to struct
	var ship_struct = snap_from_json(json);
	
	// Add to ship_manager's data
	var ship_id = ship_struct.id;
	ship_manager.ships[? ship_id] = ship_struct;
}
	
	
function connection_handle_stationsync(inbuf) {
	//@description handle the SYNC_STATION server message
	
	// Read in the sync_type
	var command_len = buffer_read(inbuf, buffer_u8);
	var command = buffer_read(inbuf, buffer_string);
	//console_print(command);
	
	// Read in the station json data
	var json_len = buffer_read(inbuf, buffer_u16);
	var json = buffer_read(inbuf, buffer_string);
	console_print(json);
	show_debug_message(json);
	
	// Translate json string to struct
	var station_struct = snap_from_json(json);
	
	// Add to station_manager's data
	var station_id = station_struct.id;
	// this shoudln't really be here.....
	station_struct.s_x = (station_struct.address.pos_x * station_manager.grid_size) + station_manager.offset_x;
	station_struct.s_y = (station_struct.address.pos_y * station_manager.grid_size) + station_manager.offset_y;
	station_manager.stations[? station_id] = station_struct;
	
	return;
}
	

function connection_send_sendship(ship_id, dest_station_id) {
	//@description send the SEND_SHIP message to the server
	
	var command = "SEND_SHIP"
	var command_len = string_length(command) + 1;	// +1 to include string null terminated char
	
	var frame_len = command_len + 1 + 2 + 2			// +1+2+2 to include two uint16 and one uint8
	
	// Buffer to contain outgoing network data
	var outbuf = buffer_create(frame_len + 2, buffer_fixed, 1);
	buffer_seek(outbuf, buffer_seek_start, 0);
	
	// Write frame size (buffersize - 2)
	buffer_write(outbuf, buffer_u16, frame_len);
	
	// Write command
	buffer_write(outbuf, buffer_u8, command_len);
	buffer_write(outbuf, buffer_string, command);
	
	// Write ship_id
	buffer_write(outbuf, buffer_u16, ship_id);
	
	// Write dest_station_id
	buffer_write(outbuf, buffer_u16, dest_station_id);
	
	// Send the data to the server
	var err = network_send_raw(networker.game_socket, outbuf, buffer_tell(outbuf));
	buffer_delete(outbuf);	// delete buffer to avoid memory leaks
	
	return err;
}