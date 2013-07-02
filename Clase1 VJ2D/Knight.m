//
//  Knight.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Knight.h"
#import "Board.h"

@implementation Knight

- (id) initWithColor:(int)color {
    self = [super init];
    self.color = color;
    if(color == 0){
        self.imageResourceName = @"black_hourse.png";
    }else{
        self.imageResourceName = @"white_hourse.png";
    }
    self.type = kKnight;
    return self;
}

- (void) printPosition{
    NSLog(@"Knight: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (BOOL)move:(int)toPosition
{
    if([self couldMoveToPosition:toPosition checkingCheck:YES]){
        return [super move:toPosition];
    }
    return NO;
}

- (NSString*) description{
        return [NSString stringWithFormat:@"Knight Color = %d position = %d",self.color, self.position];
}

- (Knight *) copyPiece{
    Knight * piece = [[Knight alloc] initWithColor:self.color];
    [piece setPosition:self.position];
    return piece;
}

- (BOOL)couldMoveToPosition:(int)toPosition checkingCheck:(BOOL)checkCheck{
    
    if(![super couldMoveToPosition:toPosition checkingCheck:checkCheck]){
        return NO;
    }
    
    int startColumn = [self.mathUtils getColumnIndexForPosition:self.position];
    int startRow = [self.mathUtils getRowIndexForPosition:self.position];
    
    int endColumn = [self.mathUtils getColumnIndexForPosition:toPosition];
    int endRow = [self.mathUtils getRowIndexForPosition:toPosition];
    //TOP LEFT
    if (startColumn - 1 >= 0 && startRow - 2 >= 0) {
        NSLog(@"TOP LEFT Start point( %d, %d ) end Point ( %d, %d)",startRow,startColumn,endRow,endColumn);
        if (startColumn - 1 == endColumn && startRow - 2 == endRow) {
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }
    //TOP RIGHT
    if(startColumn + 1 <= 7 && startRow - 2 >= 0){
        NSLog(@"TOP RIGHT Start point( %d, %d ) end Point ( %d, %d)",startRow,startColumn,endRow,endColumn);
        if(startColumn + 1 == endColumn && startRow - 2 == endRow){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }
    //Right TOP
    if(startColumn + 2 <= 7 && startRow - 1 >= 0){
        NSLog(@"RIGHT TOP Start point( %d, %d ) end Point ( %d, %d)",startRow,startColumn,endRow,endColumn);
        if(startColumn + 2 == endColumn && startRow - 1 == endRow){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }
    //Right BOTTOM
    if(startColumn + 2 <= 7 && startRow + 1 <= 7){
        NSLog(@"BOTTOM RIGHT Start point( %d, %d ) end Point ( %d, %d)",startRow,startColumn,endRow,endColumn);
        if(startColumn + 2 == endColumn && startRow + 1 == endRow){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }
    //BOTTOM RIGHT
    if (startColumn - 1 >= 0 && startRow + 2 <= 7) {
        NSLog(@"BOTTOM RIGHT Start point( %d, %d ) end Point ( %d, %d)",startRow,startColumn,endRow,endColumn);
        if(startColumn - 1 == endColumn && startRow + 2 == endRow){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }
    //BOTTOM LEFT
    if(startColumn + 1 <= 7 && startRow + 2 <= 7){
        NSLog(@"BOTTOM LEFT Start point( %d, %d ) end Point ( %d, %d)",startRow,startColumn,endRow,endColumn);
        if(startColumn + 1 == endColumn && startRow + 2 == endRow){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }
    //LEFT BOTTOM
    if(startColumn - 2 >= 0 && startRow - 1 >= 0){
        NSLog(@"LEFT BOTTOM Start point( %d, %d ) end Point ( %d, %d)",startRow,startColumn,endRow,endColumn);
        if(startColumn - 2 == endColumn && startRow - 1 == endRow){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }
    //LEFT TOP
    if(startColumn - 2 >= 0 && startRow + 1 <= 7){
        NSLog(@"LEFT TOP Start point( %d, %d ) end Point ( %d, %d)",startRow,startColumn,endRow,endColumn);
        if(startColumn - 2 == endColumn && startRow + 1 == endRow){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }
    
    return NO;
    
}

- (NSMutableArray *) canEat{
    NSMutableArray * positions = [[NSMutableArray alloc] init];
    if([self couldMoveToPosition:(self.position -6)  checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position -6)]];
    }
    if([self couldMoveToPosition:(self.position -10)  checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position -10)]];
    }
    if([self couldMoveToPosition:(self.position -15)  checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position -15)]];
    }
    if([self couldMoveToPosition:(self.position -17)  checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position -17)]];
    }
    if([self couldMoveToPosition:(self.position +6)  checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position +6)]];
    }
    if([self couldMoveToPosition:(self.position +10)  checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position +10)]];
    }
    if([self couldMoveToPosition:(self.position +15)  checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position +15)]];
    }
    if([self couldMoveToPosition:(self.position +17)  checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position +17)]];
    }
    return positions;
}

@end
