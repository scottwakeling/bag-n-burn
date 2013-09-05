//
//  ComicEditDTO.m
//  bagnburn
//
//  Created by Scott Wakeling on 04/09/2013.
//  Copyright (c) Codometry 2013. Cambridge, UK. All rights reserved.
//

#import "ComicData.h"
#import "Comic.h"


@implementation ComicData

@synthesize coverImage;
@synthesize title;
@synthesize publisher;
@synthesize issue;
@synthesize volume;
@synthesize writer;
@synthesize artist;
@synthesize colourist;
@synthesize letterer;
@synthesize notes;

//
- (id)initWithManagedComic: (Comic*)managedComic andCoverImage:(UIImage*)initCoverImage {
    
    if (self = [super init]) {
        title = [managedComic.title copy];
        publisher = [managedComic.publisher copy];
        issue = [managedComic.issue copy];
        volume = [managedComic.volume copy];
        writer =[managedComic.writer copy];
        artist =[managedComic.artist copy];
        colourist =[managedComic.colourist copy];
        letterer =[managedComic.letterer copy];
        notes =[managedComic.notes copy];
        coverImage = [initCoverImage copy];
        return self;
    } else {
        return nil;
    }
}

@end
