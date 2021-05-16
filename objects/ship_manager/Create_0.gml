/// @description Initialize


// Map of all ships
ships = ds_map_create();

enum travel_state {
	DEPARTING,
	ARRIVING,
	WARP,
	DOCKED
}

// Get ship state as string
function ship_state_string(state_int) {
	switch (state_int) 
	{
		case travel_state.DEPARTING:
		return "De[arting";
		
		case travel_state.ARRIVING:
		return "Arriving";
		
		case travel_state.WARP:
		return "Warping";
		
		case travel_state.DOCKED:
		return "Docked";
	}
}