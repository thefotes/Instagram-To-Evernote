//
//  PFInstagramObject.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFInstagramObject.h"

@implementation PFInstagramObject

- (id)initWithCaption:(NSString *)caption link:(NSString *)link thumbnailURL:(NSURL *)thumbnailURL standardResolutionURL:(NSURL *)standardResolutionURL createdDate:(NSDate *)createdDate
{
    self = [super init];
    if (self) {
        self.caption = caption;
        self.link = link;
        self.thumbnailURL = thumbnailURL;
        self.standardResolutionURL = standardResolutionURL;
        self.createdDate = createdDate;
    }
    
    return self;
}

@end
