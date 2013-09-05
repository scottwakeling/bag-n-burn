//
//  ComicCoverViewController.m
//  bagnburn
//
//  Created by Scott Wakeling on 20/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//

#import "ComicCoverViewController.h"
#import "ComicEditViewController.h"
#import "ComicDetailViewController.h"

#import "ComicDataController.h"
#import "ComicsAppDelegate.h"
#import "Comic.h"
#import "ComicData.h"

@interface ComicCoverViewController ()

- (void)deleteCurrentComic;
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@implementation ComicCoverViewController

@synthesize carousel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    [carousel setDelegate:nil];
    [carousel setDataSource:nil];
    
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure carousel
    [carousel setType:iCarouselTypeCoverFlow2];
    [carousel setBounces:NO];
    
    //  Grab the managed object context from the app delegate
    ComicsAppDelegate *appDelegate = (ComicsAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.dataController setManagedObjectContext:[appDelegate managedObjectContext]];
    
    //  Fetch already saved comics
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Comic" inManagedObjectContext:self.dataController.managedObjectContext];
    [request setEntity:entity];
    
    
    //  Fetch comics for the list type we are displaying (Pull,Collect,Wish)
    NSNumber *listType = [NSNumber numberWithInt:self.dataController.comicListType];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(list = %@)", listType];
    [request setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"title" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    
    //  Execute the fetch request
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.dataController.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // TODO: Handle the error.
        NSLog(@"Failed execute fetch request in ComicCoverViewController's viewDidLoad");
    }
    
    //  Cache the results
    [self.dataController setComicsArray:mutableFetchResults];

    //  Now we've loaded our data, configure and connect the carousel which will render it
    [self.carousel setContentOffset:CGSizeMake(0.f,22.f)];
    [self.carousel setDataSource:self];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ViewComicDetailSegue"])
    {
        //  Pushing to a detail view..
        ComicDetailViewController *detailViewController = (ComicDetailViewController *)[segue destinationViewController];
        detailViewController.hidesBottomBarWhenPushed = YES;
        detailViewController.comic = [self.dataController comicAtIndex:self.carousel.currentItemIndex];
        detailViewController.comicCoverPNG = ((UIImageView *)self.carousel.currentItemView).image;
        
        //  If the comic gets edits beneath the detail view we need to hear about them (because
        //  we have the data controller)
        detailViewController.editDelegate = self;
        
    } else if ([[segue identifier] isEqualToString:@"AddComicSegue"]) {
        //  Going to use the ComicEditViewController to ADD a new comic
        ComicEditViewController *addViewController = (ComicEditViewController *)[segue destinationViewController];
        addViewController.editDelegate = self;
        
        //  nil (empty) the input controls in the edit controller, we are adding a new comic
        [addViewController resetForNewComic];
    }
    
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.dataController countOfList];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    static const float CODComicCoverWidthInPoints = 204.f;
    static const float CODComicCoverHeightInPoints = 312.f;

    static const float CODComicTitleOffsetY = -190.f;
    static const float CODComicTitleFontSize = 20;
    
    static const float CODComicPublisherOffsetY = -170.f;
    static const float CODComicPublisherFontSize = 14;
    
    UILabel *titleLabel, *publisherLabel = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CODComicCoverWidthInPoints, CODComicCoverHeightInPoints)];
        view.contentMode = UIViewContentModeScaleAspectFit;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectOffset(view.bounds, 0.f, CODComicTitleOffsetY)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [titleLabel.font fontWithSize:CODComicTitleFontSize];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.tag = 1;
        [view addSubview:titleLabel];
        
        publisherLabel = [[UILabel alloc] initWithFrame:CGRectOffset(view.bounds, 0.f, CODComicPublisherOffsetY)];
        publisherLabel.backgroundColor = [UIColor clearColor];
        publisherLabel.textAlignment = NSTextAlignmentCenter;
        publisherLabel.font = [publisherLabel.font fontWithSize:CODComicPublisherFontSize];
        publisherLabel.textColor = [UIColor whiteColor];
        publisherLabel.tag = 2;
        [view addSubview:publisherLabel];
    }
    else
    {
        //get a reference to the label in the recycled view
        titleLabel = (UILabel *)[view viewWithTag:1];
        publisherLabel = (UILabel *)[view viewWithTag:2];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel

    //  Set cover art, title, publisher etc.
    Comic *comic = [self.dataController comicAtIndex:index];
    ((UIImageView *)view).image = [UIImage imageWithData:[comic coverArt]];
    titleLabel.text = [NSString stringWithFormat:@"%@", [comic title]];
    publisherLabel.text = [NSString stringWithFormat:@"%@", [comic publisher]];
    
    return view;
}


- (IBAction)confirmDeleteComic {
    if (carousel.numberOfItems > 0)
    {        
        UIActionSheet *confirmBurn = [[UIActionSheet alloc] initWithTitle:@"Really burn this comic?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Burn It!" otherButtonTitles:nil];
        [confirmBurn setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        UITabBar *tabBar = self.parentViewController.tabBarController.tabBar;
        [confirmBurn showFromTabBar:tabBar];
    }
}


- (void)deleteCurrentComic
{
    //  Delete from the carousel
    NSInteger index = carousel.currentItemIndex;
    [carousel removeItemAtIndex:index animated:YES];
    //  Delete from the data model
    [self.dataController deleteComicAtIndex:index];
}


- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1f;
    } else if (option == iCarouselOptionShowBackfaces) {
        return FALSE;
    }
    return value;
}


#pragma mark ComicEditDelegate

//
- (void)doneEdit:(ComicData *)comicData {
    
    //  The data model needs at least a title..
    if ([comicData.title length] > 0) {
        
        //  Insert to right of current position (works well with first and last place insertions)
        NSInteger index = carousel.currentItemIndex + 1;
        
        //  Add to the data model
        [self.dataController addComicWithTitle:comicData.title publisher:comicData.publisher andCover:comicData.coverImage atIndex:index];
        
        //  Add to the carousel
        [carousel insertItemAtIndex:index animated:YES];
        [carousel scrollToItemAtIndex:index duration:1.f];
    }
}

//
- (void)updateCurrentComicWithTitle:(NSString *)title publisher:(NSString *)publisher andCover:(UIImage *)coverImage {
    
    Comic* comic = (Comic*)[self.dataController comicAtIndex:carousel.currentItemIndex];
    [comic setTitle:title];
    [comic setPublisher:publisher];
    [comic setCoverArt:[NSData dataWithData:UIImagePNGRepresentation(coverImage)]];
    
    //  Persist the updated Comic entity instance to the store
    NSError *error = nil;
    if (![self.dataController.managedObjectContext save:&error]) {
        //  TODO: Failed to save! Handle the err0r!
        NSLog(@"Failed to UPDATE comic: %@", error);
    }
    
    //  Reflect any changes in the carousel
    [carousel reloadItemAtIndex:carousel.currentItemIndex animated:YES];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        [self deleteCurrentComic];
    } else {
        
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    [self performSegueWithIdentifier:@"ViewComicDetailSegue" sender:self];
    
}

@end
