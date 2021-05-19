// Check for keypress to show/hide the debug information

if (keyboard_check_pressed(vk_f3)) {
	draw_debug = !draw_debug;
}


if (keyboard_check_pressed(vk_escape)) {
	room_goto(scene_star_map);	
}