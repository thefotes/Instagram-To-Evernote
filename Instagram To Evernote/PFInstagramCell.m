//
//  PFInstagramCell.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFInstagramCell.h"

@interface PFInstagramCell ()

@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end
@implementation PFInstagramCell

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setupCellForInstagramObject:(PFInstagramObject *)object
{
    
}

@end
