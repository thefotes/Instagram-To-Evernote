//
//  NSDictionary+HasMorePhotos.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "NSDictionary+HasMorePhotos.h"

@implementation NSDictionary (HasMorePhotos)

- (BOOL)hasMorePhotos
{
    if ([[self objectForKey:@"pagination"] objectForKey:@"next_url"]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)nextURL
{
    return [[self objectForKey:@"pagination"] objectForKey:@"next_url"];
}

@end
