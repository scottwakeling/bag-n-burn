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


#import "ComicEditViewController.h"
#import "ComicCoverViewController.h"
#import "Comic.h"
#import "ComicData.h"

@interface ComicEditViewController ()

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic, retain) NSNumberFormatter *numberFormatter;

- (IBAction)respondToTapGesture:(UITapGestureRecognizer *)sender;

- (void)showImagePicker:(UIImagePickerControllerSourceType)forSource;
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)resetUIFromComicData;
- (void)resetComicDataFromUI;

@end


@implementation ComicEditViewController


@synthesize clickSound;
@synthesize editDelegate;
@synthesize doneButton;
@synthesize comicTitleInput;
@synthesize numberFormatter;


//  Called when Return key is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if ((textField == self.comicTitleInput)
        || (textField == self.comicIssueInput)
        || (textField == self.comicVolumeInput)
        || (textField == self.comicPublisherInput)
        || (textField == self.comicWriterInput)
        || (textField == self.comicArtistInput)
        || (textField == self.comicColouristInput)
        || (textField == self.comicLettererInput)
        || (textField == self.comicNotesInput)) {
        
        [textField resignFirstResponder];
    }
    return YES;
}


//
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  Load click SFX
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"tap" ofType:@"aif"];
    NSURL *audioFileURL = [NSURL fileURLWithPath: soundPath];
    CFURLRef urlRef = (CFURLRef)CFBridgingRetain(audioFileURL);
    AudioServicesCreateSystemSoundID(urlRef, &clickSound);
    CFBridgingRelease(urlRef);
    
    if (!numberFormatter) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    
    [self resetUIFromComicData];

    //  Configure the delete button with its background image
    [self.comicDeleteButton setTitle:@"Delete Comic" forState:UIControlStateNormal];
    [self.comicDeleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.comicDeleteButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.comicDeleteButton setAdjustsImageWhenHighlighted:YES];
    
    [self.comicDeleteButton setBackgroundImage:[[UIImage imageNamed:@"burnButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    
    //[self.comicDeleteButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.comicDeleteCell setHidden:[self.comicData.title length] == 0];
}


//
//  Cache provided comic data and reset the UI to display it
- (void)resetForExistingComic: (ComicData*)existingComic {
    
    //  Cache the comic details and use them to reset the UI
    self.comicData = existingComic;
    
    //  Reset the UI to show the comic's details
    [self resetUIFromComicData];
}


//
//  Cache 'new' comic data and reset the UI to display it ('missing_cover' image, no title etc.)
- (void)resetForNewComic {
    
    self.comicData = [ComicData new];
    self.comicData.coverImage = [UIImage imageNamed:@"missing_cover"];
}


//
//  Reset UI contents to represent the comic data we have cached
- (void)resetUIFromComicData {
    
    self.imageView.image = self.comicData.coverImage;
    self.comicTitleInput.text = self.comicData.title;
    self.comicPublisherInput.text = self.comicData.publisher;
    self.comicWriterInput.text = self.comicData.writer;
    self.comicArtistInput.text = self.comicData.artist;
    self.comicColouristInput.text = self.comicData.colourist;
    self.comicLettererInput.text = self.comicData.letterer;
    self.comicNotesInput.text = self.comicData.notes;
    
    if (self.comicData.issue) {
        self.comicIssueInput.text = [NSString stringWithFormat:@"%@", self.comicData.issue];
    }

    if (self.comicData.volume) {
        self.comicVolumeInput.text = [NSString stringWithFormat:@"%@", self.comicData.volume];
    }
}


//
//  Cache comic data entered in UI (typically called prior to a 'ReturnInput' segue or similar)
- (void)resetComicDataFromUI {
        
    self.comicData.title = self.comicTitleInput.text;
    self.comicData.publisher = self.comicPublisherInput.text;
    self.comicData.coverImage = self.imageView.image;
    self.comicData.issue = [numberFormatter numberFromString:self.comicIssueInput.text];
    self.comicData.volume = [numberFormatter numberFromString:self.comicVolumeInput.text];
    self.comicData.writer = self.comicWriterInput.text;
    self.comicData.artist = self.comicArtistInput.text;
    self.comicData.colourist = self.comicColouristInput.text;
    self.comicData.letterer = self.comicLettererInput.text;
    self.comicData.notes = self.comicNotesInput.text;
}


//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

//    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
//        
//        AudioServicesPlaySystemSound(clickSound);
//
//        if ([self.comicTitleInput.text length]) {
//            [self resetComicDataFromUI];
//        }
//    }
}


//
- (IBAction)cancelEdit {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//
- (IBAction)doneEdit {
    
    if ([self.comicTitleInput.text length]) {
        [self resetComicDataFromUI];
    }
    
    //  Pass add/edit data to our edit delegate, it will know what needs to be done
    [self.editDelegate doneEdit:self.comicData];
    
    //  Tell the previous Return to previous view controller (be that the carousel, or the edit view)
    [self dismissViewControllerAnimated:YES completion:nil];
}



//
- (IBAction)respondToTapGesture:(UITapGestureRecognizer *)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //  Camera available, ask user where cover art should come from (library or camera)
        //  TODO: Look - you alloc something here, autorelease? release? (you're using ARC, too bad..?)
        UIActionSheet *imageSourceTypePicker = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
        [imageSourceTypePicker setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        [imageSourceTypePicker showInView:self.view];
    } else {
        //  Camera NOT available, go straight to the Photo Library
        [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}



//
- (void)showImagePicker:(UIImagePickerControllerSourceType)forSource
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = forSource;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    if (forSource == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.showsCameraControls = YES;
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}




//  Any changes to connected targets enable the 'Done' button, providing we still
//  have a title (the data model requires it)
- (IBAction)didEditingChanged: (id)sender {
    
    [doneButton setEnabled:[comicTitleInput.text length] > 0];
}




#pragma mark - UIImagePickerControllerDelegate



// Called when the user chooses an image from their photo library
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];

    //  If the image is higher than 1024.f, shrink it accordingly (and if it's wider than high,
    //  we don't handle rotation so the user must choose/take an appropriately oriented image)
    if (image.size.height > 1024.f) {
        CGSize newSize = CGSizeMake(image.size.width * (1024.f / image.size.height), 1024.f);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    self.imageView.image = image;
    
    [self finishImagePicker];
}



//  Called if the user cancels the image picker
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self finishImagePicker];
}



//  Dismisses and nils the last presented controller (the image picker)
- (void)finishImagePicker {
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.imagePickerController = nil;
}



#pragma mark - UIActionSheetDelegate


//  Choose Photo Library or Camera as source for comic cover image
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
    } else if (buttonIndex == 1){
        [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}


@end
