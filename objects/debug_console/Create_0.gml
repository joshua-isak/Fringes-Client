/// @description Initialize the debug console

// Keybinds
_key_show_console = 192	//key number 192 is the tilde key
_key_hide_console = 192


// Console display settings
_log_background_color = make_color_rgb(43,48,59);
_log_background_alpha = 0.8;
_log_text_color = $a3be8c;
_log_text_alpha = 1;

_command_background_color = make_color_rgb(101,115,126);
_command_background_alpha = 0.8;
_command_text_color = $a3be8c;
_command_text_alpha = 1;


// Screen size (these need to be the current size of the window TODO: make dynamic
screen_w = 1920;
screen_h = 1080;

// Console operation variables
has_focus = false;
log = "type 'help' to show list of possible commands";	
 