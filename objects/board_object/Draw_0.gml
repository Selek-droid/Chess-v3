draw_self();

if (animateSprite) 
{
	if ! (spriteInMotion)
	{
		grid[oldX, oldY] = [0, 0];
		spriteInMotion = true;
	}
	draw_sprite(movingSprite,-1,(spriteX + ((loc * deltaX)/ 20)),(spriteY + ((loc * deltaY)/ 20)));
	loc += 1;
	if (loc > 19) 
	{		
		board_object.grid[newX, newY] = movingPiece;   // Sicilian defense		
		animateSprite = false;
		spriteInMotion = false;
		loc = 0;
	}	 
}

// ===============================================================
// Failed animation code. Try again later?
//if (displayCastling) 
//{
//	if ! (spriteInMotion) && ! (kingDoneCastling)  // first king poofs
//	{
//		board_object.grid[oldX, oldY] = [0, 0];  // call this only once
//		spriteInMotion = true;
//	}
//	if ! (kingDoneCastling)
//	{	
//		draw_sprite(black_king_sprite,-1,(spriteX + ((loc * deltaX)/ 20)),0);
//		loc += 1;
//		if (loc > 19) 
//		{		
//			board_object.grid[newX, 0] = [KING, BLACK];   		
//			animateSprite = false;
//			spriteInMotion = false;
//			kingDoneCastling = true;
//			loc = 0;
//		}	
//	}

//	if ! (spriteInMotion) && (kingDoneCastling)
//	{
//		if (deltaX > 0)  // rook is on right side; it poofs
//		{
//			board_object.grid[7, 0] = [0, 0];
//			spriteInMotion = true;
//		}
//		else
//		{
//			board_object.grid[0, 0] = [0, 0];  // rook on left
//			spriteInMotion = true;
//		}
		
//	}  // Now draw rook repeatedly
	
//	if (spriteInMotion) && (kingDoneCastling)
//	{
//		draw_sprite(black_rook_sprite,-1,((spriteX + (loc * ((0 - deltaX)/ 20)))), 0);
//		loc += 1;
//		if (loc > 19) 
//		{	
//			if (deltaX > 0)  // rook is on right side; it moves left
//			{
//				board_object.grid[5, 0] = [ROOK, BLACK];
//			}
//			else
//			{
//				board_object.grid[3, 0] = [ROOK, BLACK];  // rook on left, moves right
//			}
		 		
//			animateSprite = false;
//			spriteInMotion = false;
//			kingDoneCastling = true;
//			displayCastling = false;
//			loc = 0;
//		}
//	}	
//}
// ---------------------------------------------------

var xx;
var yy;

for (xx = 0; xx <= 7; xx += 1;)
{
	for (yy = 0; yy <= 7; yy += 1;)

	{
		if array_equals( board_object.grid[xx, yy] , [KNIGHT, WHITE] )
		{
			draw_sprite(white_knight_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( board_object.grid[xx, yy] , [BISHOP, WHITE] )
		{
			draw_sprite(white_bishop_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( board_object.grid[xx, yy] , [ROOK, WHITE] )
		{
			draw_sprite(white_rook_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( board_object.grid[xx, yy] , [QUEEN, WHITE] )
		{
			draw_sprite(white_queen_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( board_object.grid[xx, yy] , [KING, WHITE] )
		{
			draw_sprite(white_king_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( board_object.grid[xx, yy] , [PAWN, WHITE] )
		{
			draw_sprite(white_pawn_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
				
		if array_equals( board_object.grid[xx, yy] , [KNIGHT, BLACK] )
		{
			draw_sprite(black_knight_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( board_object.grid[xx, yy] , [PAWN, BLACK] )
		{
			draw_sprite(black_pawn_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( board_object.grid[xx, yy] , [QUEEN, BLACK] )
		{
			draw_sprite(black_queen_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( board_object.grid[xx, yy] , [BISHOP, BLACK] )
		{
			draw_sprite(black_bishop_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( board_object.grid[xx, yy] , [ROOK, BLACK] )
		{
			draw_sprite(black_rook_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
		
		if array_equals( board_object.grid[xx, yy] , [KING, BLACK] )
		{
			draw_sprite(black_king_sprite, -1, 
				floor(x + (xx * SQUARE_SIZE)), 
				floor(y + (yy * SQUARE_SIZE)));
		}
	
	}
}

if ! (array_equals(selectedPiece, [0 , 0]) )
{
	if array_equals( selectedPiece , [PAWN, WHITE]) 
		draw_sprite(white_pawn_sprite,-1,mouse_x - 32, mouse_y - 32);
				
	else if array_equals( selectedPiece , [ROOK, WHITE]) 
		draw_sprite(white_rook_sprite,-1,mouse_x - 32, mouse_y - 32);
		 		
	else if array_equals( selectedPiece , [KNIGHT, WHITE]) 
		draw_sprite(white_knight_sprite,-1,mouse_x - 32, mouse_y - 32);
				
	else if array_equals( selectedPiece , [BISHOP, WHITE]) 
		draw_sprite(white_bishop_sprite,-1,mouse_x - 32, mouse_y - 32);
				
	else if array_equals( selectedPiece , [QUEEN, WHITE]) 
		draw_sprite(white_queen_sprite,-1,mouse_x - 32, mouse_y - 32);
				
	else if array_equals( selectedPiece , [KING, WHITE]) 
		draw_sprite(white_king_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [PAWN, BLACK]) 
		draw_sprite(black_pawn_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [ROOK, BLACK]) 
		draw_sprite(black_rook_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [KNIGHT, BLACK]) 
		draw_sprite(black_knight_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [BISHOP, BLACK]) 
		draw_sprite(black_bishop_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [QUEEN, BLACK]) 
		draw_sprite(black_queen_sprite,-1,mouse_x - 32, mouse_y - 32);
		
	else if array_equals( selectedPiece , [KING, BLACK]) 
		draw_sprite(black_king_sprite,-1,mouse_x - 32, mouse_y - 32);
}
