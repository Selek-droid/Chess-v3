switch (oGame.state)
{
	case ("AI Turn"):
	{
		AIscript();
		break;
	}
	
	case ("Player Turn"):
		break;
	
	case ("Initializing"):
	{
		if (global.HermioneColor == WHITE)
		{
		oGame.state = "AI Turn";
		exit;
		}
		else oGame.state = "Player Turn";
	}
}

if keyboard_check_pressed(vk_escape) game_end();

var newX = 0;
var newY = 0;
var targetID = [0 , 0];
var pieceType;
// var kingPosition;
var proposedState;
var capture = false;
var HermioneColor = global.HermioneColor;
var PlayerColor = WHITE;

if (HermioneColor == WHITE) PlayerColor = BLACK;

if (!pickedUp) && (mouse_check_button_released(mb_left))  // pickup
{
	if (mouse_x >= x) && (mouse_x <= x + BOARD_WIDTH)
		&& (mouse_y >= y) && (mouse_y <= y + BOARD_HEIGHT)
	{
		gridX = floor( ( mouse_x - x ) / SQUARE_SIZE );
		gridY = floor( ( mouse_y - y ) / SQUARE_SIZE );
		mouse_clear(mb_left);
//		if (board_object.grid[gridX, gridY] != 0)  // THURSDAY ATTEMPTED FIX BELOW
		if ! ( array_equals(board_object.grid[gridX, gridY], [0 , 0]) )
		{
			selectedPiece = board_object.grid[gridX, gridY];
			board_object.grid[gridX, gridY] = [0 , 0];   // clear vacated square
			pickedUp = true;
	//		alarm[0] = room_speed / 5;  // alarm sets pickedUp to true
//			mouse_clear(mb_left); // NEW TRY
			
		}
	}
}

