//
//  TDBadgedTableCellAppDelegate.h
//  TDBadgedTableCell
//
//  Created by Tim on [Dec 30].
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

@interface TDBadgedTableCellAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

