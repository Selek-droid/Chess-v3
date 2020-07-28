function animate(argument0, argument1, argument2, argument3, argument4) {
	piece = argument0;
	oBoard.movingPiece = argument0;
	oBoard.oldX = argument1;
	oBoard.oldY = argument2;
	oBoard.newX = argument3;
	oBoard.newY = argument4;

	oBoard.spriteX = oBoard.x + (SQUARE_SIZE * argument1);
	oBoard.spriteY = oBoard.y + (SQUARE_SIZE * argument2);
	var newSpriteX = oBoard.x + (SQUARE_SIZE * argument3);
	var newSpriteY = oBoard.y + (SQUARE_SIZE * argument4);

	oBoard.deltaX = newSpriteX - oBoard.spriteX;
	oBoard.deltaY = newSpriteY - oBoard.spriteY;

	if global.HermioneColor == BLACK
	{
		switch (piece[0])
		{
			case PAWN:
			{
				oBoard.movingSprite = black_pawn_sprite; 
				if (oBoard.newY == 7)	oBoard.movingPiece = [QUEEN, BLACK];
				break;
			}
	
			case BISHOP:
			{
				oBoard.movingSprite = black_bishop_sprite;
				break;
			}
	
			case KNIGHT:
			{
				oBoard.movingSprite = black_knight_sprite;
				break;
			}
	
			case ROOK:
			{
				oBoard.movingSprite = black_rook_sprite;
				break;
			}
	
			case QUEEN:
			{
				oBoard.movingSprite = black_queen_sprite;
				break;
			}
	
			case KING:
			{
				oBoard.movingSprite = black_king_sprite;
			}
		}
	}

	if global.HermioneColor == WHITE
	{
		switch (piece[0])
		{
			case PAWN:
			{
				oBoard.movingSprite = white_pawn_sprite; 
				if (oBoard.newY == 7)	oBoard.movingPiece = [QUEEN, BLACK];
				break;
			}
	
			case BISHOP:
			{
				oBoard.movingSprite = white_bishop_sprite;
				break;
			}
	
			case KNIGHT:
			{
				oBoard.movingSprite = white_knight_sprite;
				break;
			}
	
			case ROOK:
			{
				oBoard.movingSprite = white_rook_sprite;
				break;
			}
	
			case QUEEN:
			{
				oBoard.movingSprite = white_queen_sprite;
				break;
			}
	
			case KING:
			{
				oBoard.movingSprite = white_king_sprite;
			}
		}
	}

	oBoard.animateSprite = true; 
		  


}
