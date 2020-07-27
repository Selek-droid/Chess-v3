function animate(argument0, argument1, argument2, argument3, argument4) {
	piece = argument0;
	board_object.movingPiece = argument0;
	board_object.oldX = argument1;
	board_object.oldY = argument2;
	board_object.newX = argument3;
	board_object.newY = argument4;

	board_object.spriteX = board_object.x + (SQUARE_SIZE * argument1);
	board_object.spriteY = board_object.y + (SQUARE_SIZE * argument2);
	var newSpriteX = board_object.x + (SQUARE_SIZE * argument3);
	var newSpriteY = board_object.y + (SQUARE_SIZE * argument4);

	board_object.deltaX = newSpriteX - board_object.spriteX;
	board_object.deltaY = newSpriteY - board_object.spriteY;

	if global.HermioneColor == BLACK
	{
		switch (piece[0])
		{
			case PAWN:
			{
				board_object.movingSprite = black_pawn_sprite; 
				if (board_object.newY == 7)	board_object.movingPiece = [QUEEN, BLACK];
				break;
			}
	
			case BISHOP:
			{
				board_object.movingSprite = black_bishop_sprite;
				break;
			}
	
			case KNIGHT:
			{
				board_object.movingSprite = black_knight_sprite;
				break;
			}
	
			case ROOK:
			{
				board_object.movingSprite = black_rook_sprite;
				break;
			}
	
			case QUEEN:
			{
				board_object.movingSprite = black_queen_sprite;
				break;
			}
	
			case KING:
			{
				board_object.movingSprite = black_king_sprite;
			}
		}
	}

	if global.HermioneColor == WHITE
	{
		switch (piece[0])
		{
			case PAWN:
			{
				board_object.movingSprite = white_pawn_sprite; 
				if (board_object.newY == 7)	board_object.movingPiece = [QUEEN, BLACK];
				break;
			}
	
			case BISHOP:
			{
				board_object.movingSprite = white_bishop_sprite;
				break;
			}
	
			case KNIGHT:
			{
				board_object.movingSprite = white_knight_sprite;
				break;
			}
	
			case ROOK:
			{
				board_object.movingSprite = white_rook_sprite;
				break;
			}
	
			case QUEEN:
			{
				board_object.movingSprite = white_queen_sprite;
				break;
			}
	
			case KING:
			{
				board_object.movingSprite = white_king_sprite;
			}
		}
	}

	board_object.animateSprite = true; 
		  


}
