//
//  ENNote+NoteFromInstagramObject.h
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/21/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import <ENSDK/ENSDK.h>

@class PFInstagramObject;

@interface ENNote (NoteFromInstagramObject)

+ (ENNote *)noteFromInstagramObject:(PFInstagramObject *)instagramObject;

@end
