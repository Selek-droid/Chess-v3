function possibleMoves_scr(argument0, argument1, argument2, argument3, argument4) {
	var boardState = argument0;
	var AISeat = argument1; 
	var AIColor = argument2;
	var AICanCastleKingSide = argument3;
	var AICanCastleQueenSide = argument4;

	var xx;
	var yy;
	var legalMoves = ds_list_create();

	if (AIColor == BLACK) 
	{
		var nonMovingSide = WHITE;
	}
	else nonMovingSide = BLACK;
 

	for (xx = 0; xx < 8; xx += 1;)
	{
		for (yy = 0; yy < 8; yy += 1;)
		{
			if array_equals(boardState[xx, yy],[PAWN, AIColor])
			{
				if (AISeat == NORTH)
				{ 
					if ( (yy == 1) && (array_equals(boardState[xx, 3],[0, 0])) // Pawn two-space move
								&& (array_equals(boardState[xx, 2],[0 , 0]) ) )
					{
						ds_list_add(legalMoves, xx, yy, xx, (yy + 2));
					}

					if (yy < 7) && (array_equals(boardState[xx, yy +  1],[0 , 0])) // Pawn one-move, <7th rank.
					{
						ds_list_add(legalMoves, xx, yy, xx, (yy + 1));
					} 
			
					if (xx == 0) & (yy < 7) // check edge-pawn capture separately, to avoid out-of-array 
					{
						var targetID = boardState[1, yy + 1];
						if (targetID[1] == nonMovingSide) 
						{
							ds_list_add(legalMoves, 0, yy, 1, yy + 1); 
						}
					} 
			
					if (xx == 7) & (yy < 7) // check other-edge pawn capture
					{
						var targetID = boardState[6, yy + 1];
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, 7, yy, 6, yy + 1);
						}
					}
			 
					if (xx < 7) && (xx > 0) && (yy < 7)  // other (i.e., most) captures
					{
						var targetID = boardState[xx + 1, yy + 1];
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, xx, yy, xx + 1, yy + 1);
						}
				
						var targetID = boardState[xx - 1, yy + 1];
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, xx, yy, xx - 1, yy + 1);
						}
					}
				}
			
				if (AISeat == SOUTH) // pawns instead move -y
				{ 
					if ( (yy == 6) && (array_equals(boardState[xx, 4],[0, 0])) // Pawn two-space move
								&& (array_equals(boardState[xx, 5],[0 , 0]) ) )
					{
						ds_list_add(legalMoves, xx, yy, xx, 4);
					}

					if (yy > 0) && (array_equals(boardState[xx, yy - 1],[0 , 0])) // Pawn one-move, <7th rank.
					{
						ds_list_add(legalMoves, xx, yy, xx, (yy - 1));  // check for promotion in AI Script now? 
					} 
			
					if (xx == 0) & (yy > 0) // check left-edge-pawn capture separately, to avoid out-of-array 
					{
						var targetID = boardState[1, yy - 1];
						if (targetID[1] == nonMovingSide) 
						{
							ds_list_add(legalMoves, 0, yy, 1, yy - 1); 
						}
					} 
			
					if (xx == 7) & (yy > 0) // check right-edge pawn capture
					{
						var targetID = boardState[6, yy - 1];
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, 7, yy, 6, yy - 1);
						}
					}
			 
					if (xx < 7) && (xx > 0) && (yy > 0) //  other (i.e., most) captures
					{
						var targetID = boardState[xx + 1, yy - 1];
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, xx, yy, xx + 1, yy - 1);
						}
				
						var targetID = boardState[xx - 1, yy - 1];
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, xx, yy, xx - 1, yy - 1);
						}
					}
				}
			}
	
			if array_equals(boardState[xx, yy],[KNIGHT, AIColor])
			{
				if (xx <= 6) && (yy <= 5) // offset 1, 2
				{
					var targetID = boardState[xx + 1, yy + 2];
					if (targetID[1] == nonMovingSide) || (targetID[1] == 0)
					{
						ds_list_add(legalMoves, xx, yy, xx + 1, yy + 2);
					}
				}
			
				if (xx <= 5) && (yy <= 6) // offset 2, 1
				{
					var targetID = boardState[xx + 2, yy + 1];
					if (targetID[1] == nonMovingSide) || (targetID[1] == 0)
					{
						ds_list_add(legalMoves, xx, yy, xx + 2, yy + 1);
					}
				}
			
				if (xx <= 5) && (yy >= 1) // offset 2, -1
				{
					var targetID = boardState[xx + 2, yy - 1];
					if (targetID[1] == nonMovingSide) || (targetID[1] == 0)
					{
						ds_list_add(legalMoves, xx, yy, xx + 2, yy - 1);
					}
				}
				
				if (xx <= 6) && (yy >= 2) // offset 1, -2
				{
					var targetID = boardState[xx + 1, yy - 2];
					if (targetID[1] == nonMovingSide) || (targetID[1] == 0)
					{
						ds_list_add(legalMoves, xx, yy, xx + 1, yy - 2);
					}
				}
				
				if (xx >= 2) && (yy >= 1) // offset -2, -1
				{
					var targetID = boardState[xx - 2, yy - 1];
					if (targetID[1] == nonMovingSide) || (targetID[1] == 0)
					{
						ds_list_add(legalMoves, xx, yy, xx - 2, yy - 1);
					}
				}
			
				if (xx >= 2) && (yy <= 6) // offset -2, 1
				{
					var targetID = boardState[xx - 2, yy + 1];
					if (targetID[1] == nonMovingSide) || (targetID[1] == 0)
					{
						ds_list_add(legalMoves, xx, yy, xx - 2, yy + 1);
					}
				}
			
				if (xx >= 1) && (yy <= 5) // offset -1, 2
				{
					var targetID = boardState[xx - 1, yy + 2];
					if (targetID[1] == nonMovingSide) || (targetID[1] == 0)
					{
						ds_list_add(legalMoves, xx, yy, xx - 1, yy + 2);
					}
				}
			
				if (xx >= 1) && (yy >= 2) // offset -1, -2
				{
					var targetID = boardState[xx - 1, yy - 2];
					if (targetID[1] == nonMovingSide) || (targetID[1] == 0)
					{
						ds_list_add(legalMoves, xx, yy, xx - 1, yy - 2);
					}
				}
			}
		
			if array_equals(boardState[xx, yy],[KING, AIColor])
			{
				if (yy == 0) && (xx > 0) && (xx < 7)  // King on starting rank, not corners. Check castling first
				{
					if (AISeat == NORTH)
					{
						if (AIColor == BLACK)
						{
							if (board_object.NorthCanCastleRight) && (xx == 4) // where to store this during minmax?
							{
								var castleTarget = boardState[6, yy];  // Castling Kingside, to Right
								var targetID = boardState[5, yy];
								if (targetID[1] == 0) && (castleTarget[1] == 0) &&
									!((threatenedSquare_scr(xx, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(xx + 1, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(xx + 2, yy, boardState, AISeat, AIColor)) ) 
									ds_list_add(legalMoves, xx, yy, 6, yy);  
							}
				
							if (board_object.NorthCanCastleLeft) && (xx == 4) // castling Queenside, to Left
							{
								var knightThere = boardState[xx - 3, yy];
								var castleTarget = boardState[xx - 2, yy];  
								var targetID = boardState[xx - 1, yy];
								if (targetID[1] == 0) && (castleTarget[1] == 0) && (knightThere[1] == 0) &&
									!((threatenedSquare_scr(xx, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(xx + 1, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(xx + 2, yy, boardState, AISeat, AIColor)) ) 
									ds_list_add(legalMoves, xx, yy, xx - 2, yy);
							}
						}
				
						if (AIColor == WHITE)  //  AI is playing white pieces on north side
						{
							if (board_object.NorthCanCastleLeft) && (xx == 3) // Castle Kingside, to Left
							{
								var castleTarget = boardState[1, yy];  
								var targetID = boardState[2, yy];
								if (targetID[1] == 0) && (castleTarget[1] == 0) &&
									!((threatenedSquare_scr(xx, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(xx - 1, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(xx - 2, yy, boardState, AISeat, AIColor)) ) 
									{
											ds_list_add(legalMoves, 3, yy, 1, yy);
									}
							}
				
							if (board_object.NorthCanCastleRight) && (xx == 3) // Castle Queenside, to Right
							{
								var knightThere = boardState[xx + 3, yy];
								var castleTarget = boardState[xx + 2, yy];  
								var targetID = boardState[xx + 1, yy];
								if (targetID[1] == 0) && (castleTarget[1] == 0) && (knightThere[1] == 0) &&
									!((threatenedSquare_scr(xx, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(xx + 1, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(xx + 2, yy, boardState, AISeat, AIColor)) ) 
									ds_list_add(legalMoves, xx, yy, xx + 2, yy);
							}
						}
					}
				
	// If no castle, we check for other moves on top rank.
				
					var targetID = boardState[xx - 1, yy];  // offset -1, 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
						!((threatenedSquare_scr(xx - 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy);
								
					var targetID = boardState[xx - 1, yy + 1];  // offset -1, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx - 1, yy + 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy + 1);
								
					var targetID = boardState[xx, yy + 1];  // offset 0, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx, yy + 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy + 1);
				
					var targetID = boardState[xx + 1, yy + 1];  // offset 1, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx + 1, yy + 1, boardState, AISeat, AIColor) ))
						ds_list_add(legalMoves, xx, yy, xx + 1, yy + 1);
						
					var targetID = boardState[xx + 1, yy];  // offset 1, 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) &&
					!((threatenedSquare_scr(xx + 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy);		
				}
			
				if (yy == 0) && (xx == 0)  // King on starting rank, top leftcorner.
				{
					var targetID = boardState[1, 0];  // offset 1, 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(1, 0, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, 0, 0, 1, 0);
						
					var targetID = boardState[1, 1];  // offset 1, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(1, 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, 0, 0, 1, 1);	
						
					var targetID = boardState[0, 1];  // offset 0, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(0, 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, 0, 0, 0, 1);	
				}
			
				if (xx == 7) && (yy == 0) // King on starting rank, top right corner.
				{
					var targetID = boardState[xx - 1, yy];  // offset -1, 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx - 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy);
						
					var targetID = boardState[xx - 1, yy + 1];  // offset -1, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx - 1, yy + 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy + 1);
						
					var targetID = boardState[xx, yy + 1];  // offset 0, 1 
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx, yy + 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy + 1);	
				}
			
				if (xx > 0) && (xx < 7) && (yy > 0) && (yy < 7)    // King not on any edge
				{
					var targetID = boardState[xx - 1, yy];  // offset -1, 0. Prevent moving into check.
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx - 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy);
								
					var targetID = boardState[xx - 1, yy + 1];  // offset -1, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx - 1, yy + 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy + 1);
								
					var targetID = boardState[xx, yy + 1];  // offset 0, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) &&
					!((threatenedSquare_scr(xx, yy + 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy + 1);
								
					var targetID = boardState[xx + 1, yy + 1];  // offset 1, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx + 1, yy + 1, boardState, AISeat, AIColor)) )
							ds_list_add(legalMoves, xx, yy, xx + 1, yy + 1);
						
					var targetID = boardState[xx + 1, yy];  // offset 1, 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx + 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy);
						
					var targetID = boardState[xx + 1, yy - 1];  // offset 1, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx + 1, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy - 1);	
						
					var targetID = boardState[xx, yy - 1];  // offset 0, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy - 1);	
						
					var targetID = boardState[xx - 1, yy - 1];  // offset -1, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx - 1, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy - 1);		
				}
			
				if (xx == 0) &&  (yy > 0) && (yy < 7)    // King on left edge, not corners
				{
					var targetID = boardState[xx, yy - 1];  // offset 0, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy - 1);	
					
					var targetID = boardState[xx + 1, yy - 1];  // offset 1, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx + 1, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy - 1);
					
					var targetID = boardState[xx + 1, yy];  // offset 1, 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx + 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy);
					
					var targetID = boardState[xx + 1, yy + 1];  // offset 1, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx + 1, yy + 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy + 1);
					
					var targetID = boardState[xx, yy + 1];  // offset 0, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) &&
					!((threatenedSquare_scr(xx, yy + 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy + 1);
				}
			
				if (xx == 7) &&  (yy > 0) && (yy < 7)    // King on right edge, not corners
				{
					var targetID = boardState[xx, yy - 1];  // offset 0, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy - 1);
					
					var targetID = boardState[xx - 1, yy - 1];  // offset -1, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx - 1, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy - 1);
					
					var targetID = boardState[xx - 1, yy];  // offset -1, 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx - 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy);
					
					var targetID = boardState[xx - 1, yy + 1];  // offset -1 , 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) &&
					!((threatenedSquare_scr(xx - 1, yy + 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy + 1);	
					
					var targetID = boardState[xx, yy + 1];  // offset 0, 1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx, yy + 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy + 1);
				}
			
				if (xx == 0) && (yy == 7)    // King on lower left corner
				{
					var targetID = boardState[xx, yy - 1];  // offset 0, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy - 1);
					
					var targetID = boardState[xx + 1, yy - 1];  // offset 1 , -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx + 1, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy - 1);
					
					var targetID = boardState[xx + 1, yy];  // offset 1 , 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx + 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy);	
				}
			
				if (xx == 7) && (yy == 7)    // King on lower right corner
				{
					var targetID = boardState[xx, yy - 1];  // offset 0, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy - 1);
					
					var targetID = boardState[xx - 1, yy];  // offset -1, 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx - 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy);
					
					var targetID = boardState[xx - 1, yy - 1];  // offset -1, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) &&
					!((threatenedSquare_scr(xx - 1, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy - 1);
				}
			
				if (xx >= 1) && (xx <= 6) && (yy == 7)    // King on bottom edge, not in corners
				{ 
					// check if AI is playing from south edge during Minmax, or as Albus:
					if (AISeat == SOUTH)
					{
						if (AIColor == BLACK)
						{
							if (board_object.SouthCanCastleLeft) && (xx == 3) // Kingside, to left
							{
								var castleTarget = boardState[1, yy];  
								var targetID = boardState[2, yy];
								if (targetID[1] == 0) && (castleTarget[1] == 0) &&
									!((threatenedSquare_scr(3, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(2, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(1, yy, boardState, AISeat, AIColor)) ) 
									ds_list_add(legalMoves, 3, yy, 1, yy);  
							}
				
							if (board_object.SouthCanCastleRight) && (xx == 3) // Queenside, to right
							{
								var knightThere = boardState[6, yy];
								var castleTarget = boardState[5, yy];  // offset 2, 0
								var targetID = boardState[4, yy];
								if (targetID[1] == 0) && (castleTarget[1] == 0) && (knightThere[1] == 0) &&
									!((threatenedSquare_scr(3, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(4, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(5, yy, boardState, AISeat, AIColor)) ) 
									ds_list_add(legalMoves, 3, yy, 5, yy);
							}
						}
				
						if (AIColor == WHITE)  //  AI is playing white pieces on north side
						{
							if (AICanCastleKingSide) && (xx == 4)
							{
								var castleTarget = boardState[6, yy];  // offset 2, 0
								var targetID = boardState[5, yy];
								if (targetID[1] == 0) && (castleTarget[1] == 0) &&
									!((threatenedSquare_scr(4, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(5, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(6, yy, boardState, AISeat, AIColor)) ) 
									ds_list_add(legalMoves, 4, yy, 6, yy);
							}
				
							if (AICanCastleQueenSide) && (xx == 4)
							{
								var knightThere = boardState[1, yy];
								var castleTarget = boardState[2, yy];  // offset 2, 0
								var targetID = boardState[3, yy];
								if (targetID[1] == 0) && (castleTarget[1] == 0) && (knightThere[1] == 0) &&
									!((threatenedSquare_scr(4, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(3, yy, boardState, AISeat, AIColor)) ) &&
									!((threatenedSquare_scr(2, yy, boardState, AISeat, AIColor)) ) 
									ds_list_add(legalMoves, 4, yy, 2, yy);
							}
						}
					}
				
					var targetID = boardState[xx - 1, yy];  // offset -1, 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx - 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy);
					
					var targetID = boardState[xx -1, yy - 1];  // offset -1, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) 
					&&
					!((threatenedSquare_scr(xx - 1, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx - 1, yy - 1);
				
					var targetID = boardState[xx, yy - 1];  // offset 0, -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx, yy - 1);
			
					var targetID = boardState[xx + 1, yy - 1];  // offset 1 , -1
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) && 
					!((threatenedSquare_scr(xx + 1, yy - 1, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy - 1);
					
					var targetID = boardState[xx + 1, yy];  // offset 1 , 0
					if ((targetID[1] == 0) || (targetID[1] == nonMovingSide)) 
					&& !((threatenedSquare_scr(xx + 1, yy, boardState, AISeat, AIColor)) )
						ds_list_add(legalMoves, xx, yy, xx + 1, yy);	
				}		
			}
		
			if array_equals(boardState[xx, yy],[ROOK, AIColor])
			{		// Look left, first measuring room to maneuver, then iterate until hit obstacle
				if (xx > 0)
				{	var availableSpace = xx;
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx - i, yy];  // offset -i, 0
						if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx - i, yy); // empty; keep looking
						if (targetID[1] == nonMovingSide)  // record move and stop.
						{
							ds_list_add(legalMoves, xx, yy, xx - i, yy);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (xx < 7)  // now look right
				{	var availableSpace = 7 - xx;
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx + i, yy];  // offset i, 0
						if (targetID[1] == 0) ds_list_add(legalMoves, xx, yy, xx + i, yy);
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, xx, yy, xx + i, yy);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (yy > 0)  // now look up
				{	var availableSpace = yy;
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx, yy - i];  // offset 0, -i
						if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx, yy - i);
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, xx, yy, xx, yy - i);
							break;
						}	
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (yy < 7)  // now look down
				{	var availableSpace = 7 - yy;
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx, yy + i];  // offset 0, +i
						if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx, yy + i);
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, xx, yy, xx, yy + i);
							break;
						}	
						if (targetID[1] == AIColor) break;
					}
				}
			}
		
			if array_equals(boardState[xx, yy],[BISHOP, AIColor])
			{
				if (xx > 0) && (yy > 0) // start looking NW
				{	var availableSpace = min(xx, yy);  // has less space than a rook!
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx - i, yy - i];  // offset -i, -i
						if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx - i, yy - i);
						if (targetID[1] == nonMovingSide)  // record move and stop.
						{
							ds_list_add(legalMoves, xx, yy, xx - i, yy - i);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (xx < 7) && (yy < 7)  // next looking SE
				{	var availableSpace = min ((7 - xx), (7 - yy));
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx + i, yy + i];  // offset i, i
						if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx + i, yy + i); // empty; keep looking
						if (targetID[1] == nonMovingSide)  // record move and stop.
						{
							ds_list_add(legalMoves, xx, yy, xx + i, yy + i);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (xx > 0) && (yy < 7) // now look SW
				{	var availableSpace = min(xx, (7 - yy));  // has less space than a rook!
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx - i, yy + i];  // offset -i, +i
						if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx - i, yy + i); // empty; keep looking
						if (targetID[1] == nonMovingSide)  // record move and stop.
						{
							ds_list_add(legalMoves, xx, yy, xx - i, yy + i);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (xx < 7) && (yy > 0) // end by looking NE
				{	var availableSpace = min((7 - xx), yy);  // has less space than a rook!
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx + i, yy - i];  // offset +i, -i
						if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx + i, yy - i); // empty; keep looking
						if (targetID[1] == nonMovingSide)  // record move and stop.
						{
							ds_list_add(legalMoves, xx, yy, xx + i, yy - i);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			}
		
			if array_equals(boardState[xx, yy],[QUEEN, AIColor])
			{
				if (xx > 0)
				{	var availableSpace = xx;
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx - i, yy];  // offset -i, 0
						if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx - i, yy); // empty; keep looking
						if (targetID[1] == nonMovingSide)  // record move and stop.
						{
							ds_list_add(legalMoves, xx, yy, xx - i, yy);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (xx < 7)  // now look right
				{	var availableSpace = 7 - xx;
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx + i, yy];  // offset i, 0
						if (targetID[1] == 0) ds_list_add(legalMoves, xx, yy, xx + i, yy);
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, xx, yy, xx + i, yy);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (yy > 0)  // now look up
				{	var availableSpace = yy;
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx, yy - i];  // offset 0, -i
						if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx, yy - i);
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, xx, yy, xx, yy - i);
							break;
						}	
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (yy < 7)  // now look down
				{	var availableSpace = 7 - yy;
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx, yy + i];  // offset 0, +i
						if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx, yy + i);
						if (targetID[1] == nonMovingSide)
						{
							ds_list_add(legalMoves, xx, yy, xx, yy + i);
							break;
						}	
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (xx > 0) && (yy > 0) // start looking NW
				{	var availableSpace = min(xx, yy);  // has less space than a rook!
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx - i, yy - i];  // offset -i, -i
						if (targetID[1] == 0)  ds_list_add(legalMoves, xx, yy, xx - i, yy - i);
						if (targetID[1] == nonMovingSide)  // record move and stop.
						{
							ds_list_add(legalMoves, xx, yy, xx - i, yy - i);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (xx < 7) && (yy < 7)  // next looking SE
				{	var availableSpace = min ((7 - xx), (7 - yy));
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx + i, yy + i];  // offset i, i
						if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx + i, yy + i); // empty; keep looking
						if (targetID[1] == nonMovingSide)  // record move and stop.
						{
							ds_list_add(legalMoves, xx, yy, xx + i, yy + i);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (xx > 0) && (yy < 7) // now look SW
				{	var availableSpace = min(xx, (7 - yy));  // has less space than a rook!
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx - i, yy + i];  // offset -i, +i
						if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx - i, yy + i); // empty; keep looking
						if (targetID[1] == nonMovingSide)  // record move and stop.
						{
							ds_list_add(legalMoves, xx, yy, xx - i, yy + i);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			
				if (xx < 7) && (yy > 0) // end by looking NE
				{	var availableSpace = min((7 - xx), yy);  // has less space than a rook!
					for (var i = 1; i <= availableSpace; i += 1;)
					{
						var targetID = boardState[xx + i, yy - i];  // offset +i, -i
						if ((targetID[1] == 0))  ds_list_add(legalMoves, xx, yy, xx + i, yy - i); // empty; keep looking
					
						if (targetID[1] == nonMovingSide)  // Capture! Record move and stop.
						{
							ds_list_add(legalMoves, xx, yy, xx + i, yy - i);
							break;
						}
						if (targetID[1] == AIColor) break;
					}
				}
			}
		}
	}

	return legalMoves;
	ds_list_destroy(legalMoves);


}
