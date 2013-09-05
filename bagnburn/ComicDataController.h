//
//  ComicDataController.h
//  bagnburn
//
//  Created by Scott Wakeling on 12/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    CODComicListPull,
    CODComicListCollection,
    CODComicListWish
} CODComicListType;


@class Comic;
@class ComicData;

@interface ComicDataController : NSObject {
    NSMutableArray *comicsArray;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSMutableArray *comicsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property CODComicListType comicListType;

- (id)initWithComicListType:(CODComicListType)type;
- (NSUInteger)countOfList;
- (Comic *)comicAtIndex:(NSUInteger)index;
- (void)addComic:(ComicData *)comicData atIndex:(int)index;
- (void)changeComicStatusAtIndex:(NSUInteger)index toStatus:(BOOL)status;
- (void)deleteComicAtIndex:(NSUInteger)index;

@end



