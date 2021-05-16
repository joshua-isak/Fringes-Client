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
	
	var _ship_id = argument0[0];
	var _dest_station_id = argument0[1];
	
	connection_send_sendship(_ship_id, _dest_station_id);
}


function clear() {
	//@description Clears the debug_console log string
	debug_console.log = ">";
}


function quit() {
	//@description Exit the game
	game_end();
}