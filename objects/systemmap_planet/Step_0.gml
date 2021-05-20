
// Check if this planet should have its orbit updated
if (update_orbit) {
	update_orbit = !update_orbit;	
	
	// Re-get the struct for this planet
	this_planet = planet_manager.planets[? planet_id];
	
	// Do some trig to find this object's x and y coordinates
	var tempx = this_planet.orb_radius * cos(degtorad(this_planet.orb_degree));
	var tempy =	this_planet.orb_radius * sin(degtorad(this_planet.orb_degree));

	// Convert to grid offset size
	x = (tempx * grid_size) + offset_x
	y = (tempy * grid_size) + offset_y

}

//if (keyboard_check_pressed(vk_f8)) {
//	grid_size -= 10;	
//}

//if (keyboard_check_pressed(vk_f7)) {
//	grid_size += 10;	
//}

//// Do some trig to find this objects x and y coordinates
//var tempx = this_planet.orb_radius * cos(degtorad(this_planet.orb_degree));
//var tempy =	this_planet.orb_radius * sin(degtorad(this_planet.orb_degree));

//// Convert coordinates to grid offset size
//x = (tempx * grid_size) + offset_x
//y = (tempy * grid_size) + offset_y

//// Planet distance from star corrected to draw grid size
//grid_radius = grid_size * this_planet.orb_radius;

