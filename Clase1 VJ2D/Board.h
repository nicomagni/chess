//
//  Board.h
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/5/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piece.h"

@interface Board : NSObject

@property (nonatomic) NSMutableSet* pieces;


- (Board*) createNewBoard: (Board*) board;

- (void) printBoard;

@end