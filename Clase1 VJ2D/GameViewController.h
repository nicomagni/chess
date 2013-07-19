//
//  GameViewController.h
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "Piece.h"
#import "Game.h"

@interface GameViewController : UIViewController

@property (nonatomic) Game * game;
@property (nonatomic) BOOL confirmationNeeded;
@property (nonatomic) Piece * startPiece;
@property (nonatomic) BOOL crowning;
@property (strong, nonatomic) IBOutlet UIButton *towerUp;
@property (strong, nonatomic) IBOutlet UIButton *towerDown;
@property (strong, nonatomic) IBOutlet UIButton *bishopUp;
@property (strong, nonatomic) IBOutlet UIButton *bishopDown;
@property (strong, nonatomic) IBOutlet UIButton *knightUp;
@property (strong, nonatomic) IBOutlet UIButton *knightDown;
@property (strong, nonatomic) IBOutlet UIButton *pown;
@property (strong, nonatomic) IBOutlet UIButton *queen;


@property (strong, nonatomic) IBOutlet UILabel *playerTurnLabel;
- (IBAction)pieceSelected:(UIButton *)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UIButton *CrownQueenButton;
@property (weak, nonatomic) IBOutlet UIButton *CrownTowerButton;
@property (weak, nonatomic) IBOutlet UIButton *CrownKnightButton;
@property (weak, nonatomic) IBOutlet UIButton *CrownBishopButton;

@end
