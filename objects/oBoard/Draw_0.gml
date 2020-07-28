draw_self();

if (animateSprite) 
{
	if ! (spriteInMotion)
	{
		grid[oldX][oldY] = [0, 0];
		spriteInMotion = true;
	}
	draw_sprite(movingSprite,-1,(spriteX + ((loc * deltaX)/ 20)),(spriteY + ((loc * deltaY)/ 20)));
	loc += 1;
	if (loc > 19) 
	{		
		oBoard.map[newX][newY] = movingPiece;   // Sicilian defense		
		animateSprite = false;
		spriteInMotion = false;
		loc = 0;
	}	 
}

var xx = 0;

for (xx = 0; xx <= 63; xx += 1;)
{
	var drawnPiece = oBoard.map[xx];
	switch drawnPiece
	{
		case WhitePawn:
		{
			draw_sprite(white_pawn_sprite, -1, 
			floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
			floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case WhiteRook:
		{
			draw_sprite(white_rook_sprite, -1, 
			floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
			floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case WhiteKnight:
		{
			draw_sprite(white_knight_sprite, -1, 
				floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
				floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case WhiteBishop:
		{
			draw_sprite(white_bishop_sprite, -1, 
				floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
				floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case WhiteKing:
		{
			draw_sprite(white_king_sprite, -1, 
				floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
				floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case WhiteQueen:
		{
			draw_sprite(white_queen_sprite, -1, 
				floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
				floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case BlackPawn:
		{
			draw_sprite(black_pawn_sprite, -1, 
				floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
				floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case BlackRook:
		{
			draw_sprite(black_rook_sprite, -1, 
				floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
				floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case BlackKnight:
		{
			draw_sprite(black_knight_sprite, -1, 
				floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
				floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case BlackBishop:
		{
			draw_sprite(black_bishop_sprite, -1, 
				floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
				floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case BlackKing:
		{
			draw_sprite(black_king_sprite, -1, 
				floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
				floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
		
		case BlackQueen:
		{
			draw_sprite(black_queen_sprite, -1, 
				floor(x + ( (xx mod 8 ) * SQUARE_SIZE)), 
				floor(y + ( (xx div 8 ) * SQUARE_SIZE)));
			break;
		}
	}
}