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

- (id) initWithColor:(int)color {
    self = [super init];
    if(color == 1){
            self.color = color;
        self.imageResourceName = @"black_tower.png";
    }else{
        self.imageResourceName = @"white_tower.png";
    }
    self.type = 3;
    return self;
}

- (void) printPosition{
    NSLog(@"Tower: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (BOOL) move:(int)toPosition{
    
    if([self couldMoveToPosition:toPosition checkingCheck:YES]){
        return [super move:toPosition];
    }
    return NO;
}

- (BOOL) couldMoveToPosition:(int)toPosition checkingCheck:(BOOL)checkCheck{
    
    if(![super couldMoveToPosition:toPosition checkingCheck:checkCheck]){
        return NO;
    }
    
    int actualRow = [self.mathUtils getRowIndexForPosition:self.position];
    int newRow = [self.mathUtils getRowIndexForPosition:toPosition];
    int actualCol = [self.mathUtils getColumnIndexForPosition:self.position];
    int newCol =  [self.mathUtils getColumnIndexForPosition:toPosition];
    
    NSLog(@" acltal row %d new row %d actual column %d new columns %d", actualRow, newRow , actualCol, newCol);
    
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

- (Tower *) copyPiece{
    Tower * piece = [[Tower alloc] initWithColor:self.color];
    [piece setPosition:self.position];
    return piece;
}

- (NSMutableArray *) canEat:(Board *)board{
    NSMutableArray * positions = [[NSMutableArray alloc] init];
    [self addPositionsFromRowTo: positions at: self.position/8];
    [self addPositionsFromColTo: positions at: self.position%8];
    return positions;
}

- (void) addPositionsFromRowTo: (NSMutableArray*) positions at:(int) position{
    for(int i = position + 1; i < 8 ; ++i){
        if([[self.board positions][(position*8)+i] isEqual:[NSNull null]]){
            [positions addObject:[NSNumber numberWithInt:i]];
        }else if(((Tower*)([self.board positions][(position*8)+i])).color != 2){
            //Oposite Pice found, could be eaten and position should be added. No more positions to look in row
            i = 8;
            [positions addObject:[NSNumber numberWithInt:i]];
        }else{
            //My Pice found, no more positions to look
            i = 8;
        }
    }
    for(int i = position - 1; i > 0 ; --i){
        if([[self.board positions][(position*8)+i] isEqual:[NSNull null]]){
            [positions addObject:[NSNumber numberWithInt:i]];
        }else if(((Tower*)([self.board positions][(position*8)+i])).color != 2){
            //Oposite Pice found, could be eaten and position should be added. No more positions to look in row
            i = 8;
            [positions addObject:[NSNumber numberWithInt:i]];
        }else{
            //My Pice found, no more positions to look
            i = 8;
        }
    }
}

- (void) addPositionsFromColTo: (NSMutableArray*) positions at:(int) position{
    for(int i = position + 1; i < 8 ; ++i){
        if([[self.board positions][(i*8)+position] isEqual:[NSNull null]]){
            [positions addObject:[NSNumber numberWithInt:i]];
        }else if(((Tower*)([self.board positions][(position*8)+i])).color != 2){
            //Oposite Pice found, could be eaten and position should be added. No more positions to look in row
            i = 8;
            [positions addObject:[NSNumber numberWithInt:i]];
        }else{
            //My Pice found, no more positions to look
            i = 8;
        }
    }
    for(int i = position - 1; i > 0 ; --i){
        if([[self.board positions][(i*8)+position] isEqual:[NSNull null]]){
            [positions addObject:[NSNumber numberWithInt:i]];
        }else if(((Tower*)([self.board positions][(position*8)+i])).color != 2){
            //Oposite Pice found, could be eaten and position should be added. No more positions to look in row
            i = 8;
            [positions addObject:[NSNumber numberWithInt:i]];
        }else{
            //My Pice found, no more positions to look
            i = 8;
        }
    }
}

- (BOOL) isRowEmpty:(int)row from: (int)actualCol to: (int) newCol{
    if(actualCol > newCol){
        int aux = actualCol;
        actualCol = newCol;
        newCol = aux;
    }
    for(int i = actualCol + 1; i < newCol; ++i){
        if(![[self.board positions][(row*8)+i] isEqual:[NSNull null]]){
            return NO;
        }
    }
    return YES;
}

- (BOOL) isColEmpty:(int)col from: (int)actualRow to: (int) newRow{
    if(actualRow > newRow){
        int aux = actualRow;
        actualRow = newRow;
        newRow = aux;
    }
    for(int i = actualRow + 1; i < newRow; ++i){
        if(![[self.board positions][(i*8)+col] isEqual:[NSNull null]]){
            return NO;
        }
    }
    return YES;
}
@end
