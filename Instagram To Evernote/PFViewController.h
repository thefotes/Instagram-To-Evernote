//
//  PFViewController.h
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *instagramPhotoCollectionView;

@end
