//
//  Tower.h
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Piece.h"

@interface Tower : Piece

@property (nonatomic) BOOL everMoved;


- (BOOL) isRowEmpty:(int)row from: (int)actualCol to: (int) newCol;
- (BOOL) isColEmpty:(int)col from: (int)actualRow to: (int) newRow;

@end
