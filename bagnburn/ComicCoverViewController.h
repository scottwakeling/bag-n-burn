//
//  ComicCoverViewController.h
//  bagnburn
//
//  Created by Scott Wakeling on 20/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "ComicEditViewController.h"

@class ComicDataController;
@class ComicData;

@interface ComicCoverViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, UIActionSheetDelegate, ComicEditDelegate>

@property (nonatomic, strong) ComicDataController *dataController;
@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@property (weak, nonatomic) IBOutlet UITabBar *tabBar;



- (IBAction)confirmDeleteComic;

- (void)doneEdit:(ComicData *)comicData;

@end
