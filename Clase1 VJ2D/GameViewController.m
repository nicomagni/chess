//
//  GameViewController.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "GameViewController.h"
#import "Piece.h"
#import "Game.h"
#import "AppDelegate.h"
#import "UIDevice+IdentifierAddition.h"

@interface GameViewController ()


@end

@implementation GameViewController

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
    [self loadPiecesFromBoard];
    self.confirmationNeeded = NO;
    [AppDelegate sharedInstance].socket.delegate = self;
    [AppDelegate sharedInstance].game = self.game;
    [AppDelegate sharedInstance].playerMode = [NSNumber numberWithInt:kMultiPlayer];
    [self loadTurn];
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

- (IBAction)pieceSelected:(UIButton *)sender forEvent:(UIEvent *)event {
    int pieceTag = [sender tag] - 100;
    BOOL myTurn = ([self.game.turn intValue] % 2 == [self.game.myColor intValue]);
    NSLog(@"Turn %d",[[NSNumber numberWithBool:([self.game.turn intValue] % 2) == [self.game.myColor intValue]] intValue]);
//    BOOL myTurn = true;
    if(!self.confirmationNeeded && myTurn){
        if (self.startPiece != nil) {
            //This is the target button

            NSLog(@"Setting the destintion");

            BOOL couldMove = [self.startPiece move:pieceTag];

            if(couldMove){
                
                [self sendBoard];
            }
            self.startPiece = nil;
            
            [self loadPiecesFromBoard];
            
            
        }else if(![[self.game.board positions][pieceTag] isEqual:[NSNull null]]){
            self.startPiece = [self.game.board positions][pieceTag];
            if(![self.game.myColor intValue] == self.startPiece.color){
                NSLog(@"Reset the origin");
                self.startPiece = nil;
            }
        }else{
            NSLog(@"Reset the origin");
            self.startPiece = nil;
        }

    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSError* error;
    NSDictionary* messageJSON = [NSJSONSerialization JSONObjectWithData:[(NSString*)message dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    NSString* messageId = [messageJSON valueForKey:@"Command"];
    
    if ([messageId isEqualToString:@"Moved"]) {
        NSLog(@"Moved");
        NSArray *boardArray = [messageJSON objectForKey:@"Game"];
        Board* boardFromServer = [[Board alloc] initWithArray:boardArray];
        self.game.board = boardFromServer;

        [boardFromServer lookForChecks:0];
        
        [self rotateBoard];
        [self loadPiecesFromBoard];
        NSNumber *turn = [messageJSON objectForKey:@"turn"];
        self.game.turn = turn;
        NSLog(@"Turn Recived %d and my color is %d", [turn intValue], [self.game.myColor intValue]);
        
    }
    if(self.game.board.check != -1){
        [self loadCheck: self.game.board.check];
    }else if(self.game.board.checkmate != -1){
        [self loadCheckmate: self.game.board.checkmate];
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

- (void)loadTurn{
    if([self.game.turn intValue] % 2 == kBlack){
        self.playerTurnLabel.text = @"Turno del Negro";
    }else{
        self.playerTurnLabel.text = @"Turno del Blanco";
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

- (void)rotateBoard{
    if([self.game.myColor intValue] == kBlack){
        [self.game.board rotateBoard];
    }
}


- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"socket closed");
}

- (void)sendBoard {
    SRWebSocket* socket = [AppDelegate sharedInstance].socket;
    NSLog(@"Move");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *results = [defaults stringForKey:@"MatchId"];
    NSString * uniqueIdentifier = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
    
    int theValue = [results intValue];
    NSLog(@"Move %d", theValue);
    NSMutableArray *boardArray;
    [self rotateBoard];
    boardArray = [self.game.board getBoardArray];
    int nextTurn = [self.game.turn intValue];
    NSDictionary* gameDict = @{@"turn":[NSNumber numberWithInt:++nextTurn],@"array":boardArray};

    NSDictionary* commandDict = @{@"Command": @"GameMessage",
                                         @"MatchId":results,
                                         @"Id":uniqueIdentifier,
                                         @"MessageType":@"Move",
                                         @"Game":gameDict};
    
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:commandDict options:0 error:&error];
    
    [socket send:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}


@end
