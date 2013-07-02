//
//  King.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "King.h"
#import "Board.h"
#import "Tower.h"
#import <math.h>

@implementation King : Piece

- (id) initWithColor:(int)color {
    self = [super init];
    self.color = color;
    self.everChecked = NO;
    self.everMoved = NO;
    if(color == 0){
        self.imageResourceName = @"black_king.png";
    }else{
        self.imageResourceName = @"white_king.png";
    }
    self.type = kKing;
    return self;
}

- (void) printPosition{
    NSLog(@"King: %s in (%d,%d)", (self.color == 1 ? "Black" : "White"), (self.position/8),(self.position%8));
}

- (NSString*) description{
        return [NSString stringWithFormat:@"King Color = %d position = %d",self.color, self.position];
}

- (King *) copyPiece{
    King * piece = [[King alloc] initWithColor:self.color];
    [piece setPosition:self.position];
    return piece;
}

- (BOOL)move:(int)toPosition
{
    if ([self.board.positions[toPosition] class] == [Tower class]) {
        if([self canCastle:toPosition]){
            //Move
            [self.board positions][self.position] = [NSNull null];
            Tower * tower = [self.board positions][toPosition];
            [self.board positions][toPosition] = [NSNull null];
            int kingRow = self.position/8;
            if(toPosition%8 == 0){
                //Move king left
                self.position = (kingRow * 8 + 2);
                tower.position = (kingRow * 8 + 3);
            }else{
                //Move king right
                self.position = (kingRow * 8 + 6);
                tower.position = (kingRow * 8 + 5);
            }
            
            [self.board positions][tower.position] = tower;
            [self.board positions][self.position] = self;
            [self.board lookForChecks: (self.color == 0 ? 1: 0)];
            self.everMoved = YES;
            tower.everMoved = YES;
            return YES;
        }else{
            if([self couldMoveToPosition:toPosition checkingCheck:YES]){
                self.everMoved = YES;
                return [super move:toPosition];
            }
        }
    }
    if([self couldMoveToPosition:toPosition checkingCheck:YES]){
        self.everMoved = YES;
        return [super move:toPosition];
    }
    return NO;
}

- (BOOL)couldMoveToPosition:(int)toPosition  checkingCheck: (BOOL) checkCheck{
    
    if(![super couldMoveToPosition:toPosition checkingCheck:checkCheck]){
        return NO;
    }
    NSLog(@"Salio antes");
    int startColumn = [self.mathUtils getColumnIndexForPosition:self.position];
    int startRow = [self.mathUtils getRowIndexForPosition:self.position];
    
    int endColumn = [self.mathUtils getColumnIndexForPosition:toPosition];
    int endRow = [self.mathUtils getRowIndexForPosition:toPosition];
    
    BOOL kingMove = (abs(startColumn - endColumn) <= 1 && abs(startRow - endRow) <= 1);
    
    if(kingMove){
        if(checkCheck){
            return [super validateCheck:self.color piece: self.position to: toPosition];
        }else{
            return YES;
        }

    }
    return NO;

}

- (BOOL) canCastle: (int) toPosition{
    if(self.everChecked || self.everMoved){
        return NO;
    }
    Tower* tower = self.board.positions[toPosition];
    if(tower.everMoved || tower.color != self.color){
        return NO;
    }
    int towerCol = tower.position%8;

    //Validate there are no pieces between king and tower.
    if( ![tower isRowEmpty:(self.position/8) from:(self.position%8) to:towerCol]){
        return NO;
    }

    NSMutableSet* positionsOtherColorEats = [[NSMutableSet alloc] init];
    for (Piece * piece in self.board.pieces) {
        if(piece.color != self.color){
            [positionsOtherColorEats addObjectsFromArray:[piece canEat]];
        }
    }

    int kingRow = self.position/8;

    if(towerCol == 0){
        for( int i = 1; i < 3; ++i){
            if([positionsOtherColorEats containsObject:[NSNumber numberWithInt:(kingRow*8+i)]]){
                return NO;
            }
            return YES;
        }
    }else if(towerCol == 7){
        for( int i = 4; i < 7; ++i){
            if([positionsOtherColorEats containsObject:[NSNumber numberWithInt:(kingRow*8+i)]]){
                return NO;
            }
            return YES;
        }
    }else{
        return NO;
    }

    return NO;

}

- (NSMutableArray *)canEat{
    NSMutableArray * positions = [[NSMutableArray alloc] init];
    if([self couldMoveToPosition:(self.position - 9) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - 9 )]];
    }
    if([self couldMoveToPosition:(self.position - 8) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - 8 )]];
    }
    if([self couldMoveToPosition:(self.position - 7) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - 7 )]];
    }
    if([self couldMoveToPosition:(self.position - 1) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position - 1 )]];
    }
    if([self couldMoveToPosition:(self.position + 1) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position + 1 )]];
    }
    if([self couldMoveToPosition:(self.position + 7) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position + 7 )]];
    }
    if([self couldMoveToPosition:(self.position + 8) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position + 8 )]];
    }
    if([self couldMoveToPosition:(self.position + 9) checkingCheck:NO]){
        [positions addObject:[NSNumber numberWithInt:(self.position + 9 )]];
    }
    NSLog(@"%@ can eat: %@",self,positions);
    return positions;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeBool:self.everMoved forKey:@"EverMoved"];
    [aCoder encodeBool:self.everChecked forKey:@"EverChecked"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super init]){
        self = [super initWithCoder:aDecoder];
        self.everMoved = [aDecoder decodeBoolForKey:@"EverMoved"];
        self.everChecked = [aDecoder decodeBoolForKey:@"EverChecked"];
    }
    return self;
}

@end
