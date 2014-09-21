//
//  PFEvernoteCommunicator.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFEvernoteCommunicator.h"
#import <ENSDK/ENSDK.h>

@implementation PFEvernoteCommunicator

+ (instancetype)sharedEvernoteCommunicator
{
    static id sharedEvernoteCommunicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedEvernoteCommunicator = [[self alloc] init];
    });
    return sharedEvernoteCommunicator;
}

- (void)uploadNotesFromInstagramObjects:(NSArray *)instagramObjects
{
    
}

@end
