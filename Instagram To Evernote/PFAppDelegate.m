//
//  PFAppDelegate.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFAppDelegate.h"
#import "PFInstagramCommunicator.h"

@implementation PFAppDelegate

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [[PFInstagramCommunicator sharedInstagramCommunicator] handleOpenOAuthURL:url];
    return YES;
}

@end
