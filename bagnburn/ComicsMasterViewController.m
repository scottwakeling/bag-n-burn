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

#import "ComicsMasterViewController.h"
#import "ComicDataController.h"
#import "Comic.h"
#import "ComicEditViewController.h"
#import "ComicsAppDelegate.h"
#import "BagBurnSwitch.h"
#import "ComicData.h"


@implementation ComicsMasterViewController


//  Called when loaded from an Interface Builder archive, or nib file.
//  Creates data controllers etc.
- (void)awakeFromNib {
    [super awakeFromNib];
    self.dataController = [ComicDataController new];
}


//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  Grab the managed object context from the app delegate
    ComicsAppDelegate *appDelegate = (ComicsAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.dataController setManagedObjectContext:[appDelegate managedObjectContext]];
    
    //  Add an edit button on the left so we can remove comics later
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //  Fetch already saved comics
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Comic" inManagedObjectContext:self.dataController.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.dataController.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
    }
    
    [self.dataController setComicsArray:mutableFetchResults];
    //[mutableFetchResults release]; - ARC is currently ON
    //[request release]; - ARC is currently ON
}


//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View


//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataController countOfList];
}


//  Asks the data source for a cell to insert in a particular location of the table view. (required)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"ComicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    Comic *comic = [self.dataController comicAtIndex:indexPath.row];
    [[cell textLabel] setText:comic.title];
    [[cell detailTextLabel] setText:comic.publisher];
    cell.imageView.image = [UIImage imageWithData:[comic coverArt]];
    
//    BagBurnSwitch* bagBurnSwitch = [BagBurnSwitch new];
//    bagBurnSwitch.on = [comic.bagOrBurn boolValue];
//    bagBurnSwitch.comicIndex = indexPath.row;
//    [bagBurnSwitch addTarget:self action:@selector(comicDidChangeStatus:) forControlEvents:UIControlEventValueChanged];
//    cell.accessoryView = bagBurnSwitch;

    return cell;
}


//  Tint every other row
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
}


//
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataController deleteComicAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
}


//
- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        
        ComicEditViewController *addController = [segue sourceViewController];

        //  The data model needs at least a title..
        if ([addController.comicData.title length] > 0) {
            [self.dataController addComic:addController.comicData atIndex:0];
            [[self tableView] reloadData];
        }
    }
}


//
- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelInput"]) {
        //  Don't need to dismiss as Unwind Segues do it themselves
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
}


//  Called when the status (bag or burn) of a comic is altered
- (IBAction)comicDidChangeStatus:(id)sender {
    BagBurnSwitch* bagOrBurn = (BagBurnSwitch*)sender;
    [self.dataController changeComicStatusAtIndex:bagOrBurn.comicIndex toStatus:bagOrBurn.on];
}


@end
