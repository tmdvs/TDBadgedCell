//
//  TDBadgedCell.h
//  TDBadgedTableCell
//	TDBageView
//
//	Any rereleasing of this code is prohibited.
//	Please attribute use of this code within your application
//
//	Any Queries should be directed to hi@tmdvs.me | http://www.tmdvs.me
//	
//  Created by Tim on [Dec 30].
//  Copyright 2009 Tim Davies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDBadgeView : UIView
{
	NSInteger width;
	NSInteger badgeNumber;
	
	CGSize numberSize;
	UIFont *font;
	NSString *countString;
	UITableViewCell *parent;
	
	UIColor *badgeColor;
	UIColor *badgeColorHighlighted;
	
}

@property (readonly) NSInteger width;
@property  NSInteger badgeNumber;
@property (nonatomic,retain) UITableViewCell *parent;
@property (nonatomic, retain) UIColor *badgeColor;
@property (nonatomic, retain) UIColor *badgeColorHighlighted;

@end

@interface TDBadgedCell : UITableViewCell {
	NSInteger badgeNumber;
	TDBadgeView *badge;
	
	UIColor *badgeColor;
	UIColor *badgeColorHighlighted;
}

@property NSInteger badgeNumber;
@property (readonly, retain) TDBadgeView *badge;
@property (nonatomic, retain) UIColor *badgeColor;
@property (nonatomic, retain) UIColor *badgeColorHighlighted;

@end
