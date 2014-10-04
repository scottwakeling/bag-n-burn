// The MIT License (MIT)
//
// Copyright (c) 2013-2014 Scott Wakeling
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
