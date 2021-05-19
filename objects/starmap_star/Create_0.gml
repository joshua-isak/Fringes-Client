/// @description Initialize

// id of this star in star_manager's master table
star_id = global.new_starmap_star_id;

// add this object to star_manager's map of starmap objects
star_manager.starmap_stars[? star_id] = id;		//provide a reference to this object's id



//offset of center of star map
offset_x = 1920 / 2;
offset_y = 1080 / 2;

// pixel distance between star grid
grid_size = 150;

// Get the struct for this star
this_star = star_manager.stars[? star_id];

// Find positional offset from center of map
s_x = (this_star.x * grid_size) + offset_x;
s_y = (this_star.y * grid_size) + offset_y;
x = s_x;
y = s_y;



// If mouse is hovering over this object
hover = false;