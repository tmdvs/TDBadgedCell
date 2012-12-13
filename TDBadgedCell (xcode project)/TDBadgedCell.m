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

#define kDefaultFontSize 11.0

@implementation TDBadgeView

@synthesize width=__width, badgeString=__badgeString, parent=__parent, badgeColor=__badgeColor, badgeTextColor=__badgeTextColor, badgeColorHighlighted=__badgeColorHighlighted, showShadow=__showShadow, radius=__radius, badgeTextFontSize=__badgeTextFontSize;

- (id) initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{		
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;	
}

- (void) drawRect:(CGRect)rect
{		
  CGFloat fontsize = kDefaultFontSize;
  if (__badgeTextFontSize)
    fontsize = __badgeTextFontSize;
  
	CGSize numberSize = [self.badgeString sizeWithFont:[UIFont boldSystemFontOfSize: fontsize]];
		
	CGRect bounds = CGRectMake(0 , 0, numberSize.width + 12 , 18);
	CGFloat radius = (__radius)?__radius:4.0;
    
	UIColor *colour;
    
	if((__parent.selectionStyle != UITableViewCellSelectionStyleNone) && (__parent.highlighted || __parent.selected))
    {
		if (__badgeColorHighlighted) 
        {
			colour = __badgeColorHighlighted;
		} else {
			colour = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.000f];
		}
	} else {
		if (__badgeColor) 
        {
			colour = __badgeColor;
		} else {
			colour = [UIColor colorWithRed:0.530f green:0.600f blue:0.738f alpha:1.000f];
		}
	}
    
    // Bounds for thet text label
	bounds.origin.x = (bounds.size.width - numberSize.width) / 2.0f + 0.5f;
	bounds.origin.y += 2;
	
    CALayer *__badge = [CALayer layer];
	[__badge setFrame:rect];
    
    CGSize imageSize = __badge.frame.size;
    
    // Render the image @x2 for retina people
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00)
    {
        imageSize = CGSizeMake(__badge.frame.size.width * 2, __badge.frame.size.height * 2);
        [__badge setFrame:CGRectMake(__badge.frame.origin.x, 
                                     __badge.frame.origin.y,
                                     __badge.frame.size.width*2, 
                                     __badge.frame.size.height*2)];
        fontsize = (fontsize * 2);
        bounds.origin.x = ((bounds.size.width * 2) - (numberSize.width * 2)) / 2.0f + 1;
        bounds.origin.y += 3;
        bounds.size.width = bounds.size.width * 2;
        radius = radius * 2;
    }
    
    [__badge setBackgroundColor:[colour CGColor]];
	[__badge setCornerRadius:radius];
    
	UIGraphicsBeginImageContext(imageSize);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	[__badge renderInContext:context];
	CGContextRestoreGState(context);

        if (__badgeTextColor)
        {
            CGContextSetFillColorWithColor(context, __badgeTextColor.CGColor);
        } else {
            CGContextSetBlendMode(context, kCGBlendModeClear);
        }
	
	[__badgeString drawInRect:bounds withFont:[UIFont boldSystemFontOfSize:fontsize] lineBreakMode:TDLineBreakModeClip];

        if (!__badgeTextColor)
        {
            CGContextSetBlendMode(context, kCGBlendModeNormal);
        }
	
	UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	[outputImage drawInRect:rect];
	
	if((__parent.selectionStyle != UITableViewCellSelectionStyleNone) && (__parent.highlighted || __parent.selected) && __showShadow)
	{
		[[self layer] setCornerRadius:radius];
		[[self layer] setShadowOffset:CGSizeMake(0, 1)];
		[[self layer] setShadowRadius:1.0];
		[[self layer] setShadowOpacity:0.8];
	} else {
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
    
    [super dealloc];
#endif
}

@end


@implementation TDBadgedCell

@synthesize badgeString, badge=__badge, badgeColor, badgeTextColor, badgeColorHighlighted, showShadow, badgeTextFontSize=__badgeTextFontSize;

#pragma mark - Init methods

- (void)configureSelf 
{
        // Initialization code
		__badge = [[TDBadgeView alloc] initWithFrame:CGRectZero];
		self.badge.parent = self;
		
        [self.contentView addSubview:self.badge];
		[self.badge setNeedsDisplay];
}

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
        [self configureSelf];
    }
    return self;
}

#pragma mark - Drawing Methods

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(self.badgeString)
	{
		//force badges to hide on edit.
		if(self.editing)
			[self.badge setHidden:YES];
		else
			[self.badge setHidden:NO];
		
		CGFloat fontSize = kDefaultFontSize;
    if (__badgeTextFontSize)
      fontSize = __badgeTextFontSize;
		CGSize badgeSize = [self.badgeString sizeWithFont:[UIFont boldSystemFontOfSize: fontSize]];
		CGRect badgeframe = CGRectMake(self.contentView.frame.size.width - (badgeSize.width + 25),
                                (CGFloat)round((self.contentView.frame.size.height - 18) / 2),
                                badgeSize.width + 13,
                                badgeSize.height + 4);
		
        if(self.showShadow)
            [self.badge setShowShadow:YES];
        else
            [self.badge setShowShadow:NO];
            
		[self.badge setFrame:badgeframe];
		[self.badge setBadgeString:self.badgeString];
		
		if ((self.textLabel.frame.origin.x + self.textLabel.frame.size.width) >= badgeframe.origin.x)
		{
			CGFloat badgeWidth = self.textLabel.frame.size.width - badgeframe.size.width - 10.0f;
			
			self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, badgeWidth, self.textLabel.frame.size.height);
		}
		
		if ((self.detailTextLabel.frame.origin.x + self.detailTextLabel.frame.size.width) >= badgeframe.origin.x)
		{
			CGFloat badgeWidth = self.detailTextLabel.frame.size.width - badgeframe.size.width - 10.0f;
			
			self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y, badgeWidth, self.detailTextLabel.frame.size.height);
		}
        
		//set badge highlighted colours or use defaults
		if(self.badgeColorHighlighted)
			self.badge.badgeColorHighlighted = self.badgeColorHighlighted;
		else 
			self.badge.badgeColorHighlighted = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.000f];
		
		//set badge colours or impose defaults
		if(self.badgeColor)
			self.badge.badgeColor = self.badgeColor;
		else
			self.badge.badgeColor = [UIColor colorWithRed:0.530f green:0.600f blue:0.738f alpha:1.000f];

		if(self.badgeTextColor)
			self.badge.badgeTextColor = self.badgeTextColor;
    
    if (self.badgeTextFontSize)
      self.badge.badgeTextFontSize = __badgeTextFontSize;
	}
	else
	{
		[self.badge setHidden:YES];
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
    [badgeString release];
    [badgeColorHighlighted release];
	
    [super dealloc];
}
#endif


@end
