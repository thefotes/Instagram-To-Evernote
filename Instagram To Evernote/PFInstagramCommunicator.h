//
//  PFInstagramCommunicator.h
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFInstagramCommunicator : NSObject

+ (instancetype)sharedInstagramCommunicator;

- (void)handleOpenOAuthURL:(NSURL *)url;
- (void)authenticateUser;

@end
