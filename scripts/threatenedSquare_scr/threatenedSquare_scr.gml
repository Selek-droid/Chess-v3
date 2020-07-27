function threatenedSquare_scr(argument0, argument1, argument2, argument3, argument4) {
	// Are enemy pieces threatening the target square? (If so, king can't move there.)
	// xx, yy is the square we're testing.
	// Get current square (boardstate[xx,yy]), then see whether offset enemy units are targeting it.

	var enemy;
	var friend;
	var availableSpace;
	var xx = argument0;
	var yy = argument1;
	var boardState = argument2;  
	var moversSeat = argument3;  // SOUTH or NORTH.  If player, always SOUTH; if AI, oscillates.
	var moversColor = argument4;  // BLACK or WHITE.

	if (moversColor == BLACK) 
	{
		var enemy = WHITE;
		var friend = BLACK;
	}
	else
	{
		enemy = BLACK;
		friend = WHITE;
	}

	// Check 1-square range first -- King and Pawns essentially, but others as warranted

	if (xx == 0) && (yy < 7) && (yy > 0) // LEFT EDGE but not corners
	{
		var targetID = boardState[xx, yy - 1];  // check for above king (and R, Q while at it)
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx + 1, yy - 1];  // king, Q, B directly NE
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
			if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
			}
		}
	
		else if moversSeat == SOUTH
		{	if (targetID[1] == enemy)
				{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				|| (targetID[0] == PAWN) return true;
				}
			}
		
		var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx + 1, yy + 1];  // King, Q, B, P directly SE
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				|| (targetID[0] == PAWN) return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				return true;
			}
		}
	
		var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	}

	// ===============================================================================================

	if (xx == 7) && (yy < 7) && (yy > 0 )  // RIGHT EDGE, but not corners, range 1
	{
		var targetID = boardState[xx, yy - 1];  // check for K, Q, R directly N
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx - 1, yy - 1];  // King, Q, B directly NW
		if moversSeat == NORTH
		{	if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
			}
		}
		else if moversSeat == SOUTH
		{	if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				|| (targetID[0] == PAWN) return true;
			}
		}
	
		var targetID = boardState[xx = 1, yy];  // King, Q, R directly W
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx - 1, yy + 1];  // King, Q, B, P directly SW
		if moversSeat == NORTH
		{	if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				|| (targetID[0] == PAWN) return true;
			}
		} 
		else if moversSeat == SOUTH
		{	if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
			}
		} 
		
		var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}

	}

	// --------------------------------------------------------------------------------------

	if (xx > 0) && (xx < 7 ) && (yy == 0)  // TOP EDGE, range 1
	{
		var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx + 1, yy + 1];  // King, Q, B, P directly SE
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				|| (targetID[0] == PAWN) return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
			}
		}
	
		var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx - 1, yy];  // King, Q, R directly W
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx - 1, yy + 1];  // King, Q, B or P directly SW
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				|| (targetID[0] == PAWN) return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
			}
		}

	}

	// TOP RIGHT CORNER ===========================================

	if (xx == 7 ) && (yy == 0)  
	{
		var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx - 1, yy];  // King, Q, R directly W
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx - 1, yy + 1];  // King, Q, B or P directly SW
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				|| (targetID[0] == PAWN) return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
			}
		}
	}

	// TOP LEFT CORNER ===========================================

	if (xx == 0 ) && (yy == 0)  
	{
		var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}

		var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx + 1, yy + 1];  // King, Q, B, P directly SE
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				|| (targetID[0] == PAWN) return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
			}
		}
	}

	// BOTTOM LEFT CORNER ===========================================

	if (xx == 0 ) && (yy == 7)  
	{
		var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx, yy - 1];  // K, Q, R directly N
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx + 1, yy - 1];  // king, Q, B directly NE
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				|| (targetID[0] == PAWN) return true;
			}
		}
	}
	
		// BOTTOM RIGHT CORNER ===========================================

	if (xx == 7 ) && (yy == 7)  
	{
		var targetID = boardState[xx, yy - 1];  // K, Q, R directly N
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx - 1, yy - 1];  // King, Q, B directly NW
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				|| (targetID[0] == PAWN) return true;
			}
		}
	
		var targetID = boardState[xx - 1, yy];  // King, Q, R directly W
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	}

	// -------------------------------------------------------------------------

	if (xx < 7 ) && (xx > 0 ) && (yy == 7)  // BOTTOM EDGE, range 1
	{
		var targetID = boardState[xx, yy - 1];  // K, Q, R directly N
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx + 1, yy - 1];  // king, Q, B directly NE
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				|| (targetID[0] == PAWN) return true;
			}
		}
	
		var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx - 1, yy - 1];  // King, Q, B directly NW
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				|| (targetID[0] == PAWN) return true;
			}
		}
	
		var targetID = boardState[xx - 1, yy];  // King, Q, R directly W
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}

	} 


	// =================================================================================================

	if (xx < 7 ) && ( xx > 0 ) && (yy < 7) && (yy > 0)  // MOST OTHER 1-range CASES -- MIDDLE SQUARES
	{
		var targetID = boardState[xx, yy - 1];  // check K, Q, R directly N of target square
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx + 1, yy - 1];  // king, Q, B directly NE
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				|| (targetID[0] == PAWN) return true;
			}
		}
	
		var targetID = boardState[xx + 1, yy];  // King, Q, R directly E
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx + 1, yy + 1];  // King, Q, B, P directly SE
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				|| (targetID[0] == PAWN) return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
			}
		}
	
		var targetID = boardState[xx, yy + 1];  // King, Q, R directly S
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx - 1, yy - 1];  // King, Q, B directly NW
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				|| (targetID[0] == PAWN) return true;
			}
		}
	
		var targetID = boardState[xx - 1, yy];  // King, Q, R directly W
		if (targetID[1] == enemy)
		{
			if (targetID[0] == KING) || (targetID[0] == ROOK) || (targetID[0] == QUEEN) return true;
		}
	
		var targetID = boardState[xx - 1, yy + 1];  // King, Q, B, P directly SW
		if moversSeat == NORTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN)
				|| (targetID[0] == PAWN) return true;
			}
		}
		else if moversSeat == SOUTH
		{
			if (targetID[1] == enemy)
			{
				if (targetID[0] == KING) || (targetID[0] == BISHOP) || (targetID[0] == QUEEN) return true;
			}
		}
	}

	// ==================== Distant Q and R. Look LEFT first, starting at range 1 to be safe, in case I missed one.

	if (xx > 0)
	{	
		var availableSpace = xx;
		for (var i = 1; i <= availableSpace; i += 1;)
		{
			var targetID = boardState[xx - i, yy];  // offset -i, 0
			if (targetID[1] == friend) 
			{
				if (targetID[0] != KING) break;    // friendly non-king blocks enemy fire; 
			}
			if (targetID[1] == enemy) 
			{
				if (targetID[0] == ROOK) || (targetID[0] == QUEEN) 
				{
					return true;
				}
				else break;  // even enemy piece shields AI king
			}
		}
	}			

	if (xx < 7)  // Now look right for Q and R.
	{
	var availableSpace = 7 - xx;
		for (var i = 1; i <= availableSpace; i += 1;)
		{
			var targetID = boardState[xx + i, yy];  // offset i, 0
			if (targetID[1] == friend) 
			{
				if (targetID[0] != KING) break;    // friendly non-king blocks enemy fire; 
			}									  //  if it is king keep looping past king to distant Q/R
			if (targetID[1] == enemy) 
			{
				if (targetID[0] == ROOK) || (targetID[0] == QUEEN) 
				{
					return true;
				}
				else break;  // even enemy piece shields AI king. Keep looking
			}
		}
	}

	if (yy > 0)  // Look up for Q and R
	{
	var availableSpace = yy;
		for (var i = 1; i <= availableSpace; i += 1;)
		{
			var targetID = boardState[xx, yy - i];  // offset 0, -i
			if (targetID[1] == friend)
			{
				if (targetID[0] != KING) break;    // friendly non-king blocks enemy fire; 
			}
			if (targetID[1] == enemy) 
			{
				if (targetID[0] == ROOK) || (targetID[0] == QUEEN) 
				{
					return true;
				}
				else break;  // even enemy piece shields AI king; keep looking for threats
			}
		}
	}

	if (yy < 7)  // Look down for Q and R
	{
	var availableSpace = 7 - yy;
		for (var i = 1; i <= availableSpace; i += 1;)
		{
			var targetID = boardState[xx, yy + i];  // offset 0, i
			if (targetID[1] == friend) 
			{
				if (targetID[0] != KING) break;    // friendly OR ENEMY non-king blocks enemy fire; 
			}
			if (targetID[1] == enemy) 
			{
				if (targetID[0] == ROOK) || (targetID[0] == QUEEN) 
				{
					return true;
				}
				else break;  // even enemy piece shields AI king
			}
		
		}
	}

	// ============= BISHOP & QUEEN as distant threats ====================================

	if (xx > 0) && (yy > 0) // start looking NW
	{	var availableSpace = min(xx, yy);  // has less space than a rook!
		for (var i = 1; i <= availableSpace; i += 1;)
		{
			var targetID = boardState[xx - i, yy - i];  // offset -i, -i
			if (targetID[1] == friend) 
			{
				if (targetID[0] != KING) break;    // friendly OR ENEMY non-king blocks enemy fire; 
			}
			if (targetID[1] == enemy) 
			{
				if (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				{
					return true;
				}
				else break;  // even enemy piece shields AI king
			}
		}
	}

	if (xx < 7) && (yy < 7)  // next looking SE
	{	
		var availableSpace = min ((7 - xx), (7 - yy));
		for (var i = 1; i <= availableSpace; i += 1;)
		{
			var targetID = boardState[xx + i, yy + i];  // offset i, i
			if (targetID[1] == friend) 
			{
				if (targetID[0] != KING) break;    // friendly OR ENEMY non-king blocks enemy fire; 
			}
			if (targetID[1] == enemy) 
			{
				if (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				{
					return true;
				}
				else break;  // even enemy piece shields AI king
			}
		}
	}	

	if (xx > 0) && (yy < 7) // now look SW
	{	
		var availableSpace = min(xx, (7 - yy));  // has less space than a rook!
		for (var i = 1; i <= availableSpace; i += 1;)
		{
			var targetID = boardState[xx - i, yy + i];  // offset -i, +i
			if (targetID[1] == friend) 
			{
				if (targetID[0] != KING) break;    // friendly OR ENEMY non-king blocks enemy fire; 
			}
			if (targetID[1] == enemy) 
			{
				if (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				{
					return true;
				}
				else break;  // even enemy piece shields AI king
			}
		}
	}
			
	if (xx < 7) && (yy > 0) // end by looking NE
	{	
		var availableSpace = min((7 - xx), yy);  // has less space than a rook!
		for (var i = 1; i <= availableSpace; i += 1;)
		{
			var targetID = boardState[xx + i, yy - i];  // offset +i, -i
			if (targetID[1] == friend) 
			{
				if (targetID[0] != KING) break;    // friendly OR ENEMY non-king blocks enemy fire; 
			}
			if (targetID[1] == enemy) 
			{
				if (targetID[0] == BISHOP) || (targetID[0] == QUEEN) 
				{
					return true;
				}
				else break;  // even enemy piece shields AI king
			}
		}
	}

	// -------------- KNIGHT threats ----------------------

	if (xx <= 6) && (yy <= 5) // offset 1, 2
	{
		var targetID = boardState[xx + 1, yy + 2];
		if ((targetID[1] == enemy) && (targetID[0] == KNIGHT))
		{
			return true;
		}
	}
			
	if (xx <= 5) && (yy <= 6) // offset 2, 1
	{
		var targetID = boardState[xx + 2, yy + 1];
		if ((targetID[1] == enemy) && (targetID[0] == KNIGHT))
		{
			return true;
		}
	}
			
	if (xx <= 5) && (yy >= 1) // offset 2, -1
	{
		var targetID = boardState[xx + 2, yy - 1];
		if ((targetID[1] == enemy) && (targetID[0] == KNIGHT))
		{
			return true;
		}
	}
				
	if (xx <= 6) && (yy >= 2) // offset 1, -2
	{
		var targetID = boardState[xx + 1, yy - 2];
		if ((targetID[1] == enemy) && (targetID[0] == KNIGHT))
		{
			return true;
		}
	}
				
	if (xx >= 2) && (yy >= 1) // offset -2, -1
	{
		var targetID = boardState[xx - 2, yy - 1];
		if ((targetID[1] == enemy) && (targetID[0] == KNIGHT))
		{
			return true;
		}
	}
			
	if (xx >= 2) && (yy <= 6) // offset -2, 1
	{
		var targetID = boardState[xx - 2, yy + 1];
		if ((targetID[1] == enemy) && (targetID[0] == KNIGHT))
		{
			return true;
		}
	}
		
	if (xx >= 1) && (yy <= 5) // offset -1, 2
	{
		var targetID = boardState[xx - 1, yy + 2];
		if ((targetID[1] == enemy) && (targetID[0] == KNIGHT))
		{
			return true;
		}
	}
			
	if (xx >= 1) && (yy >= 2) // offset -1, -2
	{
		var targetID = boardState[xx - 1, yy - 2];
		if (targetID[1] == enemy) && (targetID[0] == KNIGHT)
		{
			return true;
		}
	}

	else return false;


}
