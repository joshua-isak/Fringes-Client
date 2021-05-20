
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