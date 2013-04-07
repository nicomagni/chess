//
//  Tower.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Tower.h"
#import "Board.h"

@implementation Tower

- (void) printPosition{
    NSLog(@"Tower: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (BOOL) move:(int)toPosition{
    if(toPosition < 0 || toPosition > 63){
        return NO;
    }
    
    int actualRow = self.position/8;
    int newRow = toPosition/8;
    int actualCol = self.position%8;
    int newCol = toPosition%8;
    
    if(actualRow == newRow){
        
        if([self isRowEmpty:actualRow from:actualCol to:newCol ]){
            [self.board positions][self.position] = [NSNull null];
            [self.board positions][toPosition] = self;
            self.position = toPosition;
            return YES;
        }
    }else if(actualCol == newCol){

        if([self isColEmpty:actualCol from:actualRow to:newRow ]){
            [self.board positions][self.position] = [NSNull null];
            [self.board positions][toPosition] = self;
            self.position = toPosition;
            return YES;
        }
    }
    return NO;
}

- (NSString*) description{
    return (self.color == 1 ? @"Black-Tower " : @"White-Tower");
}

- (BOOL) isRowEmpty:(int)row from: (int)actualCol to: (int) newCol{
    for(int i = actualCol + 1; i < newCol; ++i){
        if([self.board positions][(row*8)+i] != [NSNull null]){
            return NO;
        }
    }
    return YES;
}

- (BOOL) isColEmpty:(int)col from: (int)actualRow to: (int) newRow{
    for(int i = actualRow + 1; i < newRow; ++i){
        if([self.board positions][(i*8)+col] != [NSNull null]){
            return NO;
        }
    }
    return YES;
}


@end
