switch (oGame.state)
{
	//case ("AI Turn"):
	//{
	//	AIscript();
	//	break;
	//}
	
	case ("Player Turn"):
		break;
	
	case ("Initializing"):
	{
		//if (global.HermioneColor == WHITE)
		//{
		//oGame.state = "AI Turn";
		//exit;
		//}
		oGame.state = "Player Turn";
	}
	oGame.state = "Player Turn";
}

if keyboard_check_pressed(vk_escape) game_end();

var targetID = 0;
var pieceType;
var proposedState;
var GrangerColor = global.HermioneColor;
var PlayerColor = COLOR.WHITE;

if (GrangerColor == COLOR.WHITE) PlayerColor = COLOR.BLACK;

if (!pickedUp) && (mouse_check_button_released(mb_left))  // pickup
{
	if (mouse_x >= x) && (mouse_x <= x + BOARD_WIDTH)
		&& (mouse_y >= y) && (mouse_y <= y + BOARD_HEIGHT)
	{
		//var testOne = floor((( mouse_x - x ) / SQUARE_SIZE ));
			 
		//var testTwo = 8 * floor(((( mouse_y - y )) / SQUARE_SIZE ));
		//show_debug_message(string("TestOne & 2 are :") + string(testOne) + " , " + string(testTwo));
		oldIndex = floor((( mouse_x - x ) / SQUARE_SIZE )) +
			(8 * floor(((( mouse_y - y )) / SQUARE_SIZE )));
		//oldIndex = floor ( (( mouse_x - x ) / SQUARE_SIZE ) + 
		//	 (( mouse_y - y ) * 8 ) / SQUARE_SIZE );
		mouse_clear(mb_left);
		if map[oldIndex]
		{
			selectedPiece = map[oldIndex];
			map[oldIndex] = 0;   // clear vacated square
			pickedUp = true;
			mouse_clear(mb_left); 
		}
	}
}

