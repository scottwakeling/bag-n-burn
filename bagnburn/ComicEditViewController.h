//
//  AddComicViewController.h
//  bagnburn
//
//  Created by Scott Wakeling on 12/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class Comic;
@class ComicEditViewController;
@class ComicData;


@protocol ComicEditDelegate <NSObject>
- (void)doneEdit:(ComicData *)comicData;
@optional
- (void)updateCurrentComicWithTitle:(NSString *)title publisher:(NSString *)publisher andCover:(UIImage *)coverImage;
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
