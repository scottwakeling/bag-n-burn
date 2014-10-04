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


#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class Comic;
@class ComicEditViewController;
@class ComicData;


@protocol ComicEditDelegate <NSObject>
- (void)doneEdit:(ComicData *)comicData;
@optional
- (void)updateCurrentComicWithData:(ComicData *)comicData;
@end




@interface ComicEditViewController : UITableViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate> {
}

@property (readwrite) SystemSoundID clickSound;
@property (weak) id <ComicEditDelegate> editDelegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *comicTitleInput;
@property (weak, nonatomic) IBOutlet UITextField *comicPublisherInput;
@property (weak, nonatomic) IBOutlet UITextField *comicIssueInput;
@property (weak, nonatomic) IBOutlet UITextField *comicVolumeInput;
@property (weak, nonatomic) IBOutlet UITextField *comicWriterInput;
@property (weak, nonatomic) IBOutlet UITextField *comicArtistInput;
@property (weak, nonatomic) IBOutlet UITextField *comicColouristInput;
@property (weak, nonatomic) IBOutlet UITextField *comicLettererInput;
@property (weak, nonatomic) IBOutlet UITextField *comicNotesInput;
@property (weak, nonatomic) IBOutlet UIButton *comicDeleteButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *comicDeleteCell;
@property (strong, nonatomic) ComicData* comicData;

- (IBAction)cancelEdit;
- (IBAction)doneEdit;
- (IBAction)didEditingChanged: (id)sender;

- (void)resetForExistingComic: (ComicData*)existingComic;
- (void)resetForNewComic;

@end
