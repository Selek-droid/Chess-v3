function SicilianDefense() {
	if (oGame.turn == 1) 
		{
			animate([PAWN, BLACK],2,1,2,3);
			updateHistory_scr([PAWN, BLACK], 2, 1, 2, 3, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}

	if (oGame.turn == 2) 
	{
		if ((ds_list_find_value(oGame.formattedHistory,2) == "Nf3"))
		{
			animate([PAWN, BLACK],3,1,3,2);
			updateHistory_scr([PAWN, BLACK], 3, 1, 3, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
		else if ((ds_list_find_value(oGame.formattedHistory,2) == "d4"))
		{
			animate([PAWN, BLACK],2,3,3,4);  // 2...Pxd4
			updateHistory_scr([PAWN, BLACK], 2, 3, 3, 4, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			oGame.AIOpening = false;
			exit;
		}
		else	
		{
			animate([KNIGHT, BLACK],1,0,2,2);
			updateHistory_scr([KNIGHT, BLACK], 1, 0, 2, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			oGame.AIOpening = false;
			exit;
		}
	}	
	
	if (oGame.turn == 3) 
	{ 
		if (ds_list_find_value(oGame.formattedHistory,4) == "d4")
		{
			animate([PAWN, BLACK],2,3,3,4);  // Pawn x d4
			updateHistory_scr([PAWN, BLACK], 2, 3, 3, 4, true);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
		else
		{
			animate([KNIGHT, BLACK],6,0,5,2);
			updateHistory_scr([KNIGHT, BLACK], 6, 0, 5, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			oGame.AIOpening = false;
			exit;
		}
	}
	
	if (oGame.turn == 4) 
	{
		if (ds_list_find_value(oGame.formattedHistory,6) == "Nxd4")
		{
			animate([KNIGHT, BLACK],6,0,5,2);  // Nf6
			updateHistory_scr([KNIGHT, BLACK], 6, 0, 5, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
		else 
		{
			animate([KNIGHT, BLACK],6,0,5,2);  // Nf6 but stop script
			updateHistory_scr([KNIGHT, BLACK], 6, 0, 5, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	}

	if (oGame.turn == 5)
	{
		if (ds_list_find_value(oGame.formattedHistory,8) == "Nc3")
		{
			animate([PAWN, BLACK],0,1,0,2);  // Najdorf variation: 5...a6
			updateHistory_scr([PAWN, BLACK],  0, 1, 0, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
		else   // let AI evaluate, because player might have left Knight vulnerable
		{
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = false;
			exit;
		}
	}
	

	if (oGame.turn == 6) 
	{
		if (ds_list_find_value(oGame.formattedHistory,10) == "Be3")
		{
			animate([PAWN, BLACK],4,1,4,3);  // Najdorf variation, English attack. Response: 6...e5
			updateHistory_scr([PAWN, BLACK], 4, 1, 4, 3, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			exit;
		}
	
		else if (ds_list_find_value(oGame.formattedHistory,10) == "Bg5")
		{
			animate([PAWN, BLACK],4,1,4,2);  // Najdorf variation, classical attack. Response: 6...e6
			updateHistory_scr([PAWN, BLACK], 4, 1, 4, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			exit;
		}
	
		else   // let AI evaluate
		{
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = false;
			exit;
		}
	}

	if (oGame.turn == 7) 
	{
		if (ds_list_find_value(oGame.formattedHistory,10) == "Be3") &&
		(ds_list_find_value(oGame.formattedHistory,12) == "Nb3")
		{
			animate([BISHOP, BLACK],2,0,4,2);  // Najdorf variation, English attack. Response: 7...Be6
			updateHistory_scr([BISHOP, BLACK], 2, 0, 4, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;
			exit;
		}
	
		else if (ds_list_find_value(oGame.formattedHistory,10) == "Bg5") &&
		(ds_list_find_value(oGame.formattedHistory,12) == "f4")
		{
			animate([BISHOP, BLACK],5,0,4,1);  // Najdorf variation, classical attack. Response: 7...Be7
			updateHistory_scr([BISHOP, BLACK], 5, 0, 4, 1, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;
			exit;
		}
	
		else   // let AI evaluate
		{
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = false;
			exit;
		}
	}

	if (oGame.turn == 8) 
	{
		if (ds_list_find_value(oGame.formattedHistory,10) == "Be3") &&
		(ds_list_find_value(oGame.formattedHistory,12) == "Nb3") &&
		(ds_list_find_value(oGame.formattedHistory,14) == "f3")
		{
			animate([BISHOP, BLACK],5,0,4,1);  // Response: 8...Be7
			updateHistory_scr([BISHOP, BLACK], 5, 0, 4, 1, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else if (ds_list_find_value(oGame.formattedHistory,10) == "Bg5") &&
		(ds_list_find_value(oGame.formattedHistory,12) == "f4") &&
		(ds_list_find_value(oGame.formattedHistory,14) == "Qf3")
		{
			animate([QUEEN, BLACK],3,0,2,1);  // Response: 8...Qc7. 
			updateHistory_scr([QUEEN, BLACK], 3, 0, 2, 1, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;
			oGame.AIMadeScriptedMove = true;
			exit;
		}	
	
		else   // let AI evaluate
		{
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = false;
			exit;
		}
	}
	
	if (oGame.turn == 9) 
	{
		if (ds_list_find_value(oGame.formattedHistory,10) == "Be3") &&
		(ds_list_find_value(oGame.formattedHistory,12) == "Nb3") &&
		(ds_list_find_value(oGame.formattedHistory,14) == "f3") &&
		(ds_list_find_value(oGame.formattedHistory,16) == "Qd2") 
	
		{
			animate([KNIGHT, BLACK],1,0,3,1);  // Response: 9...N(b)d7
			updateHistory_scr([KNIGHT, BLACK], 1, 0, 3, 1, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
						// classical variation
		else if (ds_list_find_value(oGame.formattedHistory,10) == "Bg5") &&
		(ds_list_find_value(oGame.formattedHistory,12) == "f4") &&
		(ds_list_find_value(oGame.formattedHistory,14) == "Qf3") &&
			(ds_list_find_value(oGame.formattedHistory,16) == "0-0-0") 
		{
			animate([KNIGHT, BLACK],1,0,3,1);  // Response: 9...N(b)d7
			updateHistory_scr([KNIGHT, BLACK], 1, 0, 3, 1, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else   // let AI evaluate
		{
			oGame.AIOpening = true;
			oGame.AIMadeScriptedMove = false;
			exit;
		}
	}
	
	if (oGame.turn == 10) 
	{
		if (ds_list_find_value(oGame.formattedHistory,10) == "Be3") &&
		(ds_list_find_value(oGame.formattedHistory,12) == "Nb3") &&
		(ds_list_find_value(oGame.formattedHistory,14) == "f3") &&
		(ds_list_find_value(oGame.formattedHistory,16) == "Qd2") &&
		(ds_list_find_value(oGame.formattedHistory,18) == "0-0-0") 
	
		{
			ds_list_add(oGame.formattedHistory,"O-O");
			show_debug_message("0-0");
			oBoard.grid[4, 0] = [0, 0];
			oBoard.grid[7, 0] = [0, 0];
			oBoard.grid[6, 0] = [KING, BLACK];
			oBoard.grid[5, 0] = [ROOK, BLACK];
			oBoard.NorthCanCastleLeft = false;
			oBoard.NorthCanCastleRight = false;
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
						// classical variation
		else if (ds_list_find_value(oGame.formattedHistory,10) == "Bg5") &&
		(ds_list_find_value(oGame.formattedHistory,12) == "f4") &&
		(ds_list_find_value(oGame.formattedHistory,14) == "Qf3") &&
			(ds_list_find_value(oGame.formattedHistory,16) == "0-0-0") &&
			(ds_list_find_value(oGame.formattedHistory,18) != "Nxe6")
		
			// ignore next white move (unless Nxe6 check) & castle
		{
			ds_list_add(oGame.formattedHistory,"O-O");
			show_debug_message("0-0");
			oBoard.grid[4, 0] = [0, 0];
			oBoard.grid[7, 0] = [0, 0];
			oBoard.grid[6, 0] = [KING, BLACK];
			oBoard.grid[5, 0] = [ROOK, BLACK];
			oBoard.NorthCanCastleLeft = false;
			oBoard.NorthCanCastleRight = false;
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else   // let AI evaluate
		{
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = false;
			exit;
		}
	}
	


}
