//
//  PullListMasterViewController.h
//  bagnburn
//
//  Created by Scott Wakeling on 12/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComicDataController;

@interface ComicsMasterViewController : UITableViewController

@property (strong, nonatomic) ComicDataController *dataController;

- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;

- (IBAction)comicDidChangeStatus:(id)sender;
    
@end
