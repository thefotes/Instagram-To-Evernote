//
//  PFAppDelegate.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFAppDelegate.h"
#import "PFInstagramCommunicator.h"
#import <ENSDK/ENSDK.h>
#import "PFEvernoteCommunicator.h"

NSString * const kDeveloperToken = @"";
NSString * const kNoteStoreURL = @"";

@implementation PFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [ENSession setSharedSessionDeveloperToken:kDeveloperToken
                                 noteStoreUrl:kNoteStoreURL];
    [[ENSession sharedSession] listNotebooksWithCompletion:^(NSArray *notebooks, NSError *listNotebooksError) {
        [[PFEvernoteCommunicator sharedEvernoteCommunicator] setNotebooks:notebooks];
    }];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.absoluteString hasPrefix:@"peterfoti"]) {
        [[PFInstagramCommunicator sharedInstagramCommunicator] handleOpenOAuthURL:url];
    } else {
        [[ENSession sharedSession] handleOpenURL:url];
    }
    
    return YES;
}

@end
