//

//  AppDelegate.m

//  WhatIOwe

//

//  Created by Keaton Burleson on 4/4/14.

//  Copyright (c) 2014 Revision. All rights reserved.

//



#import "AppDelegate.h"

#import "oweInfo.h"

#import "oweDetails.h"

#import "MasterViewController.h"

#import "PersistentStack.h"

#import "PayPal.h"



@interface AppDelegate ()



@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic, strong) PersistentStack* persistentStack;



@end





@implementation AppDelegate





@synthesize managedObjectContext = _managedObjectContext;

@synthesize managedObjectModel = _managedObjectModel;

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;







- (void)customizeAppearance

{
    
    // Create resizable images
    
    // Set the background image for *all* UINavigationBars
    
    [[UILabel appearance] setFont:[UIFont fontWithName:@"ClearSans-Bold" size:15]];
    
    
    
    
    
}





-(void)initializePayPal {
    
    [PayPal initializeWithAppID:@"APP-80W284485P519543T"
     
                 forEnvironment:ENV_SANDBOX];
    
}











- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

{
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    self.persistentStack = [[PersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
    
    self.managedObjectContext = self.persistentStack.managedObjectContext;
    
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (locationNotification) {
        
        // Set icon badge number to zero
        
        application.applicationIconBadgeNumber = 0;
        
    }
    
    
    
    [NSThread detachNewThreadSelector:@selector(initializePayPal)
     
                             toTarget:self withObject:nil];
    
    // Override point for customization after application launch.
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        
        splitViewController.delegate = (id)navigationController.topViewController;
        
        
        
        UINavigationController *masterNavigationController = splitViewController.viewControllers[0];
        
        MasterViewController *controller = (MasterViewController *)masterNavigationController.topViewController;
        
        controller.managedObjectContext = self.managedObjectContext;
        
    } else {
        
        UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
        
        MasterViewController *controller = (MasterViewController *)navigationController.topViewController;
        
        controller.managedObjectContext = self.managedObjectContext;
        
    }
    
    
    
    NSURL *url = (NSURL *)[launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];
    
    if (url != nil && [url isFileURL]) {
        
        //   UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        NSManagedObject *info = [NSEntityDescription
                                 
                                 insertNewObjectForEntityForName:@"OweInfo"
                                 
                                 inManagedObjectContext:context];
        
        NSData *zippedData = [NSData dataWithContentsOfURL:url];
        
        NSDictionary *dict = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:zippedData];
        
        
        
        
        
        [info setValue:[[dict objectForKey:@"dateString"] stringValue] forKey:@"dateString"];
        
        [info setValue:[[dict objectForKey:@"name"] stringValue] forKey:@"name"];
        
        // [info setValue:wow forKey:@"whooweswhat"];
        
        [info setValue:[dict objectForKey:@"date"] forKey:@"dateowed"];
        
        NSLog(@"Added! :D");
        
        NSError *error;
        
        if (![context save:&error]) {
            
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            
        }
        
    }
    
    
    
    //  [self customizeAppearance];
    
    return YES;
    
    
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url

  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([[url scheme] isEqualToString:@"io"]) {
        
        
        
        
        
        
        
        NSString *taskName = [url host];
        
        
        
        taskName = [taskName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        
        
        
        
        
        

        
        NSString *dateString = [[url fragment] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        // this is imporant - we set our input date format to match our input string
        
        // if format doesn't match you'll get nil from your string, so be careful
        
        
        
        NSDate *dateFromString = [[NSDate alloc] init];
        
        // voila!
        
        
        
        [dateFormatter setDateFormat:@"MM/dd"];
        
        dateFromString = [dateFormatter dateFromString:dateString];
        
        
        
        
        
        NSLog(@"HI2:%@", dateFromString);
        
        
        
        
        
        
        
        //  [formatter setDateStyle:NSDateFormatterFullStyle];
        
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        
        
        
        
        
        
        [formatter setDateFormat:@"MM/dd"];
        
        //  [formatter setDateStyle:NSDateFormatterFullStyle];
        
        
        
        NSString *dateAsString = [formatter stringFromDate:dateFromString];
        
        
        
        
        
        NSString *s = [url query];
        
        NSString *ss = [s stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        
        
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"$"];
        
        NSString *sss = [[ss componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
        
        dateString = dateAsString;
        
        
        
        
        
        
        
        
        
        NSString *editedMoney = [NSString stringWithFormat:@"$%@", sss];
        
        
        
        
        
        NSLog(@"Edited Money2: %@", editedMoney);
        
        
        
        
        
        
        
        if ([dateString isEqualToString:@""])
            
        {
            
            dateString = @"";
            
        }
        
        
        
        
        
        
        
        
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        NSManagedObject *details = [NSEntityDescription
                                    
                                    insertNewObjectForEntityForName:@"OweDetails"
                                    
                                    inManagedObjectContext:context];
        
        [details setValue:editedMoney  forKey:@"money"];
        
        [details setValue:dateFromString forKey:@"date"];
        
        NSString *wow = [[NSString alloc]init];
        
        
        
        NSManagedObject *info = [NSEntityDescription
                                 
                                 insertNewObjectForEntityForName:@"OweInfo"
                                 
                                 inManagedObjectContext:context];
        
        [info setValue:[url fragment] forKey:@"dateString"];
        
        
        
        NSString *name =   [taskName capitalizedString];
        
        [info setValue:name forKey:@"name"];
        
        [info setValue:wow forKey:@"whooweswhat"];
        
        [info setValue:[NSNumber numberWithInt:1] forKey:@"dateowed"];
        
        [details setValue:info forKey:@"info"];
        
        [info setValue: details forKey:@"details"];
        
        
        
        
        
        
        
        
        
        
        
        NSLog(@"YES!");
        
        //   [(NSMutableArray *)_managedObjectContext addObject:item];
        
        return YES;
        
        
        
    }else if ([url isFileURL]){
        
        
        
        
        
        
        
        
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        NSManagedObject *info = [NSEntityDescription
                                 
                                 insertNewObjectForEntityForName:@"OweInfo"
                                 
                                 inManagedObjectContext:context];
        
        NSManagedObject *details = [NSEntityDescription
                                    
                                    insertNewObjectForEntityForName:@"OweDetails"
                                    
                                    inManagedObjectContext:context];
        
        NSData *zippedData = [NSData dataWithContentsOfURL:url];
        
        NSDictionary *dict = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:zippedData];
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        // Time format for the string value
        
        
        
        NSDate *date = [dict objectForKey:@"date"];
        
        NSLog(@"date => %@", date);
        
        NSString *wow = nil;
        
        
        
        
        
        
        
        if ([[dict objectForKey:@"whooweswhat"]  isEqual: @"someoneowes"]) {
            
            wow = @"someoneowes";
            
            //   editedMoney = [NSString stringWithFormat:@"$%@", s];
            
            
            
        }else{
            
            //  editedMoney = [NSString stringWithFormat:@"$%@", s];
            
            wow=@"nope";
            
            
            
        }
        
        
        
        
        
        if (![[dict objectForKey:@"dateString"] isEqualToString:@""]) {
            
            
            
            
            
            
            
            
            
            NSDate *alertTime = date;
            
            UIApplication* app = [UIApplication sharedApplication];
            
            UILocalNotification* notifyAlarm = [[UILocalNotification alloc]init];
            
            if (notifyAlarm) {
                
                notifyAlarm.fireDate = alertTime;
                
                notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
                
                notifyAlarm.repeatInterval = 0;
                
                //notifyAlarm.soundName = @"dingping.mp3";
                
                
                
                if ([wow isEqualToString:@"someoneowes"]) {
                    
                    notifyAlarm.alertBody = [NSString stringWithFormat:@"%@ owes you %@ today", [dict objectForKey:@"name"] , [dict objectForKey:@"money"]];
                    
                }else{
                    
                    notifyAlarm.alertBody = [NSString stringWithFormat:@"You owe %@ %@ today", [dict objectForKey:@"name"] , [dict objectForKey:@"money"]];
                    
                    [details setValue:[dict objectForKey:@"name"] forKey:@"alert"];
                    
                }
                
                [app scheduleLocalNotification:notifyAlarm];
                
                
                
                notifyAlarm.applicationIconBadgeNumber = app.applicationIconBadgeNumber + 1;
                
                
                
                
                
            }
            
        }
        
        
        
        [info setValue:[dict objectForKey:@"name"]  forKey:@"name"];
        
        [details setValue:[dict objectForKey:@"money"] forKey:@"money"];
        
        
        
        // [info setValue:wow forKey:@"whooweswhat"];
        
        [details setValue:date forKey:@"date"];
        
        NSLog(@"Added! :D");
        
        NSString *dateString = [dict objectForKey:@"dateString"];
        
        NSLog(@"Date String Dictionary: %@", [dict objectForKey:@"dateString"]);
        
        if ([[dict objectForKey:@"dateString"] isEqualToString:@""])
            
        {
            
            dateString = @"";
            
        }
        
        
        
        [info setValue:dateString forKey:@"dateString"];
        
        
        
        //   [info setValue:[url fragment] forKey:@"dateString"];
        
        //   [info setValue:taskName forKey:@"name"];
        
        //    [info setValue:wow forKey:@"whooweswhat"];
        
        [info setValue:[NSNumber numberWithInt:1] forKey:@"dateowed"];
        
        [details setValue:info forKey:@"info"];
        
        [info setValue: details forKey:@"details"];
        
        [info setValue:wow forKeyPath:@"whooweswhat"];
        
        
        
        NSError *error;
        
        if (![context save:&error]) {
            
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // this is imporant - we set our input date format to match our input string
        
        // if format doesn't match you'll get nil from your string, so be careful
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        return YES;
        
        
        
    }
    
    NSLog(@"NO!");
    
    return NO;
    
    
    
}





- (void)applicationWillResignActive:(UIApplication *)application

{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application

{
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}



- (void)applicationWillEnterForeground:(UIApplication *)application

{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}



- (void)applicationDidBecomeActive:(UIApplication *)application

{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}



- (void)applicationWillTerminate:(UIApplication *)application

{
    
    // Saves changes in the application's managed object context before the application terminates.
    
    [self saveContext];
    
}

-(BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *info = [NSEntityDescription
                             
                             insertNewObjectForEntityForName:@"OweInfo"
                             
                             inManagedObjectContext:context];
    
    NSData *zippedData = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dict = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:zippedData];
    
    
    
    
    
    [info setValue:[[dict objectForKey:@"dateString"] stringValue] forKey:@"dateString"];
    
    [info setValue:[[dict objectForKey:@"name"] stringValue] forKey:@"name"];
    
    // [info setValue:wow forKey:@"whooweswhat"];
    
    [info setValue:[dict objectForKey:@"date"] forKey:@"dateowed"];
    
    NSLog(@"Added! :D");
    
    NSError *error;
    
    if (![context save:&error]) {
        
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
    }
    
    return YES;
    
}





- (void)saveContext

{
    
    NSError *error = nil;
    
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            // Replace this implementation with code to handle the error appropriately.
            
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
            abort();
            
        }
        
    }
    
}





#pragma mark - Core Data stack



// Returns the managed object context for the application.

// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.

- (NSManagedObjectContext *)managedObjectContext

{
    
    if (_managedObjectContext != nil) {
        
        return _managedObjectContext;
        
    }
    
    
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        
    }
    
    return _managedObjectContext;
    
}



