//
//  TDBadgedCell.swift
//  TDBadgedCell
//
//  Created by Tim Davies on 07/09/2016.
//  Copyright © 2016 Tim Davies. All rights reserved.
//

import UIKit


class TDBadgedCell: UITableViewCell {

    var badgeString : String = "" {
        didSet {
            self.drawBadge()
            self.layoutSubviews()
        }
    }
    
    var badgeColour = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1.0)
    var badgeColorHighlighted = UIColor.whiteColor()
    var badgeFontSize = 11.0;
    var badgeRadius = 20;
    
    override func drawRect(rect: CGRect) {
        // Our accessory view
        super.drawRect(rect)
        drawBadge()
    }
    
    private func drawBadge() {
        // Calculate the size of our string
        let textSize : CGSize = NSString(string: badgeString).sizeWithAttributes([NSFontAttributeName:UIFont.boldSystemFontOfSize(CGFloat(badgeFontSize))])
        
        // Create a frame with padding for our badge
        let height = textSize.height + 10
        let width = textSize.width + 16
        let badgeFrame : CGRect = CGRectMake(0, 0, (width > height) ? width : height, height)
        
        let badge = CALayer()
        badge.frame = badgeFrame
        badge.backgroundColor = ((self.highlighted) ? badgeColorHighlighted : badgeColour).CGColor
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

        let imageView = UIImageView(frame: CGRectMake(0, 0, badgeImage.size.width, badgeImage.size.height))
        imageView.image = badgeImage
        self.accessoryView = imageView
    }
}
