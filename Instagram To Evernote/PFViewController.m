//
//  PFViewController.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFViewController.h"
#import "PFInstagramCommunicator.h"

@interface PFViewController ()

@end

@implementation PFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)fetchThePhotos:(UIButton *)sender
{
    [[PFInstagramCommunicator sharedInstagramCommunicator] requestFeedForAuthenticatedUserWithCompletion:^(BOOL success, NSArray *returnedData) {
        NSLog(@"SUccess: %@", @(success));
        if (success) {
            [returnedData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"OBJ: %@", obj);
            }];
        }
    }];
}


@end
