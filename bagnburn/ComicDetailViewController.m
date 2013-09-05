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


@interface ComicDetailViewController ()

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
    
    self.imageCover.image = [self comicCoverPNG];
    self.labelTitle.text = self.comic.title;
    self.labelPublisher.text = self.comic.publisher;
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
    
    //  The data model needs at least a title..
    if ([comicData.title length] > 0) {
        
        //  Edits were (maybe) made, so update the data controller (and refresh the carousel?)        
        self.imageCover.image = comicData.coverImage;
        self.labelTitle.text = comicData.title;
        self.labelPublisher.text = comicData.publisher;
        //  TODO: set other properties here when you have controls for them
        
        //  Notify our edit delegate, it has the data controller to do updates on
        [self.editDelegate updateCurrentComicWithData:comicData];
    }
}


@end
