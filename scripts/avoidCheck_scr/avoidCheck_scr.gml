function avoidCheck_scr(argument0, argument1, argument2, argument3) {
	// Check each AI move to see whether AI king is in check. If so, remove move.

	var legalMoves = ds_list_create();
	var boardState = argument3;  
	var proposedState = boardState;
	var numberOfMoves = floor( ( (ds_list_size(argument0)) / 4) );

	var moversColor = argument1;  // changes in Negamax
	var moversSeat = argument2;   // changes in Negamax

	var kingPosition = [0 , 0];

	// find AI King position

	for (var xx = 0; xx < 8; xx += 1;)
	{
		for (var yy = 0; yy < 8; yy += 1;)
		{
			if array_equals(boardState[xx, yy],[KING, moversColor])
			{
				var kingPosition = [xx , yy];
				break;
			}
		}
	}

	// Get each 4-position move in list of possible moves. oldx, oldy moves to proposed newx, newy.

	for (var i = 0; i < numberOfMoves; i += 1;)
	{
		var oldX = ds_list_find_value(argument0, 4 * i);
		var oldY = ds_list_find_value(argument0,( (4 * i) + 1 ));
		var newX = ds_list_find_value(argument0,(( 4 * i) + 2 ));
		var newY = ds_list_find_value(argument0,(( 4 * i) + 3 ));

	
	// "Make" the move, and see if king is on a "threatenedSquare"
	//	kingPosition = [xx , yy]; // reset kingPosition if we moved king below
		var movingPiece = boardState[oldX, oldY];
		proposedState[oldX, oldY] = [0, 0];
		proposedState[newX, newY] = [ movingPiece[0], movingPiece[1] ]; 
		if (movingPiece[0] != KING) 
		{
			if !threatenedSquare_scr(kingPosition[0],kingPosition[1], proposedState, moversSeat, moversColor)
			{
				ds_list_add(legalMoves,oldX,oldY,newX,newY);
				//show_debug_message("Added move: (" + string(oldX) + " , " + string(oldY) + ") to " + string(newX)
				//+ " , " + string(newY));
			}
		}
		else
		{
			if !threatenedSquare_scr(newX,newY, proposedState, moversSeat, moversColor)
			{
				ds_list_add(legalMoves,oldX,oldY,newX,newY);
				//show_debug_message("Added move: (" + string(oldX) + " , " + string(oldY) + ") to " + string(newX)
				//+ " , " + string(newY));
			}
		}
		proposedState = boardState;  // "Unmake the move", whether or not the move is valid.
	
	}

	return legalMoves;
	ds_list_destroy(legalMoves);
	





}
