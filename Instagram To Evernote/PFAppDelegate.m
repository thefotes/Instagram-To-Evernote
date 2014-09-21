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

NSString * const kDeveloperToken = @"S=s135:U=e0ecc9:E=14fee0daf8c:C=148965c81b0:P=1cd:A=en-devtoken:V=2:H=48546723dd25926af23016485497a3d7";
NSString * const kNoteStoreURL = @"https://www.evernote.com/shard/s135/notestore";

@implementation PFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [ENSession setSharedSessionDeveloperToken:kDeveloperToken
                                 noteStoreUrl:kNoteStoreURL];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSLog(@"URL: %@", url);
    if ([url.absoluteString hasPrefix:@"peterfoti"]) {
        [[PFInstagramCommunicator sharedInstagramCommunicator] handleOpenOAuthURL:url];
    } else {
        [[ENSession sharedSession] handleOpenURL:url];
    }
    
    return YES;
}

@end
