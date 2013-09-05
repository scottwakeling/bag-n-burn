//
//  BagBurnSwitch.h
//  bagnburn
//
//  Created by Scott Wakeling on 15/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BagBurnSwitch : UISwitch

/*
 Refactor this class out, look at this from prepareForSegue docs:
    For example, if the segue originated from a table view, the sender parameter would identify the table view cell that the user tapped. You could use that information to set the data on the destination view controller.
*/

@property int comicIndex;

@end
