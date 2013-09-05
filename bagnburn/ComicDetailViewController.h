//
//  ComicDetailViewController.h
//  bagnburn
//
//  Created by Scott Wakeling on 22/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComicEditViewController.h"

@class Comic;

@interface ComicDetailViewController : UIViewController <ComicEditDelegate>

@property (nonatomic, weak) Comic *comic;
@property (nonatomic, weak) UIImage *comicCoverPNG;

@property (weak) id <ComicEditDelegate> editDelegate;

@property (weak, nonatomic) IBOutlet UIImageView *imageCover;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelIssue;
@property (weak, nonatomic) IBOutlet UILabel *labelVolume;
@property (weak, nonatomic) IBOutlet UILabel *labelPublisher;
@property (weak, nonatomic) IBOutlet UILabel *labelWriter;
@property (weak, nonatomic) IBOutlet UILabel *labelArtist;
@property (weak, nonatomic) IBOutlet UILabel *labelColourist;
@property (weak, nonatomic) IBOutlet UILabel *labelLetterer;
@property (weak, nonatomic) IBOutlet UILabel *labelNotes;


- (void)doneEdit:(ComicData *)comicData;

@end
