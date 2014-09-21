//
//  PFInstagramObject.h
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFInstagramObject : NSObject

@property (copy, nonatomic) NSString *caption;
@property (copy, nonatomic) NSString *link;
@property (strong, nonatomic) NSURL *thumbnailURL;
@property (strong, nonatomic) NSURL *standardResolutionURL;
@property (strong, nonatomic) NSDate *createdDate;

- (id)initWithCaption:(NSString *)caption link:(NSString *)link thumbnailURL:(NSURL *)thumbnailURL standardResolutionURL:(NSURL *)standardResolutionURL createdDate:(NSDate *)createdDate;

@end
