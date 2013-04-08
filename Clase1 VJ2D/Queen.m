//
//  Queen.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Queen.h"

@implementation Queen

- (id) initWithColor:(int)color {
    self = [super init];
    self.color = color;
    if(color == 1){
        self.imageResourceName = @"black_queen.png";
    }else{
        self.imageResourceName = @"white_queen.png";
    }
    return self;
}

- (void) printPosition{
    NSLog(@"Queen: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
    return (self.color == 1 ? @"Black-Queen " : @"White-Queen");
}

- (BOOL)move:(int)toPosition
{
    if([self couldMoveToPosition:toPosition]){
        [super move:toPosition];
    }
}

- (BOOL)couldMoveToPosition:(int)toPosition{
    
    if(toPosition < 0 || toPosition > 63){
        return NO;
    }
    
    int startColumn = [self.mathUtils getColumnIndexForPosition:self.position];
    int startRow = [self.mathUtils getRowIndexForPosition:self.position];
    
    int endColumn = [self.mathUtils getColumnIndexForPosition:toPosition];
    int endRow = [self.mathUtils getRowIndexForPosition:toPosition];
    
    //This wolud be the same logic than the Tower || bishop
    return NO;
    
}


@end