if (pickedUp) && (mouse_check_button_released(mb_left))  // destination clicked
{	
	newIndex = floor( ( mouse_x - x ) / SQUARE_SIZE ) + 
			(8 * (floor( (( mouse_y - y ) ) / SQUARE_SIZE )));  
	mouse_clear(mb_left);
	if (newIndex < 0) || (newIndex > 63) 
	{
		exit;
	}
	
	targetID = map[newIndex];
	if newIndex == oldIndex   // check whether dest = origin.
	{
		map[oldIndex] = selectedPiece; 
		pickedUp = false;
		selectedPiece = 0;
		oGame.state = "Player Turn";
		mouse_clear(mb_left);
		exit;
	}
	
	else if ((targetID & ITS_COLOR ) == GrangerColor) || !map[newIndex] // enemy or empty
		{
			pieceType = selectedPiece & ITS_TYPE;
			switch (pieceType) 
			{
				case PIECE.PAWN: 
				{
					if ( (targetID & 8) == GrangerColor) &&    // captures
						((oldIndex - newIndex == 7 ) || (oldIndex - newIndex == 9))  // next row up, offset 1
					{
						//proposedState = map;
						//proposedState[newIndex] = selectedPiece;
						//if PlayerAvoidsCheck_scr(proposedState)
						{
							map[newIndex] = selectedPiece;
							capture = true;
							//updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							//if (newY == 0) oBoard.grid[newX, newY] = [QUEEN, PlayerColor];  // code user choice later
							pickedUp = false;
							selectedPiece = 0;
							oGame.state = "AI Turn";
							break; // add en passant here
						}
					}	
					else if (oldIndex - newIndex == 8) && !map[newIndex]  // one-square move into empty square
					{
						//proposedState = map;
						//proposedState[newIndex] = selectedPiece;
						//if PlayerAvoidsCheck_scr(proposedState)
						{
							map[newIndex] = selectedPiece;
							capture = false;
							// updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							// if (newY == 0) oBoard.grid[newX, newY] = [QUEEN, PlayerColor];  // code user choice later
							pickedUp = false;
							selectedPiece = 0;
							oGame.state = "AI Turn";
							break;
						} 
					}
										
					else if (oldIndex > 47) && (oldIndex - newIndex == 16)  // Double pawn move
						&& !map[newIndex] && !map[(oldIndex - 8)]
					{
						//proposedState = map;
						//proposedState[newIndex] = selectedPiece;
						//if PlayerAvoidsCheck_scr(proposedState)
						{
							// updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							map[newIndex] = selectedPiece;
							pickedUp = false;
							selectedPiece = 0;
							oGame.state = "AI Turn";
							break;
						}
					}
					
					break;
				}
					
//				case KING:
//				{
//					if  ((abs (newX - gridX) <= 1) && (abs (newY - gridY) <= 1))  // not castling
//					{
//						proposedState = oBoard.grid;
//						proposedState[newX, newY] = selectedPiece;
//						if PlayerAvoidsCheck_scr(proposedState)
//						{
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
//							oBoard.grid[newX, newY] = selectedPiece;
//							SouthCanCastleLeft = false;
//							SouthCanCastleRight = false;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							break;
//						}
//					}
//// Castling code. White castling first:

//					if  (newX == gridX + 2) && (PlayerColor == WHITE) && (SouthCanCastleRight) // kingside castle, to right, as white.
//					{
//						if array_equals(oBoard.grid[5, 7],[0, 0]) &&
//						array_equals(oBoard.grid[6, 7],[0, 0]) &&
//						!threatenedSquare_scr(4, 7, oBoard.grid, SOUTH, PlayerColor) &&
//						!threatenedSquare_scr(5, 7, oBoard.grid, SOUTH, PlayerColor) &&
//						!threatenedSquare_scr(6, 7, oBoard.grid, SOUTH, PlayerColor) 
//						{
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, false);
//							oBoard.grid[6, 7] = [KING, PlayerColor];
//							oBoard.grid[5, 7] = [ROOK, PlayerColor];
//							oBoard.grid[7, 7] = [0 , 0];
//							SouthCanCastleLeft = false;
//							SouthCanCastleRight = false;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							break;
//						}
//					} 
					
//					if (newX == gridX - 2) && (PlayerColor == WHITE) && (SouthCanCastleLeft)  // Queenside, to left, as white
//					{
//						if array_equals(oBoard.grid[3, 7],[0, 0]) &&
//						array_equals(oBoard.grid[2, 7],[0, 0]) &&
//						array_equals(oBoard.grid[1, 7],[0, 0]) &&
//						!threatenedSquare_scr(4, 7, oBoard.grid, SOUTH, PlayerColor) &&
//						!threatenedSquare_scr(3, 7, oBoard.grid, SOUTH, PlayerColor) &&
//						!threatenedSquare_scr(2, 7, oBoard.grid, SOUTH, PlayerColor) 
//						{
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
//							oBoard.grid[2, 7] = [KING, PlayerColor];
//							oBoard.grid[3, 7] = [ROOK, PlayerColor];
//							oBoard.grid[0, 7] = [0 , 0];
//							SouthCanCastleLeft = false;
//							SouthCanCastleRight = false;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							break;
//						}
//					}
					
//					if  (newX == gridX + 2) && (PlayerColor == BLACK) && (SouthCanCastleRight)   // Queenside black castle, to right.
//					{
//						if array_equals(oBoard.grid[4, 7],[0, 0]) &&
//						array_equals(oBoard.grid[5, 7],[0, 0]) &&
//						array_equals(oBoard.grid[6, 7],[0, 0]) &&
//						!threatenedSquare_scr(4, 7, oBoard.grid, SOUTH, PlayerColor) &&
//						!threatenedSquare_scr(5, 7, oBoard.grid, SOUTH, PlayerColor) &&
//						!threatenedSquare_scr(6, 7, oBoard.grid, SOUTH, PlayerColor) 
//						{
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, false);
//							oBoard.grid[5, 7] = [KING, PlayerColor];
//							oBoard.grid[4, 7] = [ROOK, PlayerColor];
//							oBoard.grid[7, 7] = [0 , 0];
//							SouthCanCastleLeft = false;
//							SouthCanCastleRight = false;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							break;
//						}
//					} 
					
//					if (newX == gridX - 2) && (PlayerColor == BLACK) && (SouthCanCastleLeft)   // Kingside, Black, so to left
//					{
//						if array_equals(oBoard.grid[3, 7],[0, 0]) &&
//						array_equals(oBoard.grid[2, 7],[0, 0]) &&
//						array_equals(oBoard.grid[1, 7],[0, 0]) &&
//						!threatenedSquare_scr(3, 7, oBoard.grid, SOUTH, PlayerColor) &&
//						!threatenedSquare_scr(2, 7, oBoard.grid, SOUTH, PlayerColor) &&
//						!threatenedSquare_scr(1, 7, oBoard.grid, SOUTH, PlayerColor) 
//						{
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
//							oBoard.grid[1, 7] = [KING, PlayerColor];
//							oBoard.grid[2, 7] = [ROOK, PlayerColor];
//							oBoard.grid[0, 7] = [0 , 0];
//							SouthCanCastleLeft = false;
//							SouthCanCastleRight = false;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							break;
//						}
//					}
					
//					break;
//				}
					
//				case ROOK:
//				{
//					if ((newX != gridX) && (newY != gridY))
//					{
//					break;
//					}
//					var rangeX = abs (newX - gridX);
//					var rangeY = abs (newY - gridY);
//					var minX = min(gridX, newX);
//					var minY = min(gridY, newY);
//					if (newX == gridX)
//					{
//						for (var i = 1; i < rangeY; i += 1;)
//						{
//						if array_equals(oBoard.grid[newX, minY + i],[0 , 0])
//							{
//								var clearPath = true;  // unused var for now
//							}
//						else 
//							{					
//							exit;
//							}
//						}
//					}
//					if (newY == gridY)
//					{
//						for (var i = 1; i < rangeX; i += 1;)
//						{
//							if array_equals(oBoard.grid[minX + i, newY],[0 , 0])
//							{
//								var clearPath = true;
//							}
//							else 
//							{
//								exit;
//							}
//						}
//					}
//					proposedState = oBoard.grid;
//					proposedState[newX, newY] = selectedPiece;
//					if PlayerAvoidsCheck_scr(proposedState)
//					{
//						updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
//						oBoard.grid[newX, newY] = selectedPiece;
//						if (gridX == 0) && (gridY == 7) SouthCanCastleLeft = false;
//						if (gridX == 7) && (gridY == 7) SouthCanCastleRight = false;
//						pickedUp = false;
//						selectedPiece = [0 , 0];
//						oGame.state = "AI Turn";
//						break;
//					}
//				}
				
				case PIECE.KNIGHT:
				{
					var range = abs(newIndex - oldIndex);
					if (range == 17 || range == 15 || range == 10) 
					{
						//proposedState = map;
						//proposedState[newIndex] = selectedPiece;
						//if PlayerAvoidsCheck_scr(proposedState)
						{ 
							if map[newIndex] capture = true; 
							// updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							map[newIndex] = selectedPiece;
							pickedUp = false;
							selectedPiece = 0;
							oGame.state = "AI Turn";
							break;
						}
					}
					if range == 6
					{
						var newX = newIndex mod 8;
						var newY = newIndex div 8;
						var oldX = oldIndex mod 8;
						var oldY = oldIndex div 8;
						if ( (abs(oldX - newX) == 2 && abs(oldY - newY) == 1)) ||
							(abs(oldX - newX) == 1 && abs(oldY - newY) == 2)
						{
							if map[newIndex] capture = true; 
							// updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							map[newIndex] = selectedPiece;
							pickedUp = false;
							selectedPiece = 0;
							oGame.state = "AI Turn";
							break;
						}
					}
					break;
				}
				
//				case BISHOP:
//				{
//					if ((abs (newX - gridX)) != (abs (newY - gridY )))
//					{
//						exit;
//					}
					
//					var rangeX = abs (newX - gridX);
//					var rangeY = abs (newY - gridY);
//					var minX = min(gridX, newX);
//					var minY = min(gridY, newY);
//					var maxY = max(gridY, newY);
					
//					// upward sloping, both x and y rising
//					// search from lowest to highest coords
					
//					if  ( ((newX > gridX) && (newY > gridY))
//					|| ((newX < gridX) && (newY < gridY)) )
							
//					{
//						for (var i = 1; i < rangeX; i += 1;)
//						{
//							if array_equals(oBoard.grid[minX + i, minY + i],[0 , 0])
//								{
//								var clearPath = true;  // unused var for now
//								}
//							else 
//							{	
//								clearPath = false;
//								exit;
//							}
//						}
//						proposedState = oBoard.grid;
//						proposedState[newX, newY] = selectedPiece;
//						if PlayerAvoidsCheck_scr(proposedState)
//						{
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);								
//							oBoard.grid[newX, newY] = selectedPiece;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							break;
//						}
//					}
					
