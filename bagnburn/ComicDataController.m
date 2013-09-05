//
//  ComicDataController.m
//  bagnburn
//
//  Created by Scott Wakeling on 12/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//


#import "ComicDataController.h"
#import "Comic.h"


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


//  Add a new Comic and persist it to the Store
- (void)addComicWithTitle:(NSString *)title publisher:(NSString *)publisher andCover:(UIImage *)coverImage atIndex:(int)index {
    
    //  Create and init a new instance of the Comic entity
    Comic *comic = (Comic *)[NSEntityDescription insertNewObjectForEntityForName:@"Comic" inManagedObjectContext:managedObjectContext];
    
    [comic setTitle:title];
    [comic setPublisher:publisher];
    [comic setBagOrBurn:[NSNumber numberWithBool:TRUE]];
    [comic setList:[NSNumber numberWithInt:comicListType]];

    //  TODO: This takes time - cache the NSData rep in AddComic stage - the UIImage data might be getting
    //  purged so this causes that to reload before the conversion can happen..maybe keep the NSData
    //  when you know you can get it without a cache miss
    //  TODO: OR, at the least, showing a 'Saving..' progress dial or something?
    [comic setCoverArt:[NSData dataWithData:UIImagePNGRepresentation(coverImage)]];
    
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




