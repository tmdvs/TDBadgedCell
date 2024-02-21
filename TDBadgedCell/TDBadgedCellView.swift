//
//  TDBadgedCellView.swift
//  TDBadgedCell
//
//  Created by Tim on 21/02/2024.
//  Copyright © 2024 Tim Davies. All rights reserved.
//

import SwiftUI

internal class TDBadgedCellNoHit: TDBadgedCell {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}

struct TDBadgedCellView: UIViewRepresentable {
    var title: String
    var subtitle: String?
    
    var style: UITableViewCell.CellStyle = .subtitle
    
    var badgeString: String
    var badgeColor: Color = .accentColor
    var badgeColorHighlighted: Color = .primary
    
    func makeUIView(context: Context) -> TDBadgedCellNoHit {
        let view = TDBadgedCellNoHit(style: style, reuseIdentifier: title)
        
        view.textLabel?.text = title
        view.detailTextLabel?.text = subtitle
        
        view.badgeColor = UIColor(badgeColor)
        view.badgeString = badgeString
        
        return view
    }
        
    func updateUIView(_ uiView: TDBadgedCellNoHit, context: Context) {
        
    }
}

#Preview {
    NavigationStack {
        List {
            NavigationLink {
                Text("Hello, World!")
            } label: {
                TDBadgedCellView(title: "A badged cell", badgeString: "1")
            }
            TDBadgedCellView(
                title: "Yet another one",
                badgeString: "42",
                badgeColor: .red
            )
            TDBadgedCellView(
                title: "One more for the road",
                subtitle: "This is my subtitle",
                badgeString: "Text"
            )
        }
    }
}
