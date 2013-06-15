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
@interface SinglePlayerViewController : UIViewController

@property (nonatomic) Board * board;
@property (nonatomic) Piece * startPiece;
@property (nonatomic,strong) NSNumber *myColor;
@property (nonatomic,strong) NSNumber *turn;
@property (nonatomic) BOOL confirmationNeeded;

@property (strong, nonatomic) IBOutlet UILabel *playerTurnLabel;
- (IBAction)pieceSelected:(UIButton *)sender forEvent:(UIEvent *)event;
@end
