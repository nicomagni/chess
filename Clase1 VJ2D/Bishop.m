//
//  Bishop.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Bishop.h"

@implementation Bishop

- (void) printPosition{
    NSLog(@"Bishop: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
    return (self.color == 1 ? @"Black-Bishop" : @"White-Bishop");
}

- (BOOL)couldMoveToPosition:(int)toPosition{
    
    if(toPosition < 0 || toPosition > 63){
        return NO;
    }
    
    int startColumn = [self.mathUtils getColumnIndexForPosition:self.position];
    int startRow = [self.mathUtils getRowIndexForPosition:self.position];
    
    int endColumn = [self.mathUtils getColumnIndexForPosition:toPosition];
    int endRow = [self.mathUtils getRowIndexForPosition:toPosition];
    
    //Creating diagonal point
    for (int i = 0; i < 8; i++) {

    }
    
}


@end
