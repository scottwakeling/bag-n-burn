//
//  PullListAppDelegate.h
//  bagnburn
//
//  Created by Scott Wakeling on 12/08/2013.
//  Copyright (c) 2013 Scott Wakeling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ComicsAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//  The 'Core Data Stack'
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//  saves changes you make to model objects to the data file
- (void)saveContext;

//  URL identifying the application’s data directory
- (NSURL *)applicationDocumentsDirectory;

@end


