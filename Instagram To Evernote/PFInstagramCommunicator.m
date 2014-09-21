//
//  PFInstagramCommunicator.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFInstagramCommunicator.h"

@implementation PFInstagramCommunicator

+ (instancetype)sharedInstagramCommunicator
{
    static id sharedInstagramCommunicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstagramCommunicator = [[self alloc] init];
    });
    return sharedInstagramCommunicator;
}

- (void)authenticateUser
{
    //TODO: Authenticate User
}

- (void)handleOpenOAuthURL:(NSURL *)url
{
    NSLog(@"URL: %@", url);
}
@end
