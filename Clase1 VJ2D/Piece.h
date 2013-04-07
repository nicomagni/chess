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

@interface Piece : NSObject

@property (nonatomic) int color; // 0 = white 1 = black
@property (nonatomic) int position;
@property (nonatomic) Board * board;
@property (nonatomic)  MathUtils * mathUtils;

- (void) printPosition;

- (BOOL) move :(int)toPosition;

- (BOOL)couldMoveToPosition:(int)position;

@end
