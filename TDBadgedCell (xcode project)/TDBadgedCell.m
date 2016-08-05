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


@implementation TDBadgeView

@synthesize width=__width, badgeString=__badgeString, parent=__parent, badgeColor=__badgeColor, badgeTextColor=__badgeTextColor, badgeColorHighlighted=__badgeColorHighlighted, boldFont=__boldFont, radius=__radius, badgeTextColorHighlighted = __badgeTextColorHighlighted;

- (id) initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor clearColor];
		self.fontSize = 11.f;
        self.boldFont = NO;
	}
	
	return self;
}

- (void) drawRect:(CGRect)rect
{
    // Set up variable for drawing
    CGFloat scale = [[UIScreen mainScreen] scale];
	CGFloat fontsize = self.fontSize;
    UIFont *font = self.boldFont ? [UIFont boldSystemFontOfSize:fontsize] : [UIFont systemFontOfSize:fontsize];
    CGSize numberSize = [self.badgeString sizeWithAttributes:@{ NSFontAttributeName:font }];
    CGFloat radius = (__radius)?__radius:8.5;
    
    // Set the badge background colours
    __defaultColor = [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1.0];
    __defaultHighlightColor = [UIColor whiteColor];
    
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
    UIColor *stringColor = nil;
    if((__parent.highlighted || __parent.selected)) {
        stringColor = __badgeTextColorHighlighted ? __badgeTextColorHighlighted : UIColor.lightGrayColor;
    } else {
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
	
    // Create an image from the new badge (Fast and easy to cache)
	UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
    // Draw the image into the badgeView
	[outputImage drawInRect:rect];
    
    // Set any additional styles for select states
    [[self layer] setCornerRadius:radius];
	
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

@synthesize badgeString=__badgeString, badge=__badge, badgeColor, badgeTextColor, badgeColorHighlighted, badgeLeftOffset, badgeRightOffset, resizeableLabels, badgeHorizPadding, badgeVertPadding, badgeTextColorHighlighted;

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
        
        if (self.accessoryType != UITableViewCellAccessoryNone)
        {
            self.badgeRightOffset = 0.f;
        }
        else
        {
            self.badgeRightOffset = 12.f;
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
	
	self.badgeHorizPadding = 13;
	self.badgeVertPadding = 50;
    
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
        badgeSize = [self.badgeString sizeWithAttributes:@{ NSFontAttributeName:font }];
        
		CGRect badgeframe = CGRectMake(self.contentView.frame.size.width - (badgeSize.width + self.badgeHorizPadding + self.badgeRightOffset),
									   (CGFloat)round((self.contentView.frame.size.height - (badgeSize.height + (self.badgeVertPadding/badgeSize.height))) / 2),
									   badgeSize.width + self.badgeHorizPadding,
                                       badgeSize.height + (self.badgeVertPadding/badgeSize.height));
		
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
