//
//  ComicDetailViewController.m
//  bagnburn
//
//  Created by Scott Wakeling on 22/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//

#import "ComicDetailViewController.h"
#import "ComicEditViewController.h"
#import "Comic.h"
#import "ComicData.h"
#import "ComicDetailView.h"


@interface ComicDetailViewController ()

@property (nonatomic, strong) ComicDetailView *comicDetailView;

@end


@implementation ComicDetailViewController


@synthesize comic;
@synthesize comicCoverPNG;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  Create the comic detail view where we custom render all our info
	ComicDetailView *localComicDetailView = [[ComicDetailView alloc] initWithFrame:self.view.bounds];
	self.comicDetailView = localComicDetailView;
	self.comicDetailView.comicData = [[ComicData alloc] initWithManagedComic:self.comic andCoverImage:self.comicCoverPNG];
	[self.view addSubview:self.comicDetailView];
	self.comicDetailView.viewController = self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditComicSegue"]) {
        
        //  Use the ComicEditViewController to EDIT the comic being viewed
        ComicEditViewController *editViewController = (ComicEditViewController *)[segue destinationViewController];
        editViewController.editDelegate = self;
        
        //  Pass current details to edit view for editing
        [editViewController resetForExistingComic:[[ComicData alloc] initWithManagedComic:self.comic andCoverImage:comicCoverPNG]];
        
        //  Set the title of the nav bar
        [editViewController.navigationItem setTitle:@"Edit"];
    }
    
}



#pragma mark ComicEditDelegate

//
- (void)doneEdit:(ComicData *)comicData {
    
    if ([comicData.title length] > 0) {
        //  Update UI
        self.comicDetailView.comicData = comicData;
        [self.comicDetailView setNeedsDisplay];
        
        //  Notify our edit delegate
        [self.editDelegate updateCurrentComicWithData:comicData];
    }
}


@end
