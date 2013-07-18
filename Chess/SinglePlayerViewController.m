//
//  SinglePlayerViewController.m
//  Chess
//
//  Created by Nico Magni on 6/11/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "SinglePlayerViewController.h"
#import "Game.h"
#import "Piece.h"
#import "Pawn.h"
#import "Queen.h"
#import "Tower.h"
#import "Bishop.h"
#import "Knight.h"
#import "AppDelegate.h"
#import "UIDevice+IdentifierAddition.h"

@interface SinglePlayerViewController ()

@end

@implementation SinglePlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.game == nil){
        self.game = [[Game alloc] initGameWithColor:1];
    }
    [AppDelegate sharedInstance].game = self.game;
    self.confirmationNeeded = NO;
    self.crowning = NO;
    [self loadPiecesFromBoard];
    [self loadTurn];
    [AppDelegate sharedInstance].playerMode = [NSNumber numberWithInt:kSinglePlayer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPiecesFromBoard
{
    for (int i = 0; i < [[self.game.board positions] count] ; i++) {
        Piece *piece = [self.game.board positions][i];
        if(![piece isEqual:[NSNull null]]){
            NSString *resource = [piece imageResourceName];
            UIImage * image = [UIImage imageNamed:resource];
            UIButton *button = (UIButton *)[[self view] viewWithTag:i + 100] ;
            [button setBackgroundImage:image forState:UIControlStateNormal];
        }else{
            UIButton *button = (UIButton *)[[self view] viewWithTag:i + 100] ;
            [button setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
}

-(void)loadPiecesForCrowning: (Piece *) pawn to: (int) piceTag{
    //Queen
    Queen* queen = [[Queen alloc] initWithColor:pawn.color];
    [queen setPosition:pawn.position];
    [queen setBoard:pawn.board];
    NSString *resource = [queen imageResourceName];
    UIImage * image = [UIImage imageNamed:resource];
    [self.CrownQueenButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.CrownQueenButton setTag:piceTag];
    [self.CrownQueenButton setHidden:NO];
    //Tower
    Tower* tower = [[Tower alloc] initWithColor:pawn.color];
    [tower setPosition:pawn.position];
    [tower setBoard:pawn.board];
    resource = [tower imageResourceName];
    image = [UIImage imageNamed:resource];
    [self.CrownTowerButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.CrownTowerButton setTag:piceTag];
    [self.CrownTowerButton setHidden:NO];
    //Knight
    Knight* knight = [[Knight alloc] initWithColor:pawn.color];
    [knight setPosition:pawn.position];
    [knight setBoard:pawn.board];
    resource = [knight imageResourceName];
    image = [UIImage imageNamed:resource];
    [self.CrownKnightButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.CrownKnightButton setTag:piceTag];
    [self.CrownKnightButton setHidden:NO];
    //Bishop
    Bishop * bishop = [[Bishop alloc] initWithColor:pawn.color];
    [bishop setPosition:pawn.position];
    [bishop setBoard:pawn.board];
    resource = [bishop imageResourceName];
    image = [UIImage imageNamed:resource];
    [self.CrownBishopButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.CrownBishopButton setTag:piceTag];
    [self.CrownBishopButton setHidden:NO];
    self.crowning = YES;

}

- (IBAction)pieceSelected:(UIButton *)sender forEvent:(UIEvent *)event {
    int pieceTag = [sender tag] - 100;
//    BOOL myTurn = ([self.turn intValue] % 2 == [self.myColor intValue]);
    int colorTurn = [self.game.turn intValue] % 2;
    
    if(self.crowning){
        return;
    }
    
        if (self.startPiece != nil) {
            //This is the target button
            
            NSLog(@"Setting the destintion");
            
            //Validate if Pawn Crown
            if([self.startPiece class] == [Pawn class]){
                if(self.startPiece.color == kWhite && pieceTag/8 == 0){
                    // White pawn in final row
                    if([self.startPiece couldMoveToPosition:pieceTag checkingCheck:YES]){
                        [self loadPiecesForCrowning: self.startPiece to: pieceTag];
                        return;
                    }
                }else if(self.startPiece.color == kBlack && pieceTag/8 == 7){
                    // Black pawn in final row
                    if([self.startPiece couldMoveToPosition:pieceTag checkingCheck:YES]){
                        [self loadPiecesForCrowning: self.startPiece to: pieceTag];
                        return;
                    }
                }
            }
                self.confirmationNeeded = [self.startPiece move:pieceTag];
            
                [self loadPiecesFromBoard];
                if(self.confirmationNeeded){
                    self.game.turn = ([self.game.turn isEqual:[NSNumber numberWithInt:0]] ? [NSNumber numberWithInt:1]:[NSNumber numberWithInt:0]);
                
                    if(self.startPiece.board.check != -1){
                        [self loadCheck: self.startPiece.board.check];
                    }else if(self.startPiece.board.checkmate != -1){
                        [self loadCheckmate: self.startPiece.board.checkmate];

                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Chess Game"
                                                                   message: @"Partida Finalizada"
                                                                  delegate: self
                                                         cancelButtonTitle:nil
                                                         otherButtonTitles:@"OK",nil];
                    
                        [alert show];
                    
                    }else{
                    [self loadTurn];
                    }
                }
            
                self.startPiece = nil;
        }else if(![[self.game.board positions][pieceTag] isEqual:[NSNull null]]){
            
            self.startPiece = [self.game.board positions][pieceTag];
            if(self.startPiece.color != colorTurn){
                self.startPiece = nil;
            }
            NSLog(@"Setting the origin");
        }else{
            NSLog(@"Reset the origin");
            self.startPiece = nil;
        }
        


}

- (void)loadTurn{
    if([self.game.turn intValue] % 2 == kWhite){
        self.playerTurnLabel.text = @"Turno del Blanco";
    }else{
        self.playerTurnLabel.text = @"Turno del Negro";
    }
}

- (void) loadCheck: (int) color{
    if(color == kWhite){
        self.playerTurnLabel.text = @"Jaque al Blanco";
    }else{
        self.playerTurnLabel.text = @"jaque al Negro";
    }
}

- (void) loadCheckmate: (int) color{
    if(color == kWhite){
        self.playerTurnLabel.text = @"Jaque Mate al Blanco";
    }else{
        self.playerTurnLabel.text = @"Jaque Mate al Negro";
    }
}

- (IBAction)saveGame:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *file = [((NSString*)[paths objectAtIndex:0]) stringByAppendingPathComponent:@"saveFile"];
    
    [NSKeyedArchiver archiveRootObject:self.game toFile:file];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Chess Game"
                                                   message: @"Partida Guardada"
                                                  delegate: self
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK",nil];
    
    [alert show];

}
- (IBAction)crownQueen:(id)sender {

    Queen * queen = [[Queen alloc] initWithColor: self.startPiece.color];
    [queen setPosition:self.startPiece.position];
    [queen setBoard:self.startPiece.board];
    [queen.board positions][queen.position] = queen;
    [queen.board.pieces removeObject:self.startPiece];
    [queen.board.pieces addObject:queen];
    self.startPiece = queen;
    self.confirmationNeeded = [self.startPiece superMove:[self.CrownQueenButton tag]];
    
    [self loadPiecesFromBoard];
    if(self.confirmationNeeded){
        self.game.turn = ([self.game.turn isEqual:[NSNumber numberWithInt:0]] ? [NSNumber numberWithInt:1]:[NSNumber numberWithInt:0]);
        
        if(self.startPiece.board.check != -1){
            [self loadCheck: self.startPiece.board.check];
        }else if(self.startPiece.board.checkmate != -1){
            [self loadCheckmate: self.startPiece.board.checkmate];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Chess Game"
                                                           message: @"Partida Finalizada"
                                                          delegate: self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"OK",nil];
            
            [alert show];
            
        }else{
            [self loadTurn];
        }
    }
    
    self.startPiece = nil;
    [self.CrownQueenButton setHidden:YES];
    [self.CrownTowerButton setHidden:YES];
    [self.CrownKnightButton setHidden:YES];
    [self.CrownBishopButton setHidden:YES];
    self.crowning = NO;
}
- (IBAction)crownTower:(id)sender {
    
    Tower * tower = [[Tower alloc] initWithColor: self.startPiece.color];
    [tower setPosition:self.startPiece.position];
    [tower setBoard:self.startPiece.board];
    [tower.board positions][tower.position] = tower;
    [tower.board.pieces removeObject:self.startPiece];
    [tower.board.pieces addObject:tower];
    self.startPiece = tower;
    self.confirmationNeeded = [self.startPiece superMove:[self.CrownTowerButton tag]];
    
    [self loadPiecesFromBoard];
    if(self.confirmationNeeded){
        self.game.turn = ([self.game.turn isEqual:[NSNumber numberWithInt:0]] ? [NSNumber numberWithInt:1]:[NSNumber numberWithInt:0]);
        
        if(self.startPiece.board.check != -1){
            [self loadCheck: self.startPiece.board.check];
        }else if(self.startPiece.board.checkmate != -1){
            [self loadCheckmate: self.startPiece.board.checkmate];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Chess Game"
                                                           message: @"Partida Finalizada"
                                                          delegate: self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"OK",nil];
            
            [alert show];
            
        }else{
            [self loadTurn];
        }
    }
    
    self.startPiece = nil;
    [self.CrownQueenButton setHidden:YES];
    [self.CrownTowerButton setHidden:YES];
    [self.CrownKnightButton setHidden:YES];
    [self.CrownBishopButton setHidden:YES];
    self.crowning = NO;
}
- (IBAction)crownKnight:(id)sender {
    
    Knight * knight = [[Knight alloc] initWithColor: self.startPiece.color];
    [knight setPosition:self.startPiece.position];
    [knight setBoard:self.startPiece.board];
    [knight.board positions][knight.position] = knight;
    [knight.board.pieces removeObject:self.startPiece];
    [knight.board.pieces addObject:knight];
    self.startPiece = knight;
    self.confirmationNeeded = [self.startPiece superMove:[self.CrownKnightButton tag]];
   
    [self loadPiecesFromBoard];
    if(self.confirmationNeeded){
        self.game.turn = ([self.game.turn isEqual:[NSNumber numberWithInt:0]] ? [NSNumber numberWithInt:1]:[NSNumber numberWithInt:0]);
        
        if(self.startPiece.board.check != -1){
            [self loadCheck: self.startPiece.board.check];
        }else if(self.startPiece.board.checkmate != -1){
            [self loadCheckmate: self.startPiece.board.checkmate];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Chess Game"
                                                           message: @"Partida Finalizada"
                                                          delegate: self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"OK",nil];
            
            [alert show];
            
        }else{
            [self loadTurn];
        }
    }
    
    self.startPiece = nil;
    [self.CrownQueenButton setHidden:YES];
    [self.CrownTowerButton setHidden:YES];
    [self.CrownKnightButton setHidden:YES];
    [self.CrownBishopButton setHidden:YES];
    self.crowning = NO;
}
- (IBAction)crownBishop:(id)sender {
   
    Bishop * bishop = [[Bishop alloc] initWithColor: self.startPiece.color];
    [bishop setPosition:self.startPiece.position];
    [bishop setBoard:self.startPiece.board];
    [bishop.board positions][bishop.position] = bishop;
    [bishop.board.pieces removeObject:self.startPiece];
    [bishop.board.pieces addObject:bishop];
    self.startPiece = bishop;
    self.confirmationNeeded = [self.startPiece superMove:[self.CrownBishopButton tag]];
  
    [self loadPiecesFromBoard];
    if(self.confirmationNeeded){
        self.game.turn = ([self.game.turn isEqual:[NSNumber numberWithInt:0]] ? [NSNumber numberWithInt:1]:[NSNumber numberWithInt:0]);
        
        if(self.startPiece.board.check != -1){
            [self loadCheck: self.startPiece.board.check];
        }else if(self.startPiece.board.checkmate != -1){
            [self loadCheckmate: self.startPiece.board.checkmate];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Chess Game"
                                                           message: @"Partida Finalizada"
                                                          delegate: self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"OK",nil];
            
            [alert show];
            
        }else{
            [self loadTurn];
        }
    }
    
    self.startPiece = nil;
    [self.CrownQueenButton setHidden:YES];
    [self.CrownTowerButton setHidden:YES];
    [self.CrownKnightButton setHidden:YES];
    [self.CrownBishopButton setHidden:YES];
    self.crowning = NO;
}
@end
