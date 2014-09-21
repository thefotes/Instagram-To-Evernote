//
//  PFEvernoteCommunicator.h
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^EvernoteUploadCompletionBlock) (BOOL success);
@interface PFEvernoteCommunicator : NSObject

+ (instancetype)sharedEvernoteCommunicator;

- (void)uploadNotesFromInstagramObjects:(NSArray *)instagramObjects;

@end
