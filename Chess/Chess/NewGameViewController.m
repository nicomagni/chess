//
//  NewGameViewController.m
//  Chess
//
//  Created by Nico Magni on 4/7/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "NewGameViewController.h"
#import <GameKit/GameKit.h>
#import "AppDelegate.h"
#import "GameViewController.h"
#import "UIDevice+IdentifierAddition.h"

@interface NewGameViewController ()
@property (nonatomic) BOOL connected;
@end

@implementation NewGameViewController
@synthesize connected = _connected;

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
    [AppDelegate sharedInstance].socket.delegate = self;
        [self sendStartMatch];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSError* error;
    NSDictionary* messageJSON = [NSJSONSerialization JSONObjectWithData:[(NSString*)message dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    NSString* messageId = [messageJSON valueForKey:@"Command"];
    
    if ([messageId isEqualToString:@"Connected"]) {
        self.connected = YES;
        NSLog(@"Conected");
    } else if ([messageId isEqualToString:@"StartMatch"]) {
        
        NSLog(@"Start match");
        NSNumber* matchId = [messageJSON valueForKey:@"MatchId"];
        NSString * uniqueIdentifier = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
        NSNumber* colorNumber = [messageJSON valueForKey:uniqueIdentifier];
        self.myColor = [colorNumber intValue];
        int theValue = [matchId intValue];
        NSLog(@"Conected %d", theValue);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *storedVal = matchId;
        NSString *key = @"MatchId";
        
        [defaults setObject:storedVal forKey:key];
        [defaults synchronize];
        
        [self.confirmationButton setEnabled:YES];
        [self performSegueWithIdentifier:@"GOTO_GAME" sender:self];
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

- (IBAction)confirmationButton:(UIButton *)sender {
    //Start Match

}

- (void)sendStartMatch {
    SRWebSocket* socket = [AppDelegate sharedInstance].socket;
    NSLog(@"Find Match");
    NSString * uniqueIdentifier = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
    
    NSDictionary* connectDict = [NSDictionary dictionaryWithObjectsAndKeys:@"FindMatch", @"Command", uniqueIdentifier, @"Id", nil];
    
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:connectDict options:0 error:&error];
    
    [socket send:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /*
     When a row is selected, the segue creates the detail view controller as the destination.
     Set the detail view controller's detail item to the item associated with the selected row.
     */
    if ([[segue identifier] isEqualToString:@"GOTO_GAME"]) {
        GameViewController *gameViewController = [segue destinationViewController];
        gameViewController.game = [[Game alloc] initGameWithColor:self.myColor];
        
    }
}

@end
