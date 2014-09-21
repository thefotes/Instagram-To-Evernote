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

@interface PFInstagramCommunicator ()

@property (copy, nonatomic) NSURL *authURL;

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

#pragma mark Properties

- (NSURL *)authURL
{
    if (!_authURL) {
        NSString *authURLString = [NSString stringWithFormat:@"https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token", kClientID, kRedirectURI];
        _authURL = [NSURL URLWithString:authURLString];
    }
    
    return _authURL;
}

@end
