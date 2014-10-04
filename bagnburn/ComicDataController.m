// The MIT License (MIT)
//
// Copyright (c) 2013-2014 Scott Wakeling
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "ComicDataController.h"
#import "Comic.h"
#import "ComicData.h"

@implementation ComicDataController


//  Generate accessors
@synthesize comicsArray;
@synthesize managedObjectContext;
@synthesize comicListType;


- (id)initWithComicListType:(CODComicListType)type {

    if ( self = [super init] ) {
        comicListType = type;
        return self;
    } else {
        return nil;
    }
}


//  Override the list setter to ensure |_comicsArray| remains mutable
- (void)setComicsArray:(NSMutableArray *)newList {
    if (comicsArray != newList) {
        comicsArray = [newList mutableCopy];
    }
}


//
- (NSUInteger)countOfList {
    return [self.comicsArray count];
}


//
- (Comic *)comicAtIndex:(NSUInteger)index {
    return [self.comicsArray objectAtIndex:index];
}


//
- (void)addComic:(ComicData *)comicData atIndex:(int)index {
    
    //  Create and init a new instance of the Comic entity
    Comic *comic = (Comic *)[NSEntityDescription insertNewObjectForEntityForName:@"Comic" inManagedObjectContext:managedObjectContext];

    [comic setCoverArt:[NSData dataWithData:UIImagePNGRepresentation(comicData.coverImage)]]; //data!
    [comic setTitle:comicData.title];
    [comic setPublisher:comicData.publisher];
    [comic setIssue:comicData.issue];
    [comic setVolume:comicData.volume];
    [comic setWriter:comicData.writer];
    [comic setArtist:comicData.artist];
    [comic setColourist:comicData.colourist];
    [comic setLetterer:comicData.letterer];
    [comic setNotes:comicData.notes];
    [comic setBagOrBurn:[NSNumber numberWithBool:TRUE]];
    [comic setList:[NSNumber numberWithInt:comicListType]];
    
    //  Persist the new Comic entity instance to the store
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        //  TODO: Failed to save! Handle the err0r!
        NSLog(@"Failed to ADD comic: %@", error);
    }
    
    //  We've persisted the new Comic, so now add it to |comicsArray|
    [comicsArray insertObject:comic atIndex:index];
}


//
- (void)updateComic:(ComicData *)comicData atIndex:(int)index {
    
    Comic* comic = (Comic*)[self comicAtIndex:index];
    [comic setCoverArt:[NSData dataWithData:UIImagePNGRepresentation(comicData.coverImage)]]; //data!
    [comic setTitle:comicData.title];
    [comic setPublisher:comicData.publisher];
    [comic setIssue:comicData.issue];
    [comic setVolume:comicData.volume];
    [comic setWriter:comicData.writer];
    [comic setArtist:comicData.artist];
    [comic setColourist:comicData.colourist];
    [comic setLetterer:comicData.letterer];
    [comic setNotes:comicData.notes];
    [comic setBagOrBurn:[NSNumber numberWithBool:TRUE]];
    
    //  Persist the updated Comic entity instance to the store
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        //  TODO: Failed to save! Handle the err0r!
        NSLog(@"Failed to UPDATE comic: %@", error);
    }
}


//
- (void)changeComicStatusAtIndex:(NSUInteger)index toStatus:(BOOL)status {
    if (index < [self countOfList]) {
        Comic* comic = (Comic*)[comicsArray objectAtIndex:index];
        [comic setBagOrBurn:[NSNumber numberWithBool:status]];
        //  Persist the new Comic entity instance to the store
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            //  TODO: Failed to save! Handle the err0r!
            NSLog(@"Failed to UPDATE comic: %@", error);
            
        }
    }
}


- (void)deleteComicAtIndex:(NSUInteger)index {
    
    // Delete the managed object at the given index path.
    NSManagedObject *comicToDelete = [self.comicsArray objectAtIndex:index];
    [self.managedObjectContext deleteObject:comicToDelete];
    [self.comicsArray removeObjectAtIndex:index];

    // Commit the change.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // TODO: Handle the error!
        NSLog(@"Cripes! Failed to save the managedObjectContext in deleteComicAtIndex:");
    }
}


@end




