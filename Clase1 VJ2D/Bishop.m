//
//  Bishop.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Bishop.h"
#import "Board.h"

@implementation Bishop

- (id) initWithColor:(int)color {
    self = [super init];
    self.color = color;
    if(color == 0){
        self.imageResourceName = @"black_bishop.png";
    }else{
        self.imageResourceName = @"white_bishop.png";
    }
    self.type = kBishop;
    return self;
}

- (void) printPosition{
    NSLog(@"Bishop: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
        return [NSString stringWithFormat:@"Bishop Color = %d position = %d",self.color, self.position];
}

- (Bishop *) copyPiece{
    Bishop * piece = [[Bishop alloc] initWithColor:self.color];
    [piece setPosition:self.position];
    return piece;
}

- (BOOL)move:(int)toPosition
{
    if([self couldMoveToPosition:toPosition checkingCheck:YES]){
        return [super move:toPosition];
    }
    return NO;
}

- (BOOL)couldMoveToPosition:(int)toPosition checkingCheck:(BOOL)checkCheck{
    
    if(![super couldMoveToPosition:toPosition checkingCheck:checkCheck]){
        return NO;
    }
    
    BOOL ans = false;
    ans |= [self lookInBackDiagonalFor:toPosition];
    ans |= [self lookInLeftDiagonalFor:toPosition];
    ans |= [self lookInRightDiagonalFor:toPosition];
    ans |= [self lookInTopDiagonalFor:toPosition];
    
    if(ans){
        if(checkCheck){
            return [super validateCheck:self.color piece: self.position to: toPosition];
        }else{
            return YES;
        }        
    }
    return ans;

}

- (BOOL)lookInTopDiagonalFor:(int)toPosition
{
    //Creating diagonal point
    int currentPosition = self.position;
    int currentColumn = [self.mathUtils getColumnIndexForPosition:currentPosition] + 1;
    int currentRow = [self.mathUtils getRowIndexForPosition:currentPosition] - 1;
    int destinationRow = [self.mathUtils getRowIndexForPosition:toPosition];
    int destinationColum = [self.mathUtils getColumnIndexForPosition:toPosition];
    
    while (currentColumn < 8 && currentRow >= 0) {
        Piece* currentPiece = ((Piece*)[self.board positions][currentRow*8 + currentColumn]);
        if(currentColumn == destinationColum && currentRow == destinationRow){
            return [currentPiece isEqual:[NSNull null]] || currentPiece.color != self.color;
        }else{
            if(![currentPiece isEqual:[NSNull null]]){
                return false;
            }
        }
        currentColumn++;
        currentRow--;
    }
    
    return NO;
}

- (BOOL)lookInBackDiagonalFor:(int)toPosition
{
    int currentPosition = self.position;
    int currentColumn = [self.mathUtils getColumnIndexForPosition:currentPosition] - 1;
    int currentRow = [self.mathUtils getRowIndexForPosition:currentPosition] + 1;
    int destinationRow = [self.mathUtils getRowIndexForPosition:toPosition];
    int destinationColum = [self.mathUtils getColumnIndexForPosition:toPosition];
    
    while (currentColumn >= 0 && currentRow < 8) {
        Piece* currentPiece = ((Piece*)[self.board positions][currentRow*8 + currentColumn]);
        if(currentColumn == destinationColum && currentRow == destinationRow){
            return [currentPiece isEqual:[NSNull null]] || currentPiece.color != self.color;
        }else{
            if(![currentPiece isEqual:[NSNull null]]){
                return false;
            }
        }
        currentColumn--;
        currentRow++;
    }
    
    return NO;
}

- (BOOL)lookInRightDiagonalFor:(int)toPosition
{
    int currentPosition = self.position;
    int currentColumn = [self.mathUtils getColumnIndexForPosition:currentPosition] + 1;
    int currentRow = [self.mathUtils getRowIndexForPosition:currentPosition] + 1;
    int destinationRow = [self.mathUtils getRowIndexForPosition:toPosition];
    int destinationColum = [self.mathUtils getColumnIndexForPosition:toPosition];
    
    while (currentColumn < 8 && currentRow < 8) {
        Piece* currentPiece = ((Piece*)[self.board positions][currentRow*8 + currentColumn]);
        if(currentColumn == destinationColum && currentRow == destinationRow){
            return [currentPiece isEqual:[NSNull null]] || currentPiece.color != self.color;
        }else{
            if(![currentPiece isEqual:[NSNull null]]){
                return false;
            }
        }
        currentColumn++;
        currentRow++;
    }
    
    return NO;
}

- (BOOL)lookInLeftDiagonalFor:(int)toPosition
{
    int currentPosition = self.position;
    int currentColumn = [self.mathUtils getColumnIndexForPosition:currentPosition] - 1;
    int currentRow = [self.mathUtils getRowIndexForPosition:currentPosition] - 1;
    int destinationRow = [self.mathUtils getRowIndexForPosition:toPosition];
    int destinationColum = [self.mathUtils getColumnIndexForPosition:toPosition];
    
    while (currentColumn >= 0 && currentRow >= 0) {
        Piece* currentPiece = ((Piece*)[self.board positions][currentRow*8 + currentColumn]);
        if(currentColumn == destinationColum && currentRow == destinationRow){
            return [currentPiece isEqual:[NSNull null]] || currentPiece.color != self.color;
        }else{
            if(![currentPiece isEqual:[NSNull null]]){
                return false;
            }
        }
        currentColumn--;
        currentRow--;
    }
    
    return NO;}

- (NSMutableArray *) canEat{
    NSMutableArray * positions = [[NSMutableArray alloc] init];
    for (int i = 1;i < 7; ++i) {
        int pos = (self.position - 7 * i);
        if(pos>0){
            if([self couldMoveToPosition:pos  checkingCheck:NO]){
                [positions addObject:[NSNumber numberWithInt:pos]];
            }
        }
        pos = (self.position - 9 * i);
        if(pos>0){
            if([self couldMoveToPosition:pos  checkingCheck:NO]){
                [positions addObject:[NSNumber numberWithInt:pos]];
            }
        }
        pos = (self.position +7 * i);
        if(pos< 63){
            if([self couldMoveToPosition:pos  checkingCheck:NO]){
                [positions addObject:[NSNumber numberWithInt:pos]];
            }
        }
        pos = (self.position +9 * i);
        if(pos< 63){
            if([self couldMoveToPosition:pos  checkingCheck:NO]){
                [positions addObject:[NSNumber numberWithInt:pos]];
            }
        }
    }
    NSLog(@"%@ can eat: %@",self,positions);
    return positions;
}

@end
