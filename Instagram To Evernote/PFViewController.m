//
//  PFViewController.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFViewController.h"
#import "PFInstagramCommunicator.h"
#import "PFInstagramCell.h"

NSString * const kInstagramID = @"kInstagramID";

@interface PFViewController ()

@end

@implementation PFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.instagramPhotoCollectionView.allowsMultipleSelection = YES;
    [self.instagramPhotoCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PFInstagramCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kInstagramID];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.instagramPhotoCollectionView.collectionViewLayout = flowLayout;
    self.instagramPhotoCollectionView.backgroundColor = [UIColor blackColor];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PFInstagramCell *cell = ((PFInstagramCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kInstagramID forIndexPath:indexPath]);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PFInstagramCell *cell = ((PFInstagramCell *)[collectionView cellForItemAtIndexPath:indexPath]);
    cell.selected = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PFInstagramCell *cell = ((PFInstagramCell *)[collectionView cellForItemAtIndexPath:indexPath]);
    cell.selected = NO;
}

@end
