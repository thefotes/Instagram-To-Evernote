//
//  PFInstagramCell.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFInstagramCell.h"
#import "PFInstagramObject.h"

@interface PFInstagramCell ()

@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) NSURLSessionDataTask *imageTask;
@property (strong, nonatomic) NSURLSession *session;

@end

@implementation PFInstagramCell

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.alpha = 0.5f;
    } else {
        self.alpha = 1.0f;
    }
}

- (void)setupCellForInstagramObject:(PFInstagramObject *)object
{
    if (self.imageTask) {
        [self.imageTask cancel];
    }
    
    self.thumbnailImageView.image = nil;
    
    self.imageTask = [self.session dataTaskWithURL:object.thumbnailURL
                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                     NSHTTPURLResponse *httpResponse = ((NSHTTPURLResponse *)response);
                                     if (httpResponse.statusCode == 200) {
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             self.thumbnailImageView.image = [UIImage imageWithData:data];
                                         });
                                     } else {
                                         NSLog(@"Could not load image");
                                     }
                                 }];
    
    [self.imageTask resume];

}

- (NSURLSession *)session
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    return [NSURLSession sessionWithConfiguration:sessionConfig];
}

@end
