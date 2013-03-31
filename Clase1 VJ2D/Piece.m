//
//  Piece.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/5/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Piece.h"

@implementation Piece

-(void) printPosition
{
    NSLog(@"%d:%d",(_position/8), (_position%8));
}

- (BOOL) move :(int)toPosition  {
    NSAssert(NO, @"You must implement me!");
    return NO;
}

@end
