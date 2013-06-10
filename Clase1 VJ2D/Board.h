//
//  Board.h
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/5/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Piece;

@interface Board : NSObject

@property (nonatomic) NSMutableSet* pieces;
@property (nonatomic) NSMutableArray *positions;
@property (nonatomic) int check;        // 0 no, 1 black, 2 white
@property (nonatomic) int checkmate;    // 0 no, 1 black, 2 white


- (Board*) createNewBoardMyColoris:(int)myColor;

- (void) printBoard;

- (NSMutableArray*) getBoardArray;

- (Board *) copyBoard;

- (BOOL) lookForChecks: (int) color;
- (id) initWithArray:(NSArray*)boardArray;
- (void) rotateBoard;

@end