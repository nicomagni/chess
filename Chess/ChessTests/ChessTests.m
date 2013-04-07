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

@implementation ChessTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{

    [self testKing];
    [self testPawn];
    [self testTower];
}

- (void)testTower
{
    Tower *tower = [[Tower alloc] init];
    tower.position = 0;
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
    
    STAssertTrue([king move:0], @"Moving King to back and right");
    STAssertTrue([king move:1], @"Moving King to back");
    STAssertTrue([king move:2], @"Moving King to back and left");
    STAssertTrue([king move:10], @"Moving King to the left");
    STAssertTrue([king move:8], @"Moving King to the Right");
    STAssertTrue([king move:16], @"Moving King to front and Right");
    STAssertTrue([king move:17], @"Moving King to front");
    STAssertTrue([king move:18], @"Moving King to front and left");
    STAssertFalse([king move:24], @"Bad moving the king");
    STAssertFalse([king move:11], @"Bad moving the king");
}

-(void) testPawn
{
    Pawn *pawn = [[Pawn alloc] init];
    pawn.position = 9;
    /*
     STAssertTrue([pawn move:25], @"Moving Pawn two steps");
     STAssertTrue([pawn move:17], @"Moving King to back");
     STAssertTrue([pawn move:16], @"Moving King to back");
     */
    STAssertFalse([pawn move:1], @"Bad Moving");
    STAssertFalse([pawn move:8], @"Bad Moving");
    STAssertFalse([pawn move:10], @"Bad Moving");
}


@end
