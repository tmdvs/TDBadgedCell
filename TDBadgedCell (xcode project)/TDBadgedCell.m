//
//  TDBadgedCell.m
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

#import "TDBadgedCell.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
#define TDLineBreakModeClip NSLineBreakByClipping
#else
#define TDLineBreakModeClip UILineBreakModeClip
#endif

@implementation TDBadgeView

@synthesize width=__width, badgeString=__badgeString, parent=__parent, badgeColor=__badgeColor, badgeTextColor=__badgeTextColor, badgeColorHighlighted=__badgeColorHighlighted, showShadow=__showShadow, boldFont=__boldFont, radius=__radius, badgeTextColorHighlighted = __badgeTextColorHighlighted;

- (id) initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor clearColor];
		self.fontSize = 11.f;
        
        if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)
            self.boldFont = NO;
        else
            self.boldFont = YES;
	}
	
	return self;
}

- (void) drawRect:(CGRect)rect
{
    // Set up variable for drawing
    CGFloat scale = [[UIScreen mainScreen] scale];
	CGFloat fontsize = self.fontSize;
    UIFont *font = self.boldFont ? [UIFont boldSystemFontOfSize:fontsize] : [UIFont systemFontOfSize:fontsize];
    
    CGSize numberSize;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        numberSize = [self.badgeString sizeWithAttributes:@{ NSFontAttributeName:font }];
    } else {
        numberSize = [self.badgeString sizeWithFont:font];
    }
    
    CGFloat radius = (__radius)?__radius:8.5;
    
    // Set the badge background colours
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        __defaultColor = [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1.0];
        __defaultHighlightColor = [UIColor whiteColor];
    } else {
        __defaultColor = [UIColor colorWithRed:0.530f green:0.600f blue:0.738f alpha:1.000f];
        __defaultHighlightColor = [UIColor whiteColor];
        
    }
    
    UIColor *colour;
    if((__parent.selectionStyle != UITableViewCellSelectionStyleNone) && (__parent.highlighted || __parent.selected))
		if (__badgeColorHighlighted)
			colour = __badgeColorHighlighted;
		else
			colour = __defaultHighlightColor;
        else
            if (__badgeColor)
                colour = __badgeColor;
            else
                colour = __defaultColor;
	
    
    // Create the layer for drawing the badge
	CALayer *__badge = [CALayer layer];
	[__badge setFrame:rect];
	[__badge setBackgroundColor:[colour CGColor]];
	[__badge setCornerRadius:radius];
	
    // Create a graphics context at scale to save the badge to
    UIGraphicsBeginImageContextWithOptions(__badge.frame.size, NO, scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	[__badge renderInContext:context];
	CGContextRestoreGState(context);
    
    
    // Create a frame for the badge text
	CGRect bounds = CGRectMake((rect.size.width / 2) - (numberSize.width / 2) ,
                               ((rect.size.height / 2) - (numberSize.height / 2)),
                               numberSize.width + 12 , numberSize.height);
    
	// Draw and clip the badge text from the badge shape
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        UIColor *stringColor = nil;
        if((__parent.highlighted || __parent.selected)) {
            
            stringColor = __badgeTextColorHighlighted ? __badgeTextColorHighlighted : UIColor.lightGrayColor;
        }
        else {
            
            if(__badgeTextColor) {
                stringColor = __badgeTextColor;
            } else {
                stringColor = [UIColor clearColor];
                CGContextSetBlendMode(context, kCGBlendModeClear);
            }
        }
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        [paragraph setLineBreakMode:NSLineBreakByClipping];
        [__badgeString drawInRect:bounds withAttributes:@{ NSFontAttributeName:font,
                                                           NSParagraphStyleAttributeName:paragraph,
                                                           NSForegroundColorAttributeName:stringColor}];
#if !__has_feature(objc_arc)
        [paragraph release];
#endif
        
    } else {
        
        if((__parent.highlighted || __parent.selected)) {
            if (__badgeTextColorHighlighted) {
                CGContextSetFillColorWithColor(context, __badgeTextColorHighlighted.CGColor);
            }
            else {
                CGContextSetBlendMode(context, kCGBlendModeClear);
            }
        }
        else {
            if (__badgeTextColor) {
                CGContextSetFillColorWithColor(context, __badgeTextColor.CGColor);
            }
            else {
                CGContextSetBlendMode(context, kCGBlendModeClear);
            }
        }
        
        [__badgeString drawInRect:bounds withFont:font lineBreakMode:TDLineBreakModeClip];
    }
	
    // Create an image from the new badge (Fast and easy to cache)
	UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
    // Draw the image into the badgeView
	[outputImage drawInRect:rect];
    
    
    // Set any additional styles for select states
	if((__parent.selectionStyle != UITableViewCellSelectionStyleNone) && (__parent.highlighted || __parent.selected) && __showShadow)
	{
		[[self layer] setCornerRadius:radius];
		[[self layer] setShadowOffset:CGSizeMake(0, 1)];
		[[self layer] setShadowRadius:1.0];
		[[self layer] setShadowOpacity:0.8];
	}
	else
	{
		[[self layer] setCornerRadius:radius];
		[[self layer] setShadowOffset:CGSizeMake(0, 0)];
		[[self layer] setShadowRadius:0];
		[[self layer] setShadowOpacity:0];
	}
	
}

- (void) dealloc
{
	__parent = nil;
	
#if !__has_feature(objc_arc)
	
	[__badgeString release];
	[__badgeColor release];
	[__badgeTextColor release];
	[__badgeColorHighlighted release];
    [__badgeTextColorHighlighted release];
	
	[super dealloc];
#endif
}

