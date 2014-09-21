//
//  ENNote+NoteFromInstagramObject.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/21/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "ENNote+NoteFromInstagramObject.h"
#import "PFInstagramObject.h"

@implementation ENNote (NoteFromInstagramObject)

+ (ENNote *)noteFromInstagramObject:(PFInstagramObject *)instagramObject
{
    ENNote *note = [[ENNote alloc] init];
    note.content = [ENNoteContent noteContentWithSanitizedHTML:[NSString stringWithFormat:@"<img src=\"%@\"><br>from <a href=\"%@\">%@</a>", instagramObject.standardResolutionURL, instagramObject.link, instagramObject.link]];
    note.title = instagramObject.caption;
    ENResource *resource = [[ENResource alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:instagramObject.standardResolutionURL]]];
    [note addResource:resource];
    return note;
}

@end
