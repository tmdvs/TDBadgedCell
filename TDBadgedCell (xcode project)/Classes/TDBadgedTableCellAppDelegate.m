//
//  TDBadgedTableCellAppDelegate.m
//  TDBadgedTableCell
//
//  Created by Tim on [Dec 30].
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TDBadgedTableCellAppDelegate.h"
#import "RootViewController.h"


@implementation TDBadgedTableCellAppDelegate

@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    
    // Override point for customization after app launch
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	RootViewController *viewController = [[RootViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[window setRootViewController:viewController];
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management



@end

