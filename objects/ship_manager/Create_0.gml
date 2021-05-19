/// @description Initialize


// Map of all ships
ships = ds_map_create();

//////// what's in a ship? ships[? i] = ship
//
//	ship.id
//	ship.company_id
//	ship.name
//	ship.registration
//	ship.type
//	ship.warps
//	ship.reliability
//	ship.last_spaceport
//	ship.next_spaceport
//	ship.current_spaceport
//	ship.departure_time
//	ship.arrival_time
//	ship.travel_state
//
//////////////////////////////

enum travel_state {
	DEPARTING,
	ARRIVING,
	WARP,
	DOCKED
}


// Ship map draw settings
draw_other_labels = true;
draw_other_lines = true;


// Get ship state as string
function ship_state_string(state_int) {
	switch (state_int) 
	{
		case travel_state.DEPARTING:
		return "Departing";
		
		case travel_state.ARRIVING:
		return "Arriving";
		
		case travel_state.WARP:
		return "Warping";
		
		case travel_state.DOCKED:
		return "Docked";
	}
}