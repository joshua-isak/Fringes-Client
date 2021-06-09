
// Check if the last planet hovered over is still being hovered over, dont process this object if not
if (last_planet_hovered != 0 and last_planet_hovered.hover == true) {
	show = true;
} else { 
	show = false;
	exit;		// skip the rest of this event 
}

// Update station/planet variables
var planet_id = last_planet_hovered.planet_id;
var station_id = planet_manager.planets[? planet_id].sp_id;
var star_id = planet_manager.planets[? planet_id].star_id;

// Skip the rest of the event if the planet has no station
if (station_id == 0) { 
	station_name = "NO STATION HERE";
	exit; 
}

var station_struct = station_manager.stations[? station_id];

station_name = station_struct.name;
star_name = star_manager.stars[? star_id].name;
planet_name = planet_manager.planets[? planet_id].name;
station_level = station_struct.station_level;
next_manifest_update = 0;		//--TODO--// UPDATE TO INCLUDE THIS
top_product = 0;				//--TODO--// UPDATE TO INCLUDE THIS
num_ships_present = 0;			//--TODO--// UPDATE TO INCLUDE THIS




delete(station_struct)	// remind the garbage collector