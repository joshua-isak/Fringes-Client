
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
	networker.ip = ""
	networker.is_connected = false;
	networker.packet_count = 0;
	network_destroy(networker.game_socket);
	console_print("Disconnected from " + networker.ip);
	
	// Clear manager data!
	ds_map_clear(ship_manager.ships);
	ds_map_clear(station_manager.stations);
	ds_map_clear(company_manager.my_ships);
	ds_map_clear(company_manager.companies);
	//TODO ADD MORE!!!
	
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


function connection_handle_welcome() {
	//@description handle the WELCOME server message
	console_print("Connected to " + networker.ip);	
}


function connection_handle_starsync(inbuf) {
	//@description handle the SYNC_STAR server message
	
	// Read in the sync_type
	var command_len = buffer_read(inbuf, buffer_u8);
	var command = buffer_read(inbuf, buffer_string);
	
	// Read in the star json data
	var json_len = buffer_read(inbuf, buffer_u16);
	var json = buffer_read(inbuf, buffer_string);
	
	// Translate json string to struct
	var star_struct = snap_from_json(json);
	
	// Add to star_manager's data
	var star_id = star_struct.id;
	star_manager.stars[? star_id] = star_struct;
	
	// Create a new object for the starmap
	global.new_starmap_star_id = star_id;	// workaround to pass argument into create event
	instance_create_layer(0, 0, "Instances", starmap_star);
	
	delete(star_struct);
}


function connection_handle_planetsync(inbuf) {
	//@description handle the SYNC_PLANET server message
	
	// Read in the sync_type
	var command_len = buffer_read(inbuf, buffer_u8);
	var command = buffer_read(inbuf, buffer_string);
	
	// Read in the planet json data
	var json_len = buffer_read(inbuf, buffer_u16);
	var json = buffer_read(inbuf, buffer_string);
	
	// Translate json string to struct
	var planet_struct = snap_from_json(json);
	
	var planet_id = planet_struct.id;
	
	switch(command) 
		{
		case "INITIAL":
			// Add to planet_manager's data
			planet_manager.planets[? planet_id] = planet_struct;
			// Create a new object for the system
			global.new_systemmap_planet_id = planet_id;	// workaround to pass argument into create event
			instance_create_layer(0, 0, "Instances", systemmap_planet);
			break;
		
		case "ORBIT_UPDATE":
			planet_manager.planets[? planet_id].orb_degree = planet_struct.orb_degree;
			var planet_obj = planet_manager.systemmap_planets[? planet_id].id;
			variable_instance_set(planet_obj, "this_planet.orb_degree", planet_struct.orb_degree);
			variable_instance_set(planet_obj, "update_orbit", true);
			break;
		}
		
	delete(planet_struct);
}


function connection_handle_cargosync(inbuf) {
	//@description handle the SYNC_CARGO server message
	
	// Read in the sync_type
	var command_len = buffer_read(inbuf, buffer_u8);
	var command = buffer_read(inbuf, buffer_string);
	
	// Read in the cargo json data
	var json_len = buffer_read(inbuf, buffer_u16);
	var json = buffer_read(inbuf, buffer_string);
	
	// Translate json string to struct
	var cargo_struct = snap_from_json(json);
	
	var cargo_id = cargo_struct.id;
	
	switch(command)
		{
		case "PRODUCT":
			// Add to cargo manager's map of all products
			cargo_manager.products[? cargo_id] = cargo_struct;
			break;
			
		case "INITIAL":
			// Add to cargo manager's map of all cargos
			cargo_manager.cargos[? cargo_id] = cargo_struct;
			break;
			
		case "DESTROY":
			// Remove from cargo manager's map of all cargos
			ds_map_delete(cargo_manager.cargos, cargo_id);
			break;
		}
		
	delete(cargo_struct);
}


function connection_handle_shipsync(inbuf) {
	//@description handle the SYNC_SHIP server message
	
	// Read in the sync_type
	var command_len = buffer_read(inbuf, buffer_u8);
	var command = buffer_read(inbuf, buffer_string);
	
	// Read in the ship json data
	var json_len = buffer_read(inbuf, buffer_u16);
	var json = buffer_read(inbuf, buffer_string);
	
	// Translate json string to struct
	var ship_struct = snap_from_json(json);
	
	var ship_id = ship_struct.id;
	
	switch(command)
		{
		case "INITIAL":
			// Add to ship_manager's data
			ship_manager.ships[? ship_id] = ship_struct;
			break;
				
		case "RENAME":
			// Update ship's name
			ship_manager.ships[? ship_id].name = ship_struct.name;
			
		case "DEPART":
			// Update relevant departure variables //--TODO--// Make this not update everything...
			ship_manager.ships[? ship_id] = ship_struct;
			break;
			
		case "ARRIVE":
			// Update relevant arrival variables //--TODO--// Make this not update everything...
			ship_manager.ships[? ship_id] = ship_struct;
			break;
				
		case "CARGO":
			// Update ship's cargo data
			ship_manager.ships[? ship_id].cargo = ship_struct.cargo;
			break;
		}
	
	delete(ship_struct);
}
	
	
function connection_handle_stationsync(inbuf) {
	//@description handle the SYNC_STATION server message
	
	// Read in the sync_type
	var command_len = buffer_read(inbuf, buffer_u8);
	var command = buffer_read(inbuf, buffer_string);
	
	// Read in the station json data
	var json_len = buffer_read(inbuf, buffer_u16);
	var json = buffer_read(inbuf, buffer_string);
	
	// Translate json string to struct
	var station_struct = snap_from_json(json);
	
	var station_id = station_struct.id;
	
	switch(command)
		{
		case "INITIAL":
			// Add to station_manager's data
			station_manager.stations[? station_id] = station_struct;
			break;
			
		case "CARGO":
			station_manager.stations[? station_id].cargo = station_struct.cargo;
			station_manager.stations[? station_id].cu_time = station_struct.cu_time;
			break;
		}
	
	delete(station_struct);
	
	return;
}
	

