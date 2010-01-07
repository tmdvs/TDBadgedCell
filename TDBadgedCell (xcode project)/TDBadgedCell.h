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
	int width;
	int badgeNumber;
	
	CGSize numberSize;
	UIFont *font;
	NSString *countString;
	UITableViewCell *parent;
	
	UIColor *badgeColor;
	UIColor *badgeColorHighlighted;
	
}

@property (readonly) int width;
@property (readonly) int badgeNumber;
@property (nonatomic,retain) UITableViewCell *parent;
@property (nonatomic, retain) UIColor *badgeColor;
@property (nonatomic, retain) UIColor *badgeColorHighlighted;

- (id) initWithNumber:(int)n;

@end

@interface TDBadgedCell : UITableViewCell {
	int badgeNumber;
	TDBadgeView *badge;
	
	UIColor *badgeColor;
	UIColor *badgeColorHighlighted;
}

@property int badgeNumber;
@property (readonly, retain) TDBadgeView *badge;
@property (nonatomic, retain) UIColor *badgeColor;
@property (nonatomic, retain) UIColor *badgeColorHighlighted;

@end
