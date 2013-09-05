//
//  Comic.h
//  bagnburn
//
//  Created by Scott Wakeling on 12/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Comic : NSManagedObject


@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *publisher;
@property (nonatomic, assign) NSNumber *bagOrBurn; // (T/F) Bag,Burn
@property (nonatomic, retain) NSData *coverArt; // PNG
@property (nonatomic, assign) NSNumber *issue;
@property (nonatomic, assign) NSNumber *list; // (0-2) Pull,Collect,Wish
@property (nonatomic, retain) NSNumber *volume;
@property (nonatomic, retain) NSString *writer;
@property (nonatomic, retain) NSString *artist;
@property (nonatomic, retain) NSString *colourist;
@property (nonatomic, retain) NSString *letterer;
@property (nonatomic, retain) NSString *notes;


@end

