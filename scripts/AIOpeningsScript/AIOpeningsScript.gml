function AIOpeningsScript() {
	if global.HermioneColor == BLACK
	{
		if (ds_list_find_value(oGame.formattedHistory,0) == "e4") 
		{
			SicilianDefense();
		}

		else if (ds_list_find_value(oGame.formattedHistory,0) == "d4") 
		{
			NimzoIndianDefense();
		}

		else
		{ 
			oGame.AIOpening = false;
			exit;
		}
	}

	else if oGame.AIOpening
	{
		RuyLopez();
	}


}
