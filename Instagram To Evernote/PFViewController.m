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
    [[PFInstagramCommunicator sharedInstagramCommunicator] authenticateUser];
}

@end
