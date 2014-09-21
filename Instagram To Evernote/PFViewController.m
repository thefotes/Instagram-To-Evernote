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
#import <ENSDK/ENSDK.h>
#import "PFEvernoteCommunicator.h"

NSString * const kInstagramID = @"kInstagramID";

@interface PFViewController ()

@property (copy, nonatomic) NSArray *instagramObjects;
@property (strong, nonatomic) IBOutlet UIButton *evernoteButton;
@property (strong, nonatomic) NSMutableArray *selectedInstagramObjects;

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

- (NSMutableArray *)selectedInstagramObjects
{
    return _selectedInstagramObjects = _selectedInstagramObjects ?: [NSMutableArray new];
}

- (IBAction)fetchThePhotos:(UIButton *)sender
{
    [[PFInstagramCommunicator sharedInstagramCommunicator] requestFeedForAuthenticatedUserWithCompletion:^(BOOL success, NSArray *returnedData) {
        if (success) {
            self.instagramObjects = [returnedData copy];
            [self.instagramPhotoCollectionView reloadData];
        }
    }];
}

- (IBAction)evernoteTakeAction:(UIButton *)sender
{
    [[PFEvernoteCommunicator sharedEvernoteCommunicator] uploadNotesFromInstagramObjects:self.selectedInstagramObjects tags:nil withCompletion:^(BOOL success) {
        if (success) {
            //Do a happy dance
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.instagramObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PFInstagramCell *cell = ((PFInstagramCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kInstagramID forIndexPath:indexPath]);
    [cell setupCellForInstagramObject:self.instagramObjects[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedInstagramObjects addObject:self.instagramObjects[indexPath.row]];
    PFInstagramCell *cell = ((PFInstagramCell *)[collectionView cellForItemAtIndexPath:indexPath]);
    cell.selected = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedInstagramObjects removeObject:self.instagramObjects[indexPath.row]];
    PFInstagramCell *cell = ((PFInstagramCell *)[collectionView cellForItemAtIndexPath:indexPath]);
    cell.selected = NO;
}

@end
