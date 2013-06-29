//
//  Piece.h
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/5/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathUtils.h"
@class Board;

@interface Piece : NSObject <NSCoding>

@property (nonatomic) int color; // 1 = white 0 = black
@property (nonatomic) int type; // 0 = Pawn 1 = Knight, 2 = Bishop, 3 = Tower, 4 = Queen, 5 = King 
@property (nonatomic) int position;
@property (nonatomic) NSString *imageResourceName;
@property (nonatomic,weak) Board * board;
@property (nonatomic)  MathUtils * mathUtils;

- (void) printPosition;

- (BOOL) move :(int)toPosition;

- (BOOL) couldMoveToPosition:(int)position checkingCheck:(BOOL) checkCheck;

- (BOOL) validateCheck: (int) color piece: (int) position to: (int) toPosition;

- (NSMutableArray*) canEat;

- (Piece *) copyPiece;

- (id) initWithColor:(int)color;
@end
