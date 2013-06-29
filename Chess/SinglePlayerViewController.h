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
- (IBAction)saveGame:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *playerTurnLabel;
- (IBAction)pieceSelected:(UIButton *)sender forEvent:(UIEvent *)event;
@end
