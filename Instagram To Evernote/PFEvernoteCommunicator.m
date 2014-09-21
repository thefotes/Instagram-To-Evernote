//
//  PFEvernoteCommunicator.m
//  Instagram To Evernote
//
//  Created by Peter Foti on 9/20/14.
//  Copyright (c) 2014 Peter Foti. All rights reserved.
//

#import "PFEvernoteCommunicator.h"
#import <ENSDK/ENSDK.h>
#import "PFInstagramObject.h"
#import "ENNote+NoteFromInstagramObject.h"

@implementation PFEvernoteCommunicator

+ (instancetype)sharedEvernoteCommunicator
{
    static id sharedEvernoteCommunicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedEvernoteCommunicator = [[self alloc] init];
    });
    return sharedEvernoteCommunicator;
}

- (void)uploadNotesFromInstagramObjects:(NSArray *)instagramObjects toNotebookNamed:(NSString *)notebookName withTags:(NSArray *)tags withCompletion:(EvernoteUploadCompletionBlock)completionBlock
{
    __block int numberOfErrors = 0;
    for (PFInstagramObject *obj in instagramObjects) {
        ENNote *note = [ENNote noteFromInstagramObject:obj];
        if (tags.count > 0) {
            note.tagNames = tags;
        }
        
        ENNotebook *notebook = [self notebookNamed:notebookName];
        NSLog(@"Notebook: %@",notebook);
        [[ENSession sharedSession] uploadNote:note
                                     notebook:notebook
                                   completion:^(ENNoteRef *noteRef, NSError *uploadNoteError) {
                                       if (uploadNoteError) {
                                           numberOfErrors++;
                                           NSLog(@"Upload Error: %@", uploadNoteError);
                                       }
                                   }];
    }
    if (numberOfErrors == 0) {
        if (completionBlock) {
            completionBlock(YES);
        }
    } else {
        if (completionBlock) {
            completionBlock(NO);
        }
    }
}

- (ENNotebook *)notebookNamed:(NSString *)notebookName
{
    ENNotebook *book = nil;
    for (ENNotebook *noteB in self.notebooks) {
        if ([noteB.name isEqualToString:notebookName]) {
            book = noteB;
        }
    }
    
    return book;
}
@end