// Returns the managed object model for the application.

// If the model doesn't already exist, it is created from the application's model.

- (NSManagedObjectModel *)managedObjectModel

{
    
    if (_managedObjectModel != nil) {
        
        return _managedObjectModel;
        
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WhatIOwe" withExtension:@"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
    
}



// Returns the persistent store coordinator for the application.

// If the coordinator doesn't already exist, it is created and the application's store added to it.

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator

{
    
    if (_persistentStoreCoordinator != nil) {
        
        return _persistentStoreCoordinator;
        
    }
    
    
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WhatIOwe.sqlite"];
    
    
    
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        /*
         
         Replace this implementation with code to handle the error appropriately.
         
         
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         
         
         Typical reasons for an error here include:
         
         * The persistent store is not accessible;
         
         * The schema for the persistent store is incompatible with current managed object model.
         
         Check the error message to determine what the actual problem was.
         
         
         
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         
         * Simply deleting the existing store:
         
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         
         
         */
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        abort();
        
    }    
    
    
    
    return _persistentStoreCoordinator;
    
}



#pragma mark - Application's Documents directory



// Returns the URL to the application's Documents directory.

- (NSURL *)applicationDocumentsDirectory

{
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
}





- (NSURL*)storeURL

{
    
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    
    return [documentsDirectory URLByAppendingPathComponent:@"WhatIOwe.sqlite"];
    
}



- (NSURL*)modelURL

{
    
    return [[NSBundle mainBundle] URLForResource:@"WhatIOwe" withExtension:@"momd"];
    
}









@end

