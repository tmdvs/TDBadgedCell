//
//  TDBadgedCellSwiftUIApp.swift
//  TDBadgedCellSwiftUI
//
//  Created by Tim on 21/02/2024.
//  Copyright © 2024 Tim Davies. All rights reserved.
//

import SwiftUI

@main
struct TDBadgedCellSwiftUIDemoApp: App {
    var body: some Scene {
        WindowGroup {
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
    }
}