function connection_handle_companysync(inbuf) {
	//@description handle the SYNC_COMPANY server message
	
	// Read in the sync_type
	var command_len = buffer_read(inbuf, buffer_u8);
	var command = buffer_read(inbuf, buffer_string);
	
	// Read in the company json data
	var json_len = buffer_read(inbuf, buffer_u16);
	var json = buffer_read(inbuf, buffer_string);
	console_print(json);
	
	// Translate json string to struct
	var company_struct = snap_from_json(json);
	
	// Add to company manager's data
	var company_id = company_struct.id;
	company_manager.companies[? company_id] = company_struct;
	if (company_struct.user == networker.username) {
		console_print("Our company id is: " + string(company_struct.id));
		
		company_manager.company_id = company_struct.id;
		company_manager.company_struct = company_struct;
		
		var off_x = _gui_parent.ship_infolet_x;
		var off_y = _gui_parent.ship_infolet_y;
		
		// Create infolets for each of our company's ships
		for (i = 0; i < company_struct.num_ships; i++){
			var ship_id = company_struct.ships[i]
			ds_map_add(company_manager.my_ships, i, ship_id);
			global.new_infolet_ship_id = ship_id;
			var new_infolet = instance_create_depth(off_x, off_y, 0, ship_infolet)
			new_infolet.offset_y = off_y;
			off_y += 60;
		}
	}
	
	delete(company_struct);
	
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


function connection_send_renameship(ship_id, new_name) {
	//@desc rename a ship_id's name to new_name	
	
	var command = "RENAME"
	var command_len = string_length(command) + 1;	// +1 to include string null terminated char
	var sub_command = "SHIP"
	var sub_len = string_length(sub_command) + 1;
	var name_len = string_length(new_name) + 1;
	
	var frame_len = command_len + sub_len + name_len + 1 + 1 + 1 + 2
	
	// Buffer to contain outgoing network data
	var outbuf = buffer_create(frame_len + 2, buffer_fixed, 1);
	buffer_seek(outbuf, buffer_seek_start, 0);
	
	// Write frame size (buffersize - 2)
	buffer_write(outbuf, buffer_u16, frame_len);
	
	// Write command
	buffer_write(outbuf, buffer_u8, command_len);
	buffer_write(outbuf, buffer_string, command);
	
	// Write sub_command
	buffer_write(outbuf, buffer_u8, sub_len);
	buffer_write(outbuf, buffer_string, sub_command);
	
	// Write new_name
	buffer_write(outbuf, buffer_u8, name_len);
	buffer_write(outbuf, buffer_string, new_name);
	
	// Write id of ship to rename
	buffer_write(outbuf, buffer_u16, ship_id);
	
	// Send the data to the server
	var err = network_send_raw(networker.game_socket, outbuf, buffer_tell(outbuf));
	buffer_delete(outbuf);	// delete buffer to avoid memory leaks
	
	return err;
	
}


function connection_send_cargo_sp_to_ship(cargo_id, ship_id) {
	//@description add cargo_id to ship_id
	
	var command = "CARGO_SP_TO_SHIP";
	var command_len = string_length(command) + 1;	// +1 to include string null terminated char
	
	var frame_len = 1 + command_len + 4 + 2 			// +1+4+2 to include one uint32 and one uint16
														// and an extra +1 for command len itself
	
	// Buffer to contain outgoing network data
	var outbuf = buffer_create(frame_len + 2, buffer_fixed, 1);
	buffer_seek(outbuf, buffer_seek_start, 0);
	
	// Write frame size (buffersize - 2)
	buffer_write(outbuf, buffer_u16, frame_len);
	
	// Write command
	buffer_write(outbuf, buffer_u8, command_len);
	buffer_write(outbuf, buffer_string, command);
	
	// Write cargo_id
	buffer_write(outbuf, buffer_u32, cargo_id);
	
	// Write ship_id
	buffer_write(outbuf, buffer_u16, ship_id);
	
	// Send the data to the server
	var err = network_send_raw(networker.game_socket, outbuf, buffer_tell(outbuf));
	buffer_delete(outbuf);	// delete buffer to avoid memory leaks
	
	return err;
}


function connection_handle_error(inbuf) {
	//@description handle the SEND_ERROR server command
	
	// Read in the error_message
	var error_len = buffer_read(inbuf, buffer_u8);
	var error_message = buffer_read(inbuf, buffer_string);
	
	// Print error message in the ingame console
	console_print("Server: " + error_message);
}