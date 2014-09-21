//
//  PFInstagramJSONParser.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFInstagramJSONParser.h"
#import "PFInstagramObject.h"

@implementation PFInstagramJSONParser

+ (instancetype)sharedInstagramJSONParser
{
    static id sharedInstagramJSONParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstagramJSONParser = [[self alloc] init];
    });
    
    return sharedInstagramJSONParser;
}

- (NSArray *)instagramObjectsFromArray:(NSArray *)array
{
    NSMutableArray *instagramObjects = [NSMutableArray new];
    NSArray *dataArray = [self instagramDataArrayFromArray:array];
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        NSString *caption = [[dict objectForKey:@"caption"] objectForKey:@"text"];
        NSString *link = [dict objectForKey:@"link"];
        NSURL *thumbnailURL = [NSURL URLWithString:[[[dict objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"]];
        NSURL *standardResolutionURL = [NSURL URLWithString:[[[dict objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"]];
        NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"created_time"] integerValue]];
        PFInstagramObject *newObj = [[PFInstagramObject alloc] initWithCaption:caption
                                                                          link:link
                                                                  thumbnailURL:thumbnailURL
                                                         standardResolutionURL:standardResolutionURL
                                                                   createdDate:createdDate];
        
        [instagramObjects addObject:newObj];
    }];
    return instagramObjects;
}

- (NSArray *)instagramDataArrayFromArray:(NSArray *)dataArray
{
    return [[dataArray firstObject] objectForKey:@"data"];
}
@end
