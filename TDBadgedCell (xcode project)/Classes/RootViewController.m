//
//  RootViewController.m
//  TDBadgedTableCell
//
//  Created by Tim on [Dec 30].
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.title = @"Tim's RSS Reader";
	
	contents = [[NSArray alloc] initWithObjects:[NSDictionary  dictionaryWithObjectsAndKeys:@"TUAW", @"title", 
												 @"The Unofficial Apple Weblog", @"detail",  
												 @"17", @"badge", nil], 
										[NSDictionary  dictionaryWithObjectsAndKeys:@"High Caffine Content", @"title", 
												@"Steven Troughton Smith", @"detail",  
												@"2", @"badge", nil],
										[NSDictionary  dictionaryWithObjectsAndKeys:@"Smoking Apples", @"title", 
												@"Blog about Apple Software…", @"detail",  
												@"145", @"badge", nil], 
										[NSDictionary  dictionaryWithObjectsAndKeys:@"Daring Fireball", @"title", 
												@"The musings of John Gruber", @"detail",  
												@"0", @"badge", nil],nil];
				
}


/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contents count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
   
    TDBadgedCell *cell = [[[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    
	cell.textLabel.text = [[contents objectAtIndex:indexPath.row] objectForKey:@"title"];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
	
	cell.detailTextLabel.text = [[contents objectAtIndex:indexPath.row] objectForKey:@"detail"];
	cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.badgeNumber = [[contents objectAtIndex:indexPath.row] objectForKey:@"badge"];
	
	if (indexPath.row == 1)
		cell.badgeColor = [UIColor colorWithRed:1.000 green:0.397 blue:0.419 alpha:1.000];
	
	if (indexPath.row == 2)
		cell.badgeColor = [UIColor colorWithWhite:0.783 alpha:1.000];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)dealloc {
	[contents release];
	
    [super dealloc];
}


@end

