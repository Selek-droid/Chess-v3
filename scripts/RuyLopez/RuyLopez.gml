function RuyLopez() {
	if (oGame.turn == 1) 
		{
			animate([PAWN, WHITE],3,1,3,3);  // P-K4 : start of Ruy Lopez, perhaps
			updateHistory_scr([PAWN, WHITE], 3, 1, 3, 3, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
	if (oGame.turn == 2) 
	{
		if ((ds_list_find_value(oGame.formattedHistory,1) == "e5")) || // Black played Ruy Lopez
		(ds_list_find_value(oGame.formattedHistory,1) == "Nc6") ||
		(ds_list_find_value(oGame.formattedHistory,1) == "c5")   // Black responded with Sicilian defense
		{
			animate([KNIGHT, WHITE],1,0,2,2);    // White continues either way with Nf3
			updateHistory_scr([KNIGHT, WHITE], 1, 0, 2, 2, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}

		else	
		{
			animate([KNIGHT, WHITE],1,0,2,2);
			updateHistory_scr([KNIGHT, WHITE], 1, 0, 2, 2, false);   // else play Nf3 but exit script, for now
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			oGame.AIOpening = false;
			exit;
		}
	}	

	if (oGame.turn == 3) 
	{
		if ((ds_list_find_value(oGame.formattedHistory,3) == "Nc6") &&  // Black continued Ruy Lopez with 2..Nc6
		(ds_list_find_value(oGame.formattedHistory,1) == "e5"))
		{
			animate([BISHOP, WHITE],2,0,6,4);   // White continues Ruy Lopez with 3. Bb5 (B-N5)
			updateHistory_scr([BISHOP, WHITE], 2, 0, 6, 4, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else if ((ds_list_find_value(oGame.formattedHistory,3) == "d6") &&  // Black continued Siicilian 2 ... d6
		(ds_list_find_value(oGame.formattedHistory,1) == "c5")) 
		{
			animate([PAWN, WHITE],4,1,4,3);   // White engages Sicilian with 3. d4 (P-Q4)
			updateHistory_scr([PAWN, WHITE], 3, 1, 3, 3, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else if ((ds_list_find_value(oGame.formattedHistory,3) == "Nc6") &&  // Black continued Siicilian 2 ... Nc6
		(ds_list_find_value(oGame.formattedHistory,1) == "c5")) 
		{
			animate([PAWN, WHITE],3,1,3,3);   // White again engages Sicilian with 3. d4 (P-Q4)
			updateHistory_scr([PAWN, WHITE], 3, 1, 3, 3, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else if ((ds_list_find_value(oGame.formattedHistory,3) == "e6") &&  // Black continued Siicilian 2 ... Nc6
		(ds_list_find_value(oGame.formattedHistory,1) == "c5")) 
		{
			animate([PAWN, WHITE],3,1,3,3);   // White again engages Sicilian with 3. d4 (P-Q4)
			updateHistory_scr([PAWN, WHITE], 3, 1, 3, 3, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else if ((ds_list_find_value(oGame.formattedHistory,3) == "Nf6") &&  // Black continued Siicilian 2 ... Nf6?!
		(ds_list_find_value(oGame.formattedHistory,1) == "c5")) 
		{
			animate([PAWN, WHITE],3,3,3,4);   // White replies with 3. e5 (P-K5)
			updateHistory_scr([PAWN, WHITE], 3, 3, 3, 4, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
		else
		{
			oGame.AIMadeScriptedMove = false;
			oGame.AIOpening = false;
			exit;
		}
	}

	if (oGame.turn == 4) 
	{
		if (ds_list_find_value(oGame.formattedHistory,5) == "a6") &&   // and Black added 3 ... a6
		(ds_list_find_value(oGame.formattedHistory,3) == "Nc6") &&  // Black continued Ruy Lopez with 2..Nc6
		(ds_list_find_value(oGame.formattedHistory,1) == "e5")
		{
			animate([BISHOP, WHITE],6,4,7,3);   // White continues Ruy Lopez with 4. Ba4 (declining exchange)
			updateHistory_scr([BISHOP, WHITE], 6, 4, 7, 3, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else if (ds_list_find_value(oGame.formattedHistory,5) == "cxd4") && // Black Sicilian 3 ... cxd4
		(ds_list_find_value(oGame.formattedHistory,3) == "d6") &&  // Black continued Siicilian 2 ... d6
		(ds_list_find_value(oGame.formattedHistory,1) == "c5") 
		{
			animate([KNIGHT, WHITE],2,2,4,3);   // White engages Sicilian with 4. Nxd4
			updateHistory_scr([KNIGHT, WHITE], 2, 2, 4, 3, true);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			oGame.AIOpening = false;   // will add more later
			exit;
		}
	
		else if (ds_list_find_value(oGame.formattedHistory,5) == "cxd4") && // Black Sicilian 3 ... cxd4
		(ds_list_find_value(oGame.formattedHistory,3) == "Nc6") &&  // Black continued Siicilian 2 ... Nc6
		(ds_list_find_value(oGame.formattedHistory,1) == "c5") 
		{
			animate([KNIGHT, WHITE],2,2,4,3);   // White engages Sicilian with 4. Nxd4
			updateHistory_scr([KNIGHT, WHITE], 2, 2, 4, 3, true);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			oGame.AIOpening = false;   // will add more later
			exit;
		}
	
		else if (ds_list_find_value(oGame.formattedHistory,5) == "Nd5") &&  //  Black 3. ... Nd5
		(ds_list_find_value(oGame.formattedHistory,3) == "Nf6") &&  // Black Sicilian 2 ... Nf6?!
		(ds_list_find_value(oGame.formattedHistory,1) == "c5") 
		{
			animate([PAWN, WHITE],5,1,5,3);   // White replies with 4. c4 
			updateHistory_scr([PAWN, WHITE], 5, 1, 5, 3, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else
		{
			oGame.AIMadeScriptedMove = false;
			oGame.AIOpening = false;
			exit;
		}
	}

	if (oGame.turn == 5) 
	{
		if (ds_list_find_value(oGame.formattedHistory,7) == "Nf6") && // Black 4 ... Nf6, not chasing Bishop
		(ds_list_find_value(oGame.formattedHistory,5) == "a6") &&   // and Black added 3 ... a6
		(ds_list_find_value(oGame.formattedHistory,3) == "Nc6") &&  // Black continued Ruy Lopez with 2..Nc6
		(ds_list_find_value(oGame.formattedHistory,1) == "e5")
		{
			oBoard.grid[3, 0] = [0, 0];   // White continues Ruy Lopez with 5. 0-0
			oBoard.grid[0, 0] = [0, 0];
			oBoard.grid[1, 0] = [KING, WHITE];
			oBoard.grid[2, 0] = [ROOK, WHITE];
			updateHistory_scr([BISHOP, WHITE], 6, 4, 7, 3, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;  // still scripted opening
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	
		else if (ds_list_find_value(oGame.formattedHistory,7) == "b5") && // Black 4 ... b5, chasing Bishop
		(ds_list_find_value(oGame.formattedHistory,5) == "a6") &&   // and Black added 3 ... a6
		(ds_list_find_value(oGame.formattedHistory,3) == "Nc6") &&  // Black continued Ruy Lopez with 2..Nc6
		(ds_list_find_value(oGame.formattedHistory,1) == "e5")
		{
			{
			animate([BISHOP, WHITE],7,3,6,2);   // White continues Ruy Lopez with 4. Bb3 (backing up)
			updateHistory_scr([BISHOP, WHITE], 7, 3, 6, 2, false);
			show_debug_message("backing up");
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = true;
			oGame.AIMadeScriptedMove = true;
			exit;
			}
		}
	
		else
		{
			oGame.AIMadeScriptedMove = false;
			oGame.AIOpening = false;
			exit;
		}
	}

	if (oGame.turn == 6) 
	{
		if (ds_list_find_value(oGame.formattedHistory,9) == "Na5") &&  // Black 5 ... Na5, chasing still
		(ds_list_find_value(oGame.formattedHistory,7) == "b5") && // Black 4 ... b5, chasing Bishop
		(ds_list_find_value(oGame.formattedHistory,5) == "a6") &&   // and Black added 3 ... a6
		(ds_list_find_value(oGame.formattedHistory,3) == "Nc6") &&  // Black continued Ruy Lopez with 2..Nc6
		(ds_list_find_value(oGame.formattedHistory,1) == "e5")
		{
			oBoard.grid[3, 0] = [0, 0];   // White continues Ruy Lopez with 6. 0-0
			oBoard.grid[0, 0] = [0, 0];
			oBoard.grid[1, 0] = [KING, WHITE];
			oBoard.grid[2, 0] = [ROOK, WHITE];
			updateHistory_scr([BISHOP, WHITE], 6, 4, 7, 3, false);
			oGame.turn += 1;
			oGame.state = "Player Turn";
			oGame.AIOpening = false;
			oGame.AIMadeScriptedMove = true;
			exit;
		}
	}


}
