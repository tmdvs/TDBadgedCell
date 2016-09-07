//
//  TDBadgedCell.swift
//  TDBadgedCell
//
//  Created by Tim Davies on 07/09/2016.
//  Copyright © 2016 Tim Davies. All rights reserved.
//

import UIKit

class TDBadgedCell: UITableViewCell {

    // Badge value
    var badgeString : String = "" {
        didSet {
            if(badgeString == "") {
                badgeView.removeFromSuperview()
                self.layoutSubviews()
            } else {
                self.contentView.addSubview(badgeView)
                self.drawBadge()
                self.layoutSubviews()
            }
        }
    }
    
    // Badge background colours
    var badgeColour = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1.0)
    var badgeColorHighlighted = UIColor.whiteColor()
    
    // Font and style
    var badgeFontSize = 11.0;
    var badgeRadius = 20;
    var badgeOffset = CGPointMake(10, 0);
    let badgeView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout our badge's position
        if(self.contentView.frame.width != self.frame.width) {
            badgeOffset.x = 0 // Accessory types are a pain to get sizing for?
        }
        badgeView.frame.origin.x = floor(self.contentView.frame.width - badgeView.frame.width - badgeOffset.x)
        badgeView.frame.origin.y = floor((self.frame.height / 2) - (badgeView.frame.height / 2))
    }
    
    // When the badge
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        drawBadge()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        drawBadge()
    }
    
    // Draw the bagde image
    private func drawBadge() {
        // Calculate the size of our string
        let textSize : CGSize = NSString(string: badgeString).sizeWithAttributes([NSFontAttributeName:UIFont.boldSystemFontOfSize(CGFloat(badgeFontSize))])
        
        // Create a frame with padding for our badge
        let height = textSize.height + 10
        let width = textSize.width + 16
        let badgeFrame : CGRect = CGRectMake(0, 0, (width > height) ? width : height, height)
        
        let badge = CALayer()
        badge.frame = badgeFrame
        badge.backgroundColor = ((self.highlighted || self.selected) ? badgeColorHighlighted : badgeColour).CGColor
        badge.cornerRadius = (CGFloat(badgeRadius) < (badge.frame.size.height / 2)) ? CGFloat(badgeRadius) : CGFloat(badge.frame.size.height / 2)
        
        // Draw badge into graphics context
        UIGraphicsBeginImageContextWithOptions(badge.frame.size, false, UIScreen.mainScreen().scale)
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSaveGState(ctx)
        badge.renderInContext(ctx!)
        CGContextSaveGState(ctx)
        
        // Draw string into graphics context
        CGContextSetBlendMode(ctx, CGBlendMode.Clear)
        NSString(string: badgeString).drawInRect(CGRectMake(8, 5, textSize.width, textSize.height), withAttributes: [
            NSFontAttributeName:UIFont.boldSystemFontOfSize(CGFloat(badgeFontSize)),
            NSForegroundColorAttributeName: UIColor.clearColor()
            ])
        
        let badgeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        badgeView.frame = CGRectMake(0, 0, badgeImage.size.width, badgeImage.size.height)
        badgeView.image = badgeImage
    }
}
