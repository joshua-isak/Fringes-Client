/// @description Initialize the networker

// Declare some variables
is_connected = false;

ip = "";
port = 4296;
username = "";
password = "";

game_socket = noone;

global.version = "0.1";

// Set connection timeout to 4 seconds
network_set_config(network_config_connect_timeout, 4000);