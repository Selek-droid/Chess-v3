function AIscript() {
	randomize();

	show_debug_message("Started AI script");

	if oGame.AIOpening
	{
		AIOpeningsScript();  // returns true if able to move
		if (oGame.AIMadeScriptedMove) exit;  // bypass AI if AI made scripted move. Else on to AI.
	}

	var boardState = board_object.grid;
	var capture = false;
	var possibleMoves = ds_list_create();
	var AIColor = global.HermioneColor;
	var AISeat = NORTH;

	possibleMoves = possibleMoves_scr(boardState, AISeat, AIColor, true, true);  // generate ds_list of possible moves
	possibleMoves = avoidCheck_scr(possibleMoves, AIColor, AISeat, boardState);   // prune them for check outside possMoves?
	// maybe move this to inside possMoves?

	var numberOfMoves = floor((ds_list_size(possibleMoves) / 4));
	if (numberOfMoves == 0)   // Check for stalemate/checkmate eventually. For now, revert to player. 
		{
		show_debug_message("AI can't find a move")
		oGame.state = "Player Turn";
		exit;
		}
	show_debug_message("number of moves is " + string(numberOfMoves));

	var listIndex = evaluate(possibleMoves, boardState, NORTH, AIColor);  // Parent node has picked a move!

	var xx = ds_list_find_value(possibleMoves,listIndex);
	var yy = ds_list_find_value(possibleMoves,listIndex + 1);
	var newX = ds_list_find_value(possibleMoves,listIndex + 2);
	var newY = ds_list_find_value(possibleMoves,listIndex + 3);

	// check for castling double-move; special case; right side first
	if (newY == 0) && (newX - xx == 2) 
	{
		var chosenPiece = board_object.grid[xx, yy]; 
		if (chosenPiece[0] == KING) 
		{
			if (AIColor == BLACK)  // Kingside, to right
			{
				ds_list_add(oGame.formattedHistory,"O-O");
				show_debug_message("0-0");
				board_object.grid[4, 0] = [0, 0];
				board_object.grid[7, 0] = [0, 0];
				board_object.grid[6, 0] = [KING, AIColor];
				board_object.grid[5, 0] = [ROOK, AIColor];
				board_object.NorthCanCastleLeft = false;
				board_object.NorthCanCastleRight = false;
				oGame.turn += 1;
				oGame.state = "Player Turn";
				exit;
			}
				else if (AIColor == WHITE)  // Queenside, to right
				{
					ds_list_add(oGame.formattedHistory,"O-O-0");
					show_debug_message("0-0-0");
					board_object.grid[xx, 0] = [0, 0];  // King on xx==3, not 4
					board_object.grid[7, 0] = [0, 0];
					board_object.grid[xx + 2, 0] = [KING, AIColor];
					board_object.grid[xx + 1, 0] = [ROOK, AIColor];
					board_object.NorthCanCastleLeft = false;
					board_object.NorthCanCastleRight = false;
					oGame.turn += 1;
					oGame.state = "Player Turn";
					exit;
				}
		}
	}

	if (newY == 0) && (xx - newX == 2)   // Instead castling left side 
	{
		var chosenPiece = board_object.grid[xx, yy];
		if (chosenPiece[0] == KING)
		{
			if (AIColor == BLACK)
			{
				ds_list_add(oGame.formattedHistory,"O-O-0");  // Queenside, king started on x==4
				show_debug_message("0-0-0");
				board_object.grid[0, 0] = [0, 0];
				board_object.grid[xx, 0] = [0, 0];
				board_object.grid[xx - 2, 0] = [KING, AIColor];
				board_object.grid[xx - 1, 0] = [ROOK, AIColor];
				board_object.NorthCanCastleLeft = false;
				board_object.NorthCanCastleRight = false;
				oGame.turn += 1;
				oGame.state = "Player Turn";
				exit;
			}
		
			else if (AIColor == WHITE)
			{
				ds_list_add(oGame.formattedHistory,"O-O");  // Kingside, king started on x==4
				show_debug_message("0-0");
				board_object.grid[0, 0] = [0, 0];
				board_object.grid[xx, 0] = [0, 0];
				board_object.grid[xx - 2, 0] = [KING, AIColor];
				board_object.grid[xx - 1, 0] = [ROOK, AIColor];
				board_object.NorthCanCastleLeft = false;
				board_object.NorthCanCastleRight = false;
				oGame.turn += 1;
				oGame.state = "Player Turn";
				exit;
			}
		
		}
	}
	// ********** PERFORM THE MOVE! *****************

	var chosenPiece = board_object.grid[xx, yy];
	if !(array_equals(board_object.grid[newX, newY], [0, 0])) capture = true;
	animate(chosenPiece, xx, yy, newX, newY);

	// ******* post-move adjustments ***************

	if (chosenPiece[0] == ROOK) && ( xx == 0 ) && ( yy == 0 ) board_object.NorthCanCastleLeft = false;
	if (chosenPiece[0] == ROOK) && ( xx == 7 ) && ( yy == 0 ) board_object.NorthCanCastleRight = false;
	if (chosenPiece[0] == KING) && ( (abs(newX - xx)) == 1 ) 
	{
		board_object.NorthCanCastleLeft = false;
		board_object.NorthCanCastleRight = false;
	}


	updateHistory_scr(chosenPiece, xx, yy, newX, newY, capture);
	oGame.turn += 1;
	oGame.state = "Player Turn";


}
