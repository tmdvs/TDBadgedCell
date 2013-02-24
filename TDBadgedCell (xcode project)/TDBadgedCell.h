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
//  Created by Tim
//  Copyright 2011 Tim Davies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#ifndef TD_STRONG
#if __has_feature(objc_arc)
    #define TD_STRONG strong
#else
    #define TD_STRONG retain
#endif
#endif

#ifndef TD_WEAK
#if __has_feature(objc_arc_weak)
    #define TD_WEAK weak
#elif __has_feature(objc_arc)
    #define TD_WEAK unsafe_unretained
#else
    #define TD_WEAK assign
#endif
#endif

@interface TDBadgeView : UIView
{
}

@property (nonatomic, readonly)     NSUInteger width;
@property (nonatomic, TD_STRONG)    NSString *badgeString;
@property (nonatomic, TD_WEAK)      UITableViewCell *parent;
@property (nonatomic, TD_STRONG)    UIColor *badgeColor;
@property (nonatomic, TD_STRONG)    UIColor *badgeTextColor;
@property (nonatomic, TD_STRONG)    UIColor *badgeColorHighlighted;
@property (nonatomic, assign)       BOOL showShadow;
@property (nonatomic, assign)       CGFloat fontSize;
@property (nonatomic, assign)       CGFloat radius;

@end

@interface TDBadgedCell : UITableViewCell {

}

@property (nonatomic, TD_STRONG)    NSString *badgeString;
@property (readonly,  TD_STRONG)    TDBadgeView *badge;
@property (nonatomic, TD_STRONG)    UIColor *badgeColor;
@property (nonatomic, TD_STRONG)    UIColor *badgeTextColor;
@property (nonatomic, TD_STRONG)    UIColor *badgeColorHighlighted;
@property (nonatomic, assign)       BOOL showShadow;
@property (nonatomic, assign)       CGFloat badgeLeftOffset;
@property (nonatomic, assign)       CGFloat badgeRightOffset;
@property (nonatomic, TD_STRONG)    NSMutableArray *resizeableLabels;

@end
