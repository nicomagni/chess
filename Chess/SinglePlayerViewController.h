//
//  SinglePlayerViewController.h
//  Chess
//
//  Created by Nico Magni on 6/11/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "Piece.h"
#import "Game.h"

@interface SinglePlayerViewController : UIViewController

@property (nonatomic) Game * game;
@property (nonatomic) Piece * startPiece;
@property (nonatomic) BOOL confirmationNeeded;
@property (nonatomic) BOOL crowning;
- (IBAction)saveGame:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *playerTurnLabel;
- (IBAction)pieceSelected:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *CrownQueenButton;
@property (weak, nonatomic) IBOutlet UIButton *CrownTowerButton;
@property (weak, nonatomic) IBOutlet UIButton *CrownKnightButton;
@property (weak, nonatomic) IBOutlet UIButton *CrownBishopButton;
@end
