//
//  PFInstagramCommunicator.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFInstagramCommunicator.h"

NSString * const kClientID = @"10ca9633911b4bfd9a6c9d4dfa861b98";
NSString * const kRedirectURI = @"peterfoti://instagram_callback";
NSString * const kInstagramAuthTokenIdentifier = @"instagramAuthToken";

#define UsersFeedString @"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@&count=100"

@interface PFInstagramCommunicator ()

@property (copy, nonatomic) NSURL *authURL;
@property (copy, nonatomic) NSString *authToken;

@end

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
    [[UIApplication sharedApplication] openURL:self.authURL];
}

- (void)handleOpenOAuthURL:(NSURL *)url
{
    NSArray *parts = [[url absoluteString] componentsSeparatedByString:@"="];
    [[NSUserDefaults standardUserDefaults] setObject:[parts lastObject] forKey:kInstagramAuthTokenIdentifier];
}

- (void)requestFeedForAuthenticatedUserWithCompletion:(InstagramRequestCompletionBlock)completionBlock
{
    if ([self userIsAuthenticated]) {
        //perform request
        NSMutableArray *returnObjects = [NSMutableArray new];
        NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:UsersFeedString, self.authToken]];
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestURL];
        urlRequest.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:urlRequest
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   NSLog(@"Response: %@", response);
                                   NSLog(@"Error: %@", connectionError);
                                   NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:0
                                                                                          error:nil];
                                   [returnObjects addObject:json1];
                                   if ([[json1 objectForKey:@"pagination"] objectForKey:@"next_url"]) {
                                       NSURL *requestURL = [NSURL URLWithString:[[json1 objectForKey:@"pagination"] objectForKey:@"next_url"]];
                                       NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestURL];
                                       urlRequest.HTTPMethod = @"GET";
                                       [NSURLConnection sendAsynchronousRequest:urlRequest
                                                                          queue:[NSOperationQueue mainQueue]
                                                              completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                                                  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                              options:0 error:nil];
                                                                  NSLog(@"Json: %@", json);
                                                                  [returnObjects addObject:json];
                                                                  if (completionBlock) {
                                                                      completionBlock(YES, [NSArray arrayWithArray:returnObjects]);
                                                                  }
                                                              }];
                                   } else {
                                       if (completionBlock) {
                                           completionBlock(YES, [NSArray arrayWithArray:returnObjects]);
                                       }
                                   }
                               }];
    } else {
        [self authenticateUser];
    }
}

- (BOOL)userIsAuthenticated
{
    NSString *authToken = [[NSUserDefaults standardUserDefaults] objectForKey:kInstagramAuthTokenIdentifier];
    if (authToken) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark Properties

- (NSURL *)authURL
{
    if (!_authURL) {
        NSString *authURLString = [NSString stringWithFormat:@"https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token", kClientID, kRedirectURI];
        _authURL = [NSURL URLWithString:authURLString];
    }
    
    return _authURL;
}

- (NSString *)authToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kInstagramAuthTokenIdentifier];
}
@end
