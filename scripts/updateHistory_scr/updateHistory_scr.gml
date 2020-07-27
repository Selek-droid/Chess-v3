function updateHistory_scr(argument0, argument1, argument2, argument3, argument4, argument5) {
	var piece = argument0;
	var oldX = argument1;
	var oldY = argument2;
	var newX = argument3;
	var newY = argument4;
	var capture = argument5;

	var formattedMove;

	//notationX[7] = "h";
	//notationX[6] = "g";
	//notationX[5] = "f";
	//notationX[4] = "e";
	//notationX[3] = "d";
	//notationX[2] = "c";
	//notationX[1] = "b";
	//notationX[0] = "a";

	//if global.HermioneColor == BLACK
	//{
	//notationY[7] = "1";
	//notationY[6] = "2";
	//notationY[5] = "3";
	//notationY[4] = "4";
	//notationY[3] = "5";
	//notationY[2] = "6";
	//notationY[1] = "7";
	//notationY[0] = "8";
	//}
 
	// store info for AI openings and stalemate by repetition
	// reformat info to display to user (console for now)

	ds_list_add(oGame.history,piece[0],oldX,oldY,newX,newY,capture);  
	switch (piece[0]) 
	{
		case PAWN: 
		{
			if (capture)
			{
				formattedMove = string(oGame.notationX[oldX]) + string("x") + string(oGame.notationX[newX]) 
					+ string(oGame.notationY[newY]);
				break;
			}
			else
			{
				formattedMove = string(oGame.notationX[newX]) + string(oGame.notationY[newY]);
				break;
			}
		}
	
		case KING:
		{ 
			if (abs(newX - oldX) == 2) 
			{
				if (global.HermioneColor == BLACK)	
				{
					if (newX == 6) 
					{
						formattedMove = "0-0";
						break;
					}
			
					else
					{
						formattedMove = "0-0-0";
						break;
					}
				}
				else if (global.HermioneColor == WHITE)
				{
					if (newX == 1) 
					{
						formattedMove = "0-0";
						break;
					}
			
					else
					{
						formattedMove = "0-0-0";
						break;
					}
				}
			}
			else
			{
				formattedMove = string("K") + string(oGame.notationX[newX]) + string(oGame.notationY[newY]);
				break;
			}
		}
	
		case BISHOP:
		{
		
			if (capture)
			{
				formattedMove = string("B" + string("x") + string(oGame.notationX[newX]) 
					+ string(oGame.notationY[newY]));
				break;
			}
			else
			{
				formattedMove = string("B") + string(oGame.notationX[newX]) + string(oGame.notationY[newY]);
				break;
			}
		
		}
	
		case KNIGHT:
		{
			if (capture)
			{
				formattedMove = string("N") + string("x") + string(oGame.notationX[newX]) 
					+ string(oGame.notationY[newY]);
				break;
			}
			else
			{
				formattedMove = string("N") + string(oGame.notationX[newX]) + string(oGame.notationY[newY]);
				break;
			}
		}
	
		case QUEEN:
		{
			if (capture)
			{
				formattedMove = string("Q") + string("x") + string(oGame.notationX[newX]) 
					+ string(oGame.notationY[newY]);
				break;
			}
			else
			{
			formattedMove = string("Q") + string(oGame.notationX[newX]) + string(oGame.notationY[newY]);
			break;
			}
		}
	
		case ROOK:
		{
			if (capture)
			{
				formattedMove = string("R") + string("x") + string(oGame.notationX[newX]) 
					+ string(oGame.notationY[newY]);
				break;
			}
			else
			{
			formattedMove = string("R") + string(oGame.notationX[newX]) + string(oGame.notationY[newY]);
			}
		}
		
	}

	ds_list_add(oGame.formattedHistory,formattedMove);
	show_debug_message("Turn " + string(oGame.turn) + " : " + formattedMove);


}
