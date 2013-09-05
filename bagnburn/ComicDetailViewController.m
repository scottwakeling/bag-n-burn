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
    self.labelIssue.text = [NSString stringWithFormat:@"%@", self.comic.issue];
    self.labelVolume.text = [NSString stringWithFormat:@"%@", self.comic.volume];
    self.labelWriter.text = self.comic.writer;
    self.labelArtist.text = self.comic.artist;
    self.labelColourist.text = self.comic.colourist;
    self.labelLetterer.text = self.comic.letterer;
    self.labelNotes.text = self.comic.notes;
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
        self.imageCover.image = comicData.coverImage;
        self.labelTitle.text = comicData.title;
        self.labelPublisher.text = comicData.publisher;
        self.labelIssue.text = [NSString stringWithFormat:@"%@", comicData.issue];
        self.labelVolume.text = [NSString stringWithFormat:@"%@", comicData.volume];
        self.labelWriter.text = comicData.writer;
        self.labelArtist.text = comicData.artist;
        self.labelColourist.text = comicData.colourist;
        self.labelLetterer.text = comicData.letterer;
        self.labelNotes.text = comicData.notes;
        
        //  Notify our edit delegate
        [self.editDelegate updateCurrentComicWithData:comicData];
    }
}


@end
