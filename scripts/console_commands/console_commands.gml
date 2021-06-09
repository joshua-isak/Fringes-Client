function console_print(output) {
	//@description Writes a message to the debug_console
	
	debug_console.log += chr(13) + string(output);
}
	


function help() {
	// @description Prints a list of all console scripts and their description
	
	// This script should only be called by the debug_console
	log += chr(13) + " [type a command name and its parameters separated by spaces to run it] Example: connect 192.168.1.1 josh 1234";
	log += chr(13) + "   connect (server username password): connect to a server";
	log += chr(13) + "   disconnect: disconnect from server";
	log += chr(13) + "   quit: close the game";
	log += chr(13) + "   clear: clear the console";
	log += chr(13) + "   send (ship_id, destination_id): request to send a docked ship to a new station";
	
}

function connect(argument0) {
	// @description Connects to a server using server_connect()
	
	if (array_length(argument0) != 3) {
		log += chr(13) + "Error: connect takes 3 arguments";
		return;
	}
	
	var _ip = string(argument0[0]);
	var _username = string(argument0[1]);
	var _password = string(argument0[2]);
	
	server_connect(_ip, _username, _password);
}


function disconnect() {
	//@description Disconnects from the current server using server_disconnect()
	
	server_disconnect();
}


function send(argument0) {
	// @description tells server to send a ship (ship_id) to a station (station_id)
	
	if (array_length(argument0) != 2) {
		log += chr(13) + "Error: send takes 2 arguments";	
		return;
	}
	
	var _ship_id = argument0[0];
	var _dest_station_id = argument0[1];
	
	connection_send_sendship(_ship_id, _dest_station_id);
}


function addcargo(argument0) {
	// @description tells server to add a cargo_id to a ship_id
	
	if (array_length(argument0) != 2) {
		log += chr(13) + "Error: addcargo takes 2 arguments";	
		return;
	}
	
	var _cargo_id = argument0[0];
	var _ship_id = argument0[1];
	
	connection_send_cargo_sp_to_ship(_cargo_id, _ship_id);
}


function rename_ship(argument0) {
	//@desc tells the server to rename a ship 	
	
	if (array_length(argument0) != 2) {
		log += chr(13) + "Error: rename_ship takes 2 arguments";	
		return;
	}
	
	var _ship_id = argument0[0];
	var _new_name = argument0[1];
	
	connection_send_renameship(_ship_id, _new_name);
}


function clear() {
	//@description Clears the debug_console log string
	debug_console.log = ">";
}


function quit() {
	//@description Exit the game
	game_end();
}