if (pickedUp) && (mouse_check_button_released(mb_left))  // destination clicked
	{	newX = floor( ( mouse_x - x ) / SQUARE_SIZE );  // check if empty or enemy
		newY = floor( ( mouse_y - y ) / SQUARE_SIZE );  // ... and if piece capable...
		mouse_clear(mb_left);
		if (newX < 0) || (newX > 7) || (newY < 0) || (newY > 7)
		{
//			mouse_clear(mb_left);
			exit;
		}
		
		targetID = board_object.grid[newX, newY];
		
		if array_equals([newX, newY],[gridX, gridY])  // check whether dest = origin.
		{
			board_object.grid[newX, newY] = selectedPiece; // maybe CHANGE THIS CODE.  BUG???
			pickedUp = false;
			selectedPiece = [0 , 0]
			turnOver = false;   // Eventually this variable will change state to AI.
			oGame.state = "Player Turn";
//			mouse_clear(mb_left);
		}
			
			
		if (targetID[1] == HermioneColor) || (array_equals(board_object.grid[newX, newY],[0, 0]))
		{
			pieceType = selectedPiece[0];
			switch (pieceType) 
			{
				case PAWN: 
				{
					if ( (targetID[1] == HermioneColor) && ((abs (newX - gridX)) == 1 ) // captures
						&& (gridY - newY == 1) ) 
					{
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{
							board_object.grid[newX, newY] = selectedPiece;
							capture = true;
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							if (newY == 0) board_object.grid[newX, newY] = [QUEEN, PlayerColor];  // code user choice later
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					}	
					else if ((gridY - newY == 1) && (gridX == newX)) 
						&& (array_equals(board_object.grid[newX, newY],[0, 0]))  // one-square moves forward
					{
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{
							board_object.grid[newX, newY] = selectedPiece;
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							if (newY == 0) board_object.grid[newX, newY] = [QUEEN, PlayerColor];  // code user choice later
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						} 
					}
										
					else if ( (gridY == 6) && (gridY - newY == 2) && (gridX == newX) 
						&& (array_equals(board_object.grid[newX, newY],[0, 0]))
						&& (array_equals(board_object.grid[gridX, gridY - 1],[0 , 0]) ) )
					{
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							board_object.grid[newX, newY] = selectedPiece;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					}
					
					break;
				}
					
				case KING:
				{
					if  ((abs (newX - gridX) <= 1) && (abs (newY - gridY) <= 1))  // not castling
					{
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							board_object.grid[newX, newY] = selectedPiece;
							SouthCanCastleLeft = false;
							SouthCanCastleRight = false;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					}
// Castling code. White castling first:

					if  (newX == gridX + 2) && (PlayerColor == WHITE) && (SouthCanCastleRight) // kingside castle, to right, as white.
					{
						if array_equals(board_object.grid[5, 7],[0, 0]) &&
						array_equals(board_object.grid[6, 7],[0, 0]) &&
						!threatenedSquare_scr(4, 7, board_object.grid, SOUTH, PlayerColor) &&
						!threatenedSquare_scr(5, 7, board_object.grid, SOUTH, PlayerColor) &&
						!threatenedSquare_scr(6, 7, board_object.grid, SOUTH, PlayerColor) 
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, false);
							board_object.grid[6, 7] = [KING, PlayerColor];
							board_object.grid[5, 7] = [ROOK, PlayerColor];
							board_object.grid[7, 7] = [0 , 0];
							SouthCanCastleLeft = false;
							SouthCanCastleRight = false;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					} 
					
					if (newX == gridX - 2) && (PlayerColor == WHITE) && (SouthCanCastleLeft)  // Queenside, to left, as white
					{
						if array_equals(board_object.grid[3, 7],[0, 0]) &&
						array_equals(board_object.grid[2, 7],[0, 0]) &&
						array_equals(board_object.grid[1, 7],[0, 0]) &&
						!threatenedSquare_scr(4, 7, board_object.grid, SOUTH, PlayerColor) &&
						!threatenedSquare_scr(3, 7, board_object.grid, SOUTH, PlayerColor) &&
						!threatenedSquare_scr(2, 7, board_object.grid, SOUTH, PlayerColor) 
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							board_object.grid[2, 7] = [KING, PlayerColor];
							board_object.grid[3, 7] = [ROOK, PlayerColor];
							board_object.grid[0, 7] = [0 , 0];
							SouthCanCastleLeft = false;
							SouthCanCastleRight = false;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					}
					
					if  (newX == gridX + 2) && (PlayerColor == BLACK) && (SouthCanCastleRight)   // Queenside black castle, to right.
					{
						if array_equals(board_object.grid[4, 7],[0, 0]) &&
						array_equals(board_object.grid[5, 7],[0, 0]) &&
						array_equals(board_object.grid[6, 7],[0, 0]) &&
						!threatenedSquare_scr(4, 7, board_object.grid, SOUTH, PlayerColor) &&
						!threatenedSquare_scr(5, 7, board_object.grid, SOUTH, PlayerColor) &&
						!threatenedSquare_scr(6, 7, board_object.grid, SOUTH, PlayerColor) 
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, false);
							board_object.grid[5, 7] = [KING, PlayerColor];
							board_object.grid[4, 7] = [ROOK, PlayerColor];
							board_object.grid[7, 7] = [0 , 0];
							SouthCanCastleLeft = false;
							SouthCanCastleRight = false;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					} 
					
					if (newX == gridX - 2) && (PlayerColor == BLACK) && (SouthCanCastleLeft)   // Kingside, Black, so to left
					{
						if array_equals(board_object.grid[3, 7],[0, 0]) &&
						array_equals(board_object.grid[2, 7],[0, 0]) &&
						array_equals(board_object.grid[1, 7],[0, 0]) &&
						!threatenedSquare_scr(3, 7, board_object.grid, SOUTH, PlayerColor) &&
						!threatenedSquare_scr(2, 7, board_object.grid, SOUTH, PlayerColor) &&
						!threatenedSquare_scr(1, 7, board_object.grid, SOUTH, PlayerColor) 
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							board_object.grid[1, 7] = [KING, PlayerColor];
							board_object.grid[2, 7] = [ROOK, PlayerColor];
							board_object.grid[0, 7] = [0 , 0];
							SouthCanCastleLeft = false;
							SouthCanCastleRight = false;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					}
					
					break;
				}
					
				case ROOK:
				{
					if ((newX != gridX) && (newY != gridY))
					{
					break;
					}
					var rangeX = abs (newX - gridX);
					var rangeY = abs (newY - gridY);
					var minX = min(gridX, newX);
					var minY = min(gridY, newY);
					if (newX == gridX)
					{
						for (var i = 1; i < rangeY; i += 1;)
						{
						if array_equals(board_object.grid[newX, minY + i],[0 , 0])
							{
								var clearPath = true;  // unused var for now
							}
						else 
							{					
							exit;
							}
						}
					}
					if (newY == gridY)
					{
						for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(board_object.grid[minX + i, newY],[0 , 0])
							{
								var clearPath = true;
							}
							else 
							{
								exit;
							}
						}
					}
					proposedState = board_object.grid;
					proposedState[newX, newY] = selectedPiece;
					if PlayerAvoidsCheck_scr(proposedState)
					{
						updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
						board_object.grid[newX, newY] = selectedPiece;
						if (gridX == 0) && (gridY == 7) SouthCanCastleLeft = false;
						if (gridX == 7) && (gridY == 7) SouthCanCastleRight = false;
						pickedUp = false;
						selectedPiece = [0 , 0];
						oGame.state = "AI Turn";
						break;
					}
				}
				
				case KNIGHT:
				{
					if (((abs (newX - gridX)) == 1) && ((abs (newY - gridY)) == 2))
					|| (((abs (newX - gridX)) == 2) && ((abs (newY - gridY)) == 1)) 
					{
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{ 
							if !(array_equals(board_object.grid[newX, newY], [0, 0])) capture = true; 
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							board_object.grid[newX, newY] = selectedPiece;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					}
					break;
				}
				
				case BISHOP:
				{
					if ((abs (newX - gridX)) != (abs (newY - gridY )))
					{
						exit;
					}
					
					var rangeX = abs (newX - gridX);
					var rangeY = abs (newY - gridY);
					var minX = min(gridX, newX);
					var minY = min(gridY, newY);
					var maxY = max(gridY, newY);
					
					// upward sloping, both x and y rising
					// search from lowest to highest coords
					
					if  ( ((newX > gridX) && (newY > gridY))
					|| ((newX < gridX) && (newY < gridY)) )
							
					{
						for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(board_object.grid[minX + i, minY + i],[0 , 0])
								{
								var clearPath = true;  // unused var for now
								}
							else 
							{	
								clearPath = false;
								exit;
							}
						}
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);								
							board_object.grid[newX, newY] = selectedPiece;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					}
					
					// now negative slope; again start with small x and add, but sub from max y
					
					for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(board_object.grid[minX + i, maxY - i],[0 , 0])
								{
								var clearPath = true;  // unused var for now
								}
							else 
							{	
								clearPath = false;
								exit;
							}
						}
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							board_object.grid[newX, newY] = selectedPiece;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
				}
				
				case QUEEN:
				{
					var rangeX = abs (newX - gridX);
					var rangeY = abs (newY - gridY);
					var minX = min(gridX, newX);
					var minY = min(gridY, newY);
					var maxY = max(gridY, newY);
					
					if (newX == gridX)  // check moving straight up or down
					{
						for (var i = 1; i < rangeY; i += 1;)
						{
							if array_equals(board_object.grid[newX, minY + i],[0 , 0])
							{
								var clearPath = true;  // unused var for now
							}
							else 
							{					
								exit;
							}
						}
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{	
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							board_object.grid[newX, newY] = selectedPiece;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							exit;
						}
					}
					else if (newY == gridY)   // check moving horizontally
					{
						for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(board_object.grid[minX + i, newY],[0 , 0])
							{
								var clearPath = true;
							}
							else 
							{
								exit;
							}
						}
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							board_object.grid[newX, newY] = selectedPiece;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							exit;
						}
					}