//					// now negative slope; again start with small x and add, but sub from max y
					
//					for (var i = 1; i < rangeX; i += 1;)
//						{
//							if array_equals(oBoard.grid[minX + i, maxY - i],[0 , 0])
//								{
//								var clearPath = true;  // unused var for now
//								}
//							else 
//							{	
//								clearPath = false;
//								exit;
//							}
//						}
//						proposedState = oBoard.grid;
//						proposedState[newX, newY] = selectedPiece;
//						if PlayerAvoidsCheck_scr(proposedState)
//						{
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
//							oBoard.grid[newX, newY] = selectedPiece;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							break;
//						}
//				}
				
//				case QUEEN:
//				{
//					var rangeX = abs (newX - gridX);
//					var rangeY = abs (newY - gridY);
//					var minX = min(gridX, newX);
//					var minY = min(gridY, newY);
//					var maxY = max(gridY, newY);
					
//					if (newX == gridX)  // check moving straight up or down
//					{
//						for (var i = 1; i < rangeY; i += 1;)
//						{
//							if array_equals(oBoard.grid[newX, minY + i],[0 , 0])
//							{
//								var clearPath = true;  // unused var for now
//							}
//							else 
//							{					
//								exit;
//							}
//						}
//						proposedState = oBoard.grid;
//						proposedState[newX, newY] = selectedPiece;
//						if PlayerAvoidsCheck_scr(proposedState)
//						{	
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
//							oBoard.grid[newX, newY] = selectedPiece;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							exit;
//						}
//					}
//					else if (newY == gridY)   // check moving horizontally
//					{
//						for (var i = 1; i < rangeX; i += 1;)
//						{
//							if array_equals(oBoard.grid[minX + i, newY],[0 , 0])
//							{
//								var clearPath = true;
//							}
//							else 
//							{
//								exit;
//							}
//						}
//						proposedState = oBoard.grid;
//						proposedState[newX, newY] = selectedPiece;
//						if PlayerAvoidsCheck_scr(proposedState)
//						{
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
//							oBoard.grid[newX, newY] = selectedPiece;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							exit;
//						}
//					}
//// now bishop-like movement, first positive slope:
					
