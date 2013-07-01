//
//  HomeViewController.m
//  Chess
//
//  Created by Nico Magni on 4/7/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "HomeViewController.h"
#import <GameKit/GameKit.h>
#import "AppDelegate.h"
#import "UIDevice+IdentifierAddition.h"
#import "SinglePlayerViewController.h"

@interface HomeViewController ()
@property (nonatomic) BOOL connected;
@end

@implementation HomeViewController
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
    //NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    //[nc addObserver: self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
    [AppDelegate sharedInstance].socket.delegate = self;
    [[AppDelegate sharedInstance].socket open];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) authenticationChanged
{
    if ([GKLocalPlayer localPlayer].authenticated) {
  //      [AppDelegate sharedInstance].socket.delegate = self;
//        [[AppDelegate sharedInstance].socket open];
    }
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
        NSLog(@"Start mstch");
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    SRWebSocket* socket = [AppDelegate sharedInstance].socket;
    NSLog(@"Socket open");
    NSString * uniqueIdentifier = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
//    NSString * uniqueIdentifier = [NSString stringWithFormat:@"%d%",rand()];
    NSLog(@"Unique identifier For device %d%",uniqueIdentifier);
//    NSDictionary* connectDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Connect", @"Command", uniqueIdentifier, @"Id", nil];
    NSDictionary* connectDict = @{@"Command": @"Connect", @"Id":uniqueIdentifier};
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:connectDict options:0 error:&error];
    
    [socket send:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"socket closed");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /*
     When a row is selected, the segue creates the detail view controller as the destination.
     Set the detail view controller's detail item to the item associated with the selected row.
     */
    if ([[segue identifier] isEqualToString:@"SAVED_GAME"]) {
        NSLog(@"Where am I");
        SinglePlayerViewController *singlePlayerViewController = [segue destinationViewController];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *file = [((NSString*)[paths objectAtIndex:0]) stringByAppendingPathComponent:@"saveFile"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:file]) {
               singlePlayerViewController.game = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
        }
        
    }
}

@end
