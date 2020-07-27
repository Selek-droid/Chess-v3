function NimzoIndianDefense() {
	if (oGame.turn == 1) 
		{
			animate([KNIGHT, BLACK],6,0,5,2);
			updateHistory_scr([PAWN, BLACK], 6, 0, 5, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
	if (oGame.turn == 2) 
	{
		if ((ds_list_find_value(oGame.formattedHistory,2) == "c4"))
		{
			animate([PAWN, BLACK],4,1,4,2);
			updateHistory_scr([PAWN, BLACK], 4, 1, 4, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else	
		{
			animate([PAWN, BLACK],4,1,4,2);
			updateHistory_scr([PAWN, BLACK], 4, 1, 4, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	}	

	if (oGame.turn == 3) 
	{ 
		if (ds_list_find_value(oGame.formattedHistory,4) == "Nc3")
		{
			animate([BISHOP, BLACK],5,0,1,4);  // Pawn x d4
			updateHistory_scr([BISHOP, BLACK], 5, 0, 1, 4, true);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
		else
		{
			animate([BISHOP, BLACK],5,0,4,1);
			updateHistory_scr([BISHOP, BLACK], 5, 0, 4, 1, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			oGame.AIOpening = false;
			exit;
		}
	}


}
