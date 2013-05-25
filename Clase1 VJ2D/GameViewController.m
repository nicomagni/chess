//
//  GameViewController.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 3/12/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "GameViewController.h"
#import "Board.h"
#import "Piece.h"
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
    Board * board= [[Board alloc] init];
    self.board = [board createNewBoard];
    self.confirmationNeeded = NO;
    [self loadPiecesFromBoard];
    [self.confirmButton setTitle:@"Su Turno" forState:UIControlStateDisabled];
    [self.confirmButton setTitle:@"Confirmar" forState:UIControlStateNormal];
    [AppDelegate sharedInstance].socket.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPiecesFromBoard
{
    for (int i = 0; i < [[self.board positions] count] ; i++) {
        Piece *piece = [self.board positions][i];
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

    if(!self.confirmationNeeded){
        if (self.startPiece != nil) {
            //This is the target button
            
            Piece *endPosition = [self.board positions][pieceTag];
            NSLog(@"Setting the destintion");
            if([self.startPiece move:pieceTag]){
                self.startPiece = nil;
                self.confirmationNeeded = YES;

            }else{
                self.startPiece = nil;
            }
            [self loadPiecesFromBoard];
            
        }else if(![[self.board positions][pieceTag] isEqual:[NSNull null]]){
            
            self.startPiece = [self.board positions][pieceTag];
            NSLog(@"Setting the origin");
        }else{
            NSLog(@"Reset the origin");
            self.startPiece = nil;
        }

    }
    [self.confirmButton setEnabled:self.confirmationNeeded];
}

- (IBAction)cancelButton:(UIButton *)sender {
}

- (IBAction)confirmButton:(UIButton *)sender {
    [self sendBoard];
}


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSError* error;
    NSDictionary* messageJSON = [NSJSONSerialization JSONObjectWithData:[(NSString*)message dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    NSString* messageId = [messageJSON valueForKey:@"Command"];
    
    if ([messageId isEqualToString:@"Connected"]) {
 
        NSLog(@"Conected");
    } else if ([messageId isEqualToString:@"StartMatch"]) {
        NSLog(@"Start match");
 
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
    NSDictionary* connectDict = [NSDictionary dictionaryWithObjectsAndKeys:@"GameMessage", @"Command",results,@"MatchId",uniqueIdentifier, @"Id", @"Move",@"MessageType",@"GAME",@"Game",nil];
    
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:connectDict options:0 error:&error];
    
    [socket send:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}



@end
