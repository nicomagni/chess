//
//  ChessTests.m
//  ChessTests
//
//  Created by Nico Magni on 4/6/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "ChessTests.h"
#import "King.h"
#import "Pawn.h"
#import "Tower.h"
#import "Board.h"
#import "Bishop.h"

@implementation ChessTests

- (void)setUp
{
    [super setUp];
    Board *board = [[Board alloc] init];
    
    [board createNewBoard];
    [board printBoard];
    self.board = board;
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];


    //[board printBoard];


}

- (void)testExample
{

    [self testKing];
    [self testPawn];
    [self testTower];
}

- (void)testTower
{

    Tower *tower = [self.board positions][0];
//    Tower *tower = [[Tower alloc] init];
//    tower.position = 0;
/*
    STAssertTrue([tower move:48], @"Moving King to back and right");
    STAssertTrue([tower move:7], @"Moving King to back and right");
*/
    STAssertFalse([tower move:49], @"Bad moving the tower");
    STAssertFalse([tower move:26], @"Bad moving the tower");
    STAssertFalse([tower move:23], @"Bad moving the tower");
}

-(void) testKing
{
    King *king = [[King alloc] init];
    king.position = 9;
    
    STAssertTrue([king couldMoveToPosition:0], @"Moving King to back and right");
    STAssertTrue([king couldMoveToPosition:1], @"Moving King to back");
    STAssertTrue([king couldMoveToPosition:2], @"Moving King to back and left");
    STAssertTrue([king couldMoveToPosition:10], @"Moving King to the left");
    STAssertTrue([king couldMoveToPosition:8], @"Moving King to the Right");
    STAssertTrue([king couldMoveToPosition:16], @"Moving King to front and Right");
    STAssertTrue([king couldMoveToPosition:17], @"Moving King to front");
    STAssertTrue([king couldMoveToPosition:18], @"Moving King to front and left");
    STAssertFalse([king couldMoveToPosition:24], @"Bad moving the king");
    STAssertFalse([king couldMoveToPosition:11], @"Bad moving the king");
}

-(void) testPawn
{
    Pawn *pawn = [self.board positions][48];

    /*
    STAssertTrue([pawn move:40], @"Moving Pawn two steps");
    STAssertTrue([pawn move:32], @"Moving King to back");
     */

    STAssertFalse([pawn move:41], @"Bad Moving");
    STAssertFalse([pawn move:10], @"Bad Moving");
}

-(void) testBishop
{
    Bishop *bishop = [self.board positions][2];
    
    STAssertTrue([bishop couldMoveToPosition:9], @"Moving King to back and right");
    STAssertTrue([bishop couldMoveToPosition:47], @"Moving King to back and right");
    STAssertFalse([bishop couldMoveToPosition:26], @"Bad Moving");
    STAssertFalse([bishop couldMoveToPosition:10], @"Bad Moving");
    STAssertFalse([bishop couldMoveToPosition:48], @"Bad Moving");
}


@end
