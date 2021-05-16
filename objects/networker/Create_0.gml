/// @description Initialize the networker

// Declare some variables
is_connected = false;

ip = "";
port = 4296;
username = "";
password = "";

game_socket = noone;

// queue of new packets to process
new_packets = ds_queue_create();
packet_count = 0;
packets_read = 0;

network_unread = 0;
network_buffer = buffer_create(64000, buffer_wrap, 1);

global.version = "0.2";

// Set connection timeout to 4 seconds
network_set_config(network_config_connect_timeout, 4000);

