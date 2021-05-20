

planet_id = global.new_systemmap_planet_id;

// Get the struct for this planet
this_planet = planet_manager.planets[? planet_id];

star_id = this_planet.star_id;

// add this object to planet_manager's map of systemmap objects	
planet_manager.systemmap_planets[? planet_id] = id;		//provide a reference to this object's id

//offset of center of system map
offset_x = 1920 / 2;
offset_y = 1080 / 2;

// pixel distance between system grid
grid_size = 150;

// Set true to recalculate planet's x and y coordinates
update_orbit = false;

// Do some trig to find this objects x and y coordinates
var tempx = this_planet.orb_radius * cos(degtorad(this_planet.orb_degree));
var tempy =	this_planet.orb_radius * sin(degtorad(this_planet.orb_degree));

// Convert to grid offset size
x = (tempx * grid_size) + offset_x
y = (tempy * grid_size) + offset_y

// Planet distance from star corrected to draw grid size
grid_radius = grid_size * this_planet.orb_radius;