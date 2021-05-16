/// @func   draw_dotted_line(x1, y1, x2, y2, width)
///
/// DOESN'T WORK REEEE
///
/// @desc   draws a dotted line from point a to point b
function draw_dotted_line(x1, y1, x2, y2, width){
	
	var len = point_distance(x1, y1, x2, y2) div 100;
	var dir = point_direction(x1, y1, x2, y2);
	
	var a = lengthdir_x(100, dir);
	var b = lengthdir_y(100, dir);
	
	for (i = 0; i < len; i++) {
		if !(i & 1) {
			draw_line(x1+a*i, y1+b*i, x2+a*(i+1), y2+b*(i+1));	
		}
	}
}