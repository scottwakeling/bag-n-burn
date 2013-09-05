//
//  ComicEditDTO.h
//  bagnburn
//
//  Created by Scott Wakeling on 04/09/2013.
//  Copyright (c) Codometry 2013. Cambridge, UK. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Comic;

@interface ComicData : NSObject

@property (strong, nonatomic) UIImage* coverImage;
//@property (strong, nonatomic) NSData* coverData;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* publisher;
@property (strong, nonatomic) NSNumber* issue;
@property (strong, nonatomic) NSNumber* volume;
@property (strong, nonatomic) NSString* writer;
@property (strong, nonatomic) NSString* artist;
@property (strong, nonatomic) NSString* colourist;
@property (strong, nonatomic) NSString* letterer;
@property (strong, nonatomic) NSString* notes;

- (id)initWithManagedComic: (Comic*)managedComic andCoverImage:(UIImage*)initCoverImage;


@end
