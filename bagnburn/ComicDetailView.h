//
//  ComicDetailView.h
//  bagnburn
//
//  Created by Scott Wakeling on 05/09/2013.
//  Copyright (c) Codometry 2013. Cambridge, UK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComicData;
@class ComicDetailViewController;


@interface ComicDetailView : UIView

@property (nonatomic,strong) ComicData *comicData;
@property (nonatomic, weak) ComicDetailViewController *viewController;

@end
