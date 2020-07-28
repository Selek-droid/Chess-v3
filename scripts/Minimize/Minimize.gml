function Minimize(argument0, argument1, argument2, argument3) {
	var boardState = argument0;  // Someone (either evaluate or Minimize) has sent us ONE move on ONE board.
	var moversSeat = argument1;  // in any human game, this will be NORTH. We flip to south below.
	var moversColor = argument2;
	var searchDepth = argument3;  // ok to use local var?
	var HermioneColor = oBoard.GrangerColor;

	var possibleMoves = ds_list_create();
	var listSize = (ds_list_size(possibleMoves)) - 4;
	var positionScore = 0;
	var minScore = infinity;  // Return value. Eval will compare this to other maxscores from other sent moves.
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
	//	if moversSeat == NORTH show_debug_message("Scoring in Maximize while sitting NORTH");
	//	else show_debug_message("Scoring in MAX while sitting SOUTH");
	//	if moversColor == BLACK show_debug_message("Scoring color is BLACK");
	//	else show_debug_message("Scoring color is WHITE");

	// For now will HARD CODE as BLACK, NORTH.  Older code tested side/seat, but removing as unnecessary for now.
	
	
		for (var xx = 0; xx < 8; xx += 1;)
		{
			for (var yy = 0; yy < 8; yy += 1;)
			{
				var piece = boardState[xx, yy];
				if piece[1] == HermioneColor 
				{
					switch (piece[0])
					{
						case PAWN: 
						{
							// if moversSeat == NORTH
							positionScore += (VPAWN + oBoard.AIpawnTable[xx, yy]);
							// else positionScore +=(VPAWN + oBoard.HumanPawnTable[xx, yy]); 
							break;
						}
						case KNIGHT:
						{
							// if moversSeat == NORTH
							positionScore += (VKNIGHT + oBoard.AIKnightTable[xx, yy]);
							// else positionScore += (VKNIGHT + oBoard.HumanKnightTable[xx, yy]);
							break;
						}
						case BISHOP:
						{
							//  if moversSeat == NORTH
							positionScore += (VBISHOP + oBoard.AIBishopTable[xx, yy]);
							// else positionScore += (VBISHOP + oBoard.HumanBishopTable[xx, yy]);
							break;
						}
						case ROOK:
						{
							// if moversSeat == NORTH
							positionScore += (VROOK + oBoard.AIRookTable[xx, yy]);
							// else positionScore += (VROOK + oBoard.HumanRookTable[xx, yy]);
							break;
						}
						case QUEEN:
						{
							// if moversSeat == NORTH
							positionScore += (VQUEEN + oBoard.AIQueenTable[xx, yy]);
							// else positionScore += (VQUEEN + oBoard.HumanQueenTable[xx, yy]);
							break;
						}
						case KING:
						{ 
							// STALEMATE check. If this board has 0 moves, return "0," an OK result.
							//var stalemateCheck = ds_list_create();
							//stalemateCheck = possibleMoves_scr(boardState, NORTH, HermioneColor, true, true);
							//if ds_list_size(stalemateCheck) == 0
							//{
							//	ds_list_destroy(possibleMoves);
							//	ds_list_destroy(stalemateCheck);
							//	return 0;
							//}
						
							// if moversSeat == NORTH
							positionScore += (VKING + oBoard.AIKingTable[xx, yy]);
							// else positionScore += (VKING + oBoard.HumanKingTable[xx, yy]);
							break;
						}
					}
				}
				
				if piece[1] != HermioneColor  
				{
					switch (piece[0])
					{
						case PAWN: 
						{
							// if moversSeat == NORTH
							positionScore -= (VPAWN + oBoard.HumanPawnTable[xx, yy]);
							// else positionScore -= (VPAWN + oBoard.AIpawnTable[xx, yy]);
							break;
						}
						case KNIGHT:
						{
							// if moversSeat == NORTH
							positionScore -= (VKNIGHT + oBoard.HumanKnightTable[xx, yy]);
							// else positionScore -= (VKNIGHT + oBoard.AIKnightTable[xx, yy]);
							break;
						}
						case BISHOP:
						{
							// if moversSeat == NORTH
							positionScore -= (VBISHOP + oBoard.HumanBishopTable[xx, yy]);
							// else positionScore -= (VBISHOP + oBoard.AIBishopTable[xx, yy]);
							break;
						}
						case ROOK:
						{
							// if moversSeat == NORTH
							positionScore -= (VROOK + oBoard.HumanRookTable[xx, yy]);
							// else positionScore -= (VROOK + oBoard.AIRookTable[xx, yy]);;
							break;
						}
						case QUEEN:
						{
							// if moversSeat == NORTH
							positionScore -= (VQUEEN + oBoard.HumanQueenTable[xx, yy]);
							// else positionScore -= (VQUEEN + oBoard.AIQueenTable[xx, yy]);
							break;
						}
						case KING:
						{
							// if moversSeat == NORTH
							positionScore -= (VKING + oBoard.HumanKingTable[xx, yy]);
							// else positionScore -= (VKING + oBoard.AIKingTable[xx, yy]);
							break;
						}
					}
				}
			}
		}
	show_debug_message("MIN scores a final leaf: " + string(positionScore));	
	
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
	
		//show_debug_message("MIN sends this WHITE move to MAX: (" +  string(oldX) + " , " + string(oldY) + " to (" +
		//string(newX) + " , " + string(newY) + ")" + " , at depth :" + string(searchDepth) + "===========================================");
	
		
		var maximizedScore = Maximize(boardState, moversSeat, moversColor, searchDepth + 1);
		show_debug_message("MIN receives this score from MAX: " +  string(maximizedScore));
		show_debug_message("Old minscore in MIN was " + string(minScore));
		if (maximizedScore < minScore) minScore = maximizedScore;

		show_debug_message("MIN sets new minscore from MAX: (" +  string(minScore));
	}
	searchDepth += 1;
	ds_list_destroy(possibleMoves);
	return minScore;


}
