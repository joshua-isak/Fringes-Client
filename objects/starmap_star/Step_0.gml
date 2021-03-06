/// @description Insert description here
// You can write your code in this editor


var this_star = star_manager.stars[? star_id];



// Check if the mouse is hovering over this object (when it is visible in the star map)
if ( room == scene_star_map and position_meeting(mouse_x, mouse_y, id) ) {
	
	// Ignore hover if ship_infobox is currently open
	if (ship_infobox.show_infobox) { exit };
	
	hover = true;
	
	// If this object is clicked change the room to the system map scene
	if (mouse_check_button(mb_left)) {
		
		global.current_system_map_star = star_id;		// so the system map scene knows what star to draw
		room_goto(scene_system_map);					// goto the systemmap scene
	}
	
} else { 
	hover = false;
}
