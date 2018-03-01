//
//  TDBadgedCell.swift
//  TDBadgedCell
//
//  Created by Tim Davies on 07/09/2016.
//  Copyright © 2016 Tim Davies. All rights reserved.
//

import UIKit

/// TDBadgedCell is a table view cell class that adds a badge, similar to the badges in Apple's own apps
/// The badge is generated as image data and drawn as a sub view to the table view sell. This is hopefully
/// most resource effective that a manual draw(rect:) call would be
open class TDBadgedCell: UITableViewCell {

    /// Badge value
    public var badgeString : String = "" {
        didSet {
            if(badgeString == "") {
                badgeView.removeFromSuperview()
                layoutSubviews()
            } else {
                contentView.addSubview(badgeView)
                drawBadge()
            }
        }
    }
    
    /// Badge background color for normal states
    public var badgeColor : UIColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1.0)
    /// Badge background color for highlighted states
    public var badgeColorHighlighted : UIColor = .darkGray
    
    /// Badge font size
    public var badgeFontSize : Float = 11.0
	/// Badge text style if dyanmic type desired
	public var badgeTextStyle: UIFontTextStyle?
    /// Badge text color
    public var badgeTextColor: UIColor?
    /// Corner radius of the badge. Set to 0 for square corners.
    public var badgeRadius : Float = 20
    /// The Badges offset from the right hand side of the Table View Cell
    public var badgeOffset = CGPoint(x:10, y:0)
    
    /// The Image view that the badge will be rendered into
    internal let badgeView = UIImageView()
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout our badge's position
        var offsetX = badgeOffset.x
        if(isEditing == false && accessoryType != .none || (accessoryView) != nil) {
            offsetX = 0 // Accessory types are a pain to get sizing for?
        }
        
        badgeView.frame.origin.x = floor(contentView.frame.width - badgeView.frame.width - offsetX)
        badgeView.frame.origin.y = floor((frame.height / 2) - (badgeView.frame.height / 2))
        
        // Now lets update the width of the cells text labels to take the badge into account
        let labelWidth = self.contentView.frame.width - (badgeView.frame.width + (offsetX * 2));
        
        if textLabel != nil {
            textLabel!.frame.size.width = labelWidth - textLabel!.frame.origin.x
        }
        
        if detailTextLabel != nil {
            detailTextLabel!.frame.size.width = labelWidth - detailTextLabel!.frame.origin.x
        }
    }
    
    // When the badge
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        drawBadge()
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        drawBadge()
    }
    
    /// Generate the badge image
    internal func drawBadge() {

		var badgeFont = UIFont.boldSystemFont(ofSize:CGFloat(badgeFontSize))
		if let textStyle = self.badgeTextStyle
		{
			badgeFont = UIFont.preferredFont(forTextStyle: textStyle)
		}
        // Calculate the size of our string
        let textSize : CGSize = NSString(string: badgeString).size(withAttributes:[NSAttributedStringKey.font:badgeFont])
        
        // Create a frame with padding for our badge
        let height = textSize.height + 10
        var width = textSize.width + 16
        if(width < height) {
            width = height
        }
        let badgeFrame : CGRect = CGRect(x:0, y:0, width:width, height:height)
        
        let badge = CALayer()
        badge.frame = badgeFrame
        
        if(isHighlighted || isSelected) {
            badge.backgroundColor = badgeColorHighlighted.cgColor
        } else {
            badge.backgroundColor = badgeColor.cgColor
        }

        badge.cornerRadius = (CGFloat(badgeRadius) < (badge.frame.size.height / 2)) ? CGFloat(badgeRadius) : CGFloat(badge.frame.size.height / 2)
        
        // Draw badge into graphics context
        UIGraphicsBeginImageContextWithOptions(badge.frame.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        badge.render(in:ctx)
        ctx.saveGState()
        
        // Draw string into graphics context
        if(badgeTextColor == nil) {
            ctx.setBlendMode(CGBlendMode.clear)
        }
        
        NSString(string: badgeString).draw(in:CGRect(x:8, y:5, width:textSize.width, height:textSize.height), withAttributes: [
            NSAttributedStringKey.font:badgeFont,
            NSAttributedStringKey.foregroundColor: badgeTextColor ?? UIColor.clear
        ])
        
        let badgeImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        badgeView.frame = CGRect(x:0, y:0, width:badgeImage.size.width, height:badgeImage.size.height)
        badgeView.image = badgeImage
        
        layoutSubviews()
    }
}
