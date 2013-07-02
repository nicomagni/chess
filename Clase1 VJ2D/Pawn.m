//
//  Pawn.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "Pawn.h"
#import "Board.h"
#import "AppDelegate.h"

@implementation Pawn

- (id) initWithColor:(int)color {
    self = [super init];
    self.color = color;
    if(color == 0){
        self.imageResourceName = @"black_pawn.png";
    }else{
        self.imageResourceName = @"white_pawn.png";
    }
    self.type = kPawn;
    return self;
}

- (void) printPosition{
    NSLog(@"Pawn: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (BOOL) initialPosition:(int) row player:(int) color {
    if(color == kWhite){
        return row == 6;
    }else if (color == kBlack){
        return row == 1;
    }
    return NO;
}

- (BOOL) isEmpty:(int) position{
    
    return [[[self board] positions][position] isEqual: [NSNull null]];
}

- (Pawn *) copyPiece{
    Pawn * piece = [[Pawn alloc] initWithColor:self.color];
    [piece setPosition:self.position];
    return piece;
}

- (BOOL) move:(int)toPosition {
    
    if([self couldMoveToPosition:toPosition checkingCheck:YES]){
        return [super move:toPosition];
    }
    return NO;
}

-(BOOL) couldMoveToPosition:(int)toPosition checkingCheck:(BOOL) checkCheck{
    
    if(![super couldMoveToPosition:toPosition checkingCheck:YES]){
        return NO;
    }
    
    // If pawn is black it should move foward if not backwards
    int move;
    if([[AppDelegate sharedInstance].playerMode intValue] == kSinglePlayer){
        move = self.color == kWhite ? 1: -1;
    }else{
        move = [[AppDelegate sharedInstance].game.myColor intValue] == self.color ? 1 : -1;
        
    }

    int startColumn = [self.mathUtils getColumnIndexForPosition:self.position];
    int startRow = [self.mathUtils getRowIndexForPosition:self.position];
    
    int endColumn = [self.mathUtils getColumnIndexForPosition:toPosition];
    int endRow = [self.mathUtils getRowIndexForPosition:toPosition];
    
    if((startRow - endRow) == (2 * move) && startColumn == endColumn && [self isEmpty:toPosition]){
        BOOL initPos;
        BOOL firstRowEmpty;
            if([[AppDelegate sharedInstance].playerMode intValue] == kSinglePlayer){
                initPos = [self initialPosition:startRow player: self.color];
                firstRowEmpty = [self.board.positions[(self.color == kWhite ? 5 : 2)*8+startColumn] isEqual:[NSNull null]];
            }else{
                initPos = 6;
                firstRowEmpty = [self.board.positions[5*8+startColumn] isEqual:[NSNull null]];
            }
        if(checkCheck){
            return initPos && firstRowEmpty && [super validateCheck: self.color piece: self.position to: toPosition];
        }else{
            return initPos && firstRowEmpty;
        }

    }else{
        if((startRow - endRow) == (1 * move) && startColumn == endColumn && [self isEmpty:toPosition]){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }

        }else if((startRow - endRow) == (1 * move) && startColumn - endColumn == (1 * move) && [self isOponentPiece:toPosition for:self.color]){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }else if((startRow - endRow) == (1 * move) && endColumn - startColumn == (1 * move) && [self isOponentPiece:toPosition for:self.color]){
            if(checkCheck){
                return [super validateCheck:self.color piece: self.position to: toPosition];
            }else{
                return YES;
            }
        }
    }
    return NO;
}


- (BOOL) isOponentPiece: (int) position for: (int) myColor{
    if(![[self.board positions][position] isEqual:[NSNull null]]){
        if([((Piece*)[self.board positions][position]) color]  != myColor){
            return YES;
        }
    }
return NO;
}

-(NSMutableArray *)canEat{
    NSMutableArray * positions = [[NSMutableArray alloc] init];
    int move;
    
    if([[AppDelegate sharedInstance].playerMode intValue] == kSinglePlayer){
        move = self.color == kWhite? 1 : -1;
    }else{
        move = [[AppDelegate sharedInstance].game.myColor intValue] == self.color ? 1 : -1;
    }
    
    if( [self couldMoveToPosition:(self.position - (7 * move)) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - (7 * move))]];
    }
    if( [self couldMoveToPosition:(self.position - (8 * move)) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - (8 * move))]];
        
        if( [self couldMoveToPosition:(self.position - (2 * 8 * move)) checkingCheck:NO]){
            [positions addObject:[NSNumber numberWithInt:(self.position - (2 * 8 * move))]];
        }
    }
    if( [self couldMoveToPosition:(self.position - (9 * move)) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - (9 * move))]];
    }

    NSLog(@"Pawn can eat: %@",positions);
    return positions;
}


- (NSString*) description{
    return [NSString stringWithFormat:@"PAwn Color = %d position = %d",self.color, self.position];
}


@end