// now bishop-like movement, first positive slope:
					
					else if  ( ((newX > gridX) && (newY > gridY))
					|| ((newX < gridX) && (newY < gridY)) )
							
					{
						for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(board_object.grid[minX + i, minY + i],[0 , 0])
								{
								var clearPath = true;  // unused var for now
								}
							else 
							{	
								clearPath = false;
								exit;
							}
						}
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							board_object.grid[newX, newY] = selectedPiece;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					}
					
					// now negative slope; again start with small x and add, but sub from max y
					else
					{
					for (var i = 1; i < rangeX; i += 1;)
						{
							if array_equals(board_object.grid[minX + i, maxY - i],[0 , 0])
								{
								var clearPath = true;  // unused var for now
								}
							else 
							{	
								clearPath = false;
								exit;
							}
						}
						proposedState = board_object.grid;
						proposedState[newX, newY] = selectedPiece;
						if PlayerAvoidsCheck_scr(proposedState)
						{
							updateHistory_scr(selectedPiece, gridX, gridY, newX, newY, capture);
							board_object.grid[newX, newY] = selectedPiece;
							pickedUp = false;
							selectedPiece = [0 , 0];
							oGame.state = "AI Turn";
							break;
						}
					}
				}
			}
		}
	}
	
		
if (pickedUp) && (keyboard_check_pressed(vk_backspace))   // user aborts move
{
	board_object.grid[gridX, gridY] = selectedPiece;
	pickedUp = false;
	selectedPiece = [0, 0];
}
	