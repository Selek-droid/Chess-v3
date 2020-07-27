function Maximize(argument0, argument1, argument2, argument3) {
	var boardState = argument0;  // Someone (either evaluate or Minimize) has sent us ONE move on ONE board.
	var moversSeat = argument1;  // in any human game, this will be NORTH. We flip to south below.
	var moversColor = argument2;
	var searchDepth = argument3;  // ok to use local var?


	var possibleMoves = ds_list_create();
	var listSize = (ds_list_size(possibleMoves)) - 4;
	var positionScore = 0;
	var maxScore = 0 - infinity;  // Return value. Eval will compare this to other maxscores from other sent moves.
	var listIndex = 0;
	var piece = [0 , 0];
	var selectedPiece = [0 , 0];

	if moversColor == WHITE   // Not at final depth, so flip color: black AI now "plays" as white.
	{
		moversColor = BLACK;
		var nonmoversColor = WHITE;
	} 

	else if moversColor == BLACK // AI playing as black; flip it to white.
	{
		moversColor = WHITE;
		var nonmoversColor = BLACK;
	}

	if moversSeat == NORTH   // flip side: north AI now "plays" as (and generates moves for) SOUTH.
	{
		moversSeat = SOUTH;
		var nonmoversSeat = NORTH;
	}

	else if moversSeat == SOUTH
	{
		moversSeat = NORTH;
		var nonmoversSeat = SOUTH;
	}

	if (searchDepth > 1)  // Reached bottom of tree. Report best score to "evaluate", our root node.
	{
		for (var xx = 0; xx < 8; xx += 1;)
		{
			for (var yy = 0; yy < 8; yy += 1;)
			{
				var piece = boardState[xx, yy];
				if piece[1] == moversColor   // check each piece at each square
				{
					switch (piece[0])
					{
						case PAWN: 
						{
							if moversSeat == NORTH
							positionScore += (VPAWN + board_object.AIpawnTable[xx, yy]);
							else positionScore +=(VPAWN + board_object.HumanPawnTable[xx, yy]); 
							break;
						}
						case KNIGHT:
						{
							if moversSeat == NORTH
							positionScore += (VKNIGHT + board_object.AIKnightTable[xx, yy]);
							else positionScore += (VKNIGHT + board_object.HumanKnightTable[xx, yy]);
							break;
						}
						case BISHOP:
						{
							if moversSeat == NORTH
							positionScore += (VBISHOP + board_object.AIBishopTable[xx, yy]);
							else positionScore += (VBISHOP + board_object.HumanBishopTable[xx, yy]);
							break;
						}
						case ROOK:
						{
							if moversSeat == NORTH
							positionScore += (VROOK + board_object.AIRookTable[xx, yy]);
							else positionScore += (VROOK + board_object.HumanRookTable[xx, yy]);
							break;
						}
						case QUEEN:
						{
							if moversSeat == NORTH
							positionScore += (VQUEEN + board_object.AIQueenTable[xx, yy]);
							else positionScore += (VQUEEN + board_object.HumanQueenTable[xx, yy]);
							break;
						}
						case KING:
						{
							if moversSeat == NORTH
							positionScore += (VKING + board_object.AIKingTable[xx, yy]);
							else positionScore += (VKING + board_object.HumanKingTable[xx, yy]);
							break;
						}
					}
				}
				
				if piece[1] == nonmoversColor
				{
					switch (piece[0])
					{
						case PAWN: 
						{
							if moversSeat == NORTH
							positionScore -= (VPAWN + board_object.HumanPawnTable[xx, yy]);
							else positionScore -= (VPAWN + board_object.AIpawnTable[xx, yy]);
							break;
						}
						case KNIGHT:
						{
							if moversSeat == NORTH
							positionScore -= (VKNIGHT + board_object.HumanKnightTable[xx, yy]);
							else positionScore -= (VKNIGHT + board_object.AIKnightTable[xx, yy]);
							break;
						}
						case BISHOP:
						{
							if moversSeat == NORTH
							positionScore -= (VBISHOP + board_object.HumanBishopTable[xx, yy]);
							else positionScore -= (VBISHOP + board_object.AIBishopTable[xx, yy]);
							break;
						}
						case ROOK:
						{
							if moversSeat == NORTH
							positionScore -= (VROOK + board_object.HumanRookTable[xx, yy]);
							else positionScore -= (VROOK + board_object.AIRookTable[xx, yy]);;
							break;
						}
						case QUEEN:
						{
							if moversSeat == NORTH
							positionScore -= (VQUEEN + board_object.HumanQueenTable[xx, yy]);
							else positionScore -= (VQUEEN + board_object.AIQueenTable[xx, yy]);
							break;
						}
						case KING:
						{
							if moversSeat == NORTH
							positionScore -= (VKING + board_object.HumanKingTable[xx, yy]);
							else positionScore -= (VKING + board_object.AIKingTable[xx, yy]);
							break;
						}
					}
				}
			}
		}
	// show_debug_message("Unusual! NEWMAX scores a final leaf: " +  string(positionScore));
	ds_list_destroy(possibleMoves);	
	return positionScore;
	}

	// *** GENERATE POSSIBLE MOVES, one at a time, frmo INCOMING BOARD

	possibleMoves = possibleMoves_scr(boardState, moversSeat, moversColor, true, true); 
	possibleMoves = avoidCheck_scr(possibleMoves, moversColor, moversSeat, boardState);
	listSize = (ds_list_size(possibleMoves)) - 4;

	for (listIndex = 0; listIndex <= listSize; listIndex += 4)
	{						
		var oldX = ds_list_find_value(possibleMoves,listIndex);
		var oldY = ds_list_find_value(possibleMoves,listIndex + 1);
		var newX = ds_list_find_value(possibleMoves,listIndex + 2);
		var newY = ds_list_find_value(possibleMoves,listIndex + 3);

		boardState = argument0;  // always reset board before "making" next move
	
		selectedPiece = boardState[oldX, oldY];  // "move" responding piece to new location
		boardState[newX, newY] = selectedPiece;
		boardState[oldX, oldY] = [0 , 0];
	
		show_debug_message("MAX sends back this BLACK REPLY to MIN: (" +  string(oldX) + " , " + string(oldY) + " to (" +
		string(newX) + " , " + string(newY) + ")" + " , at depth :" + string(searchDepth) + " BBBBBBBBBBBBBBBBBBBBBBBBBBBB ");
		
		var minimizedScore = Minimize(boardState, moversSeat, moversColor, searchDepth + 1);
		show_debug_message("MAX receives this maxscore from MIN: " +  string(minimizedScore));
		show_debug_message("Old maxScore in MAX was: " + string(maxScore));
		if (minimizedScore > maxScore)  maxScore = minimizedScore;
		show_debug_message(" MAX sets this new maxScore: (" +  string(maxScore));
	}
	searchDepth += 1;
	ds_list_destroy(possibleMoves);
	return maxScore;


}
