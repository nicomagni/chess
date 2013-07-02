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
    self.color = color;
    self.everMoved = NO;
    if(color == 0){
        self.imageResourceName = @"black_tower.png";
    }else{
        self.imageResourceName = @"white_tower.png";
    }
    self.type = kTower;
    return self;
}

- (void) printPosition{
    NSLog(@"Tower: %s in (%d,%d)", (self.color == 0 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (BOOL) move:(int)toPosition{
    
    if([self couldMoveToPosition:toPosition checkingCheck:NO]){
        self.everMoved = YES;
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
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }else if(actualCol == newCol){

        if([self isColEmpty:actualCol from:actualRow to:newRow ]){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }
    return NO;
}

- (NSString*) description{
    return (self.color == 0 ? @"Black-Tower " : @"White-Tower");
}

- (Tower *) copyPiece{
    Tower * piece = [[Tower alloc] initWithColor:self.color];
    [piece setPosition:self.position];
    return piece;
}

- (NSMutableArray *) canEat{
    NSMutableArray * positions = [[NSMutableArray alloc] init];
    [self addPositionsFromRowTo: positions];
    [self addPositionsFromColTo: positions];
    return positions;
}

- (void) addPositionsFromRowTo: (NSMutableArray*)positions{

    int row = [self.mathUtils getRowIndexForPosition:self.position];
    int col = [self.mathUtils getColumnIndexForPosition:self.position];
    
    for(int i = row + 1; i < 8 ; ++i){
        if([[self.board positions][(i*8)+col] isEqual:[NSNull null]]){
            [positions addObject:[NSNumber numberWithInt:((i*8)+col)]];
        }else if(((Tower*)([self.board positions][(i*8)+col])).color != self.color){
            //Oposite Pice found, could be eaten and position should be added. No more positions to look in row
            [positions addObject:[NSNumber numberWithInt:(i*8)+col]];
            i = 8;
        }else{
            //My Pice found, no more positions to look
            i = 8;
        }
    }
    for(int i = row - 1; i >= 0 ; --i){
        if([[self.board positions][(i*8)+col] isEqual:[NSNull null]]){
            [positions addObject:[NSNumber numberWithInt:((i*8)+col)]];
        }else if(((Tower*)([self.board positions][(i*8)+col])).color != self.color){
            //Oposite Pice found, could be eaten and position should be added. No more positions to look in row
            [positions addObject:[NSNumber numberWithInt:(i*8)+col]];
             i = 0;
        }else{
            //My Pice found, no more positions to look
            i = 0;
        }
    }
}

- (void) addPositionsFromColTo: (NSMutableArray*)positions{
    
    int row = [self.mathUtils getRowIndexForPosition:self.position];
    int col = [self.mathUtils getColumnIndexForPosition:self.position];

    for(int i = col + 1; i < 8 ; ++i){
        if([[self.board positions][(row*8)+i] isEqual:[NSNull null]]){
            [positions addObject:[NSNumber numberWithInt:((row*8)+i)]];
        }else if(((Tower*)([self.board positions][(row*8)+i])).color != self.color){
            //Oposite Pice found, could be eaten and position should be added. No more positions to look in row
            [positions addObject:[NSNumber numberWithInt:(row*8)+i]];
            i = 8;
        }else{
            //My Pice found, no more positions to look
            i = 8;
        }
    }
    for(int i = col - 1; i >= 0 ; --i){
        if([[self.board positions][(row*8)+i] isEqual:[NSNull null]]){
            [positions addObject:[NSNumber numberWithInt:((row*8)+i)]];
        }else if(((Tower*)([self.board positions][(row*8)+i])).color != self.color){
            //Oposite Pice found, could be eaten and position should be added. No more positions to look in row
            [positions addObject:[NSNumber numberWithInt:(row*8)+i]];
             i = 0;
        }else{
            //My Pice found, no more positions to look
            i = 0;
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

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeBool:self.everMoved forKey:@"EverMoved"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{

    if(self = [super init]){
        self = [super initWithCoder:aDecoder];
        self.everMoved = [aDecoder decodeBoolForKey:@"EverMoved"];
    }
    return self;
}


@end