//					else if  ( ((newX > gridX) && (newY > gridY))
//					|| ((newX < gridX) && (newY < gridY)) )
							
//					{
//						for (var i = 1; i < rangeX; i += 1;)
//						{
//							if array_equals(oBoard.grid[minX + i, minY + i],[0 , 0])
//								{
//								var clearPath = true;  // unused var for now
//								}
//							else 
//							{	
//								clearPath = false;
//								exit;
//							}
//						}
//						proposedState = oBoard.grid;
//						proposedState[newX, newY] = selectedPiece;
//						if PlayerAvoidsCheck_scr(proposedState)
//						{
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
//							oBoard.grid[newX, newY] = selectedPiece;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							break;
//						}
//					}
					
//					// now negative slope; again start with small x and add, but sub from max y
//					else
//					{
//					for (var i = 1; i < rangeX; i += 1;)
//						{
//							if array_equals(oBoard.grid[minX + i, maxY - i],[0 , 0])
//								{
//								var clearPath = true;  // unused var for now
//								}
//							else 
//							{	
//								clearPath = false;
//								exit;
//							}
//						}
//						proposedState = oBoard.grid;
//						proposedState[newX, newY] = selectedPiece;
//						if PlayerAvoidsCheck_scr(proposedState)
//						{
//							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
//							oBoard.grid[newX, newY] = selectedPiece;
//							pickedUp = false;
//							selectedPiece = [0 , 0];
//							oGame.state = "AI Turn";
//							break;
//						}
//					}
//				}
//			}
//		}
//	}
	
		
if (pickedUp) && (keyboard_check_pressed(vk_backspace))   // user aborts move
{
	map[oldIndex] = selectedPiece;
	pickedUp = false;
	selectedPiece = 0;
}
			}
		}
}