@end


@implementation TDBadgedCell

@synthesize badgeString=__badgeString, badge=__badge, badgeColor, badgeTextColor, badgeColorHighlighted, showShadow, badgeLeftOffset, badgeRightOffset, resizeableLabels, badgeTextColorHighlighted;

#pragma mark - Init methods

- (id)initWithCoder:(NSCoder *)decoder
{
	if ((self = [super initWithCoder:decoder]))
	{
		[self configureSelf];
	}
	return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
        self.badgeLeftOffset = 10.f;
        
        if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
            if (self.accessoryType != UITableViewCellAccessoryNone) {
                
                self.badgeRightOffset = 0.f;
            } else {
                
                self.badgeRightOffset = 12.f;
            }
        }
        
		[self configureSelf];
	}
	return self;
}

- (void)configureSelf
{
	// Initialization code
    if(!__badge)
        __badge = [[TDBadgeView alloc] initWithFrame:CGRectZero];
    
	self.badge.parent = self;
    
    // by default, resize textLabel & detailTextLabel
    self.resizeableLabels = [NSMutableArray arrayWithCapacity:2];
    if (self.textLabel != nil)
        [self.resizeableLabels addObject:self.textLabel];
    if (self.detailTextLabel != nil)
        [self.resizeableLabels addObject:self.detailTextLabel];
	
	[self.contentView addSubview:self.badge];
}

- (void) setBadgeString:(NSString *)badgeString
{
#if __has_feature(objc_arc)
    __badgeString = badgeString;
    __badge.badgeString = [__badgeString copy];
#else
    [__badgeString release];
    __badgeString = [badgeString retain];
    __badge.badgeString = [[__badgeString copy] autorelease];
#endif
    [__badge setNeedsDisplay];
    [self layoutSubviews];
}

#pragma mark - Drawing Methods

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(self.badgeString)
	{
        [[self contentView] addSubview:[self badge]];
        
		// Force badges to hide on edit.
		if(self.editing)
			[self.badge setHidden:YES];
		else
			[self.badge setHidden:NO];
		
        // Calculate the size of the bage from the badge string
        UIFont *font = self.badge.boldFont ? [UIFont boldSystemFontOfSize:self.badge.fontSize] : [UIFont systemFontOfSize:self.badge.fontSize];
        
        CGSize badgeSize;
        if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
            badgeSize = [self.badgeString sizeWithAttributes:@{ NSFontAttributeName:font }];
        } else {
            badgeSize = [self.badgeString sizeWithFont:font];
        }
        
		CGRect badgeframe = CGRectMake(self.contentView.frame.size.width - (badgeSize.width + 13 + self.badgeRightOffset),
									   (CGFloat)round((self.contentView.frame.size.height - (badgeSize.height + (50/badgeSize.height))) / 2),
									   badgeSize.width + 13, badgeSize.height + (50/badgeSize.height));
		
        // Enable shadows if we want them
		if(self.showShadow)
			[self.badge setShowShadow:YES];
		else
			[self.badge setShowShadow:NO];
		
        // Set the badge string
		[self.badge setFrame:badgeframe];
		[self.badge setBadgeString:self.badgeString];
		
        // Resize all labels
        for (UILabel *label in self.resizeableLabels)
        {
            if ((label.frame.origin.x + label.frame.size.width) >= badgeframe.origin.x)
            {
                CGFloat textLabelWidth = badgeframe.origin.x - label.frame.origin.x - self.badgeLeftOffset;
                label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, textLabelWidth, label.frame.size.height);
            }
        }
		
		//set badge colours
		if(self.badgeColorHighlighted)
			self.badge.badgeColorHighlighted = self.badgeColorHighlighted;
        
 		//set badge colours or impose defaults
		if(self.badgeColor)
			self.badge.badgeColor = self.badgeColor;
		
		if(self.badgeTextColor)
			self.badge.badgeTextColor = self.badgeTextColor;
        
        if(self.badgeTextColorHighlighted)
			self.badge.badgeTextColorHighlighted = self.badgeTextColorHighlighted;
		
	}
	else
	{
		[self.badge removeFromSuperview];
	}
	
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
	[self.badge setNeedsDisplay];
	
	if(self.showShadow)
	{
		[[[self textLabel] layer] setShadowOffset:CGSizeMake(0, 1)];
		[[[self textLabel] layer] setShadowRadius:1];
		[[[self textLabel] layer] setShadowOpacity:0.8];
		
		[[[self detailTextLabel] layer] setShadowOffset:CGSizeMake(0, 1)];
		[[[self detailTextLabel] layer] setShadowRadius:1];
		[[[self detailTextLabel] layer] setShadowOpacity:0.8];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	[self.badge setNeedsDisplay];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:animated];
	
	if (editing)
	{
		self.badge.hidden = YES;
		[self.badge setNeedsDisplay];
		[self setNeedsDisplay];
	}
	else
	{
		self.badge.hidden = NO;
		[self.badge setNeedsDisplay];
		[self setNeedsDisplay];
	}
}

#if !__has_feature(objc_arc)
- (void)dealloc
{
	[__badge release];
	[badgeColor release];
	[badgeTextColor release];
    [badgeTextColorHighlighted release];
	[__badgeString release];
	[badgeColorHighlighted release];
    [resizeableLabels release];
	
	[super dealloc];
}
#endif


@end
