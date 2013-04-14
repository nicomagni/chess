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
    NSDictionary* connectDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Connect", @"Command", [GKLocalPlayer localPlayer].playerID, @"Id", nil];
    
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


@end
