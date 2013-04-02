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

- (Board*) createNewBoard;

- (void) printBoard;

@end