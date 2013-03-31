//
//  Pawn.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Pawn.h"

@implementation Pawn

- (void) printPosition{
    NSLog(@"Pawn: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

 BOOL initialPosition(int pos) {
    
    if(pos/8 == 1 ||  pos/8 == 6){
        return YES;
    }
    return NO;
}

- (BOOL) move:(int)toPosition {

    // If pawn is black it should move foward if not backwards
    int pawnDirection = self.color == 1 ? 8 : -8;
    
    if(initialPosition(self.position) &&
       (toPosition == self.position + pawnDirection || toPosition == self.position + (2* pawnDirection))){
        self.position = toPosition;
        return YES;
    }
    return NO;
}


@end
