//
//  ViewController.swift
//  TDBadgedCell
//
//  Created by Tim Davies on 07/09/2016.
//  Copyright © 2016 Tim Davies. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let demoItems : [[String:String]] = [
        ["title" : "This is an example badge", "badge": "1"],
        ["title" : "This is a second example badge", "badge": "25"],
        ["title" : "A text badge", "badge": "Warning!"],
        ["title" : "Another text badge", "badge": "Danger!"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoItems.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> TDBadgedCell {
        var cell : TDBadgedCell? = tableView.dequeueReusableCell(withIdentifier:"BadgedCell") as! TDBadgedCell?;
        if((cell == nil)) {
            cell = TDBadgedCell(style: .default, reuseIdentifier: "BadgedCell");
        }
        
        // Set accessory views for two badges
        if(indexPath.row < 2) {
            cell?.accessoryType = .disclosureIndicator
        }
        
        cell?.textLabel!.text = demoItems[indexPath.row]["title"]
        cell?.badgeString = demoItems[indexPath.row]["badge"]!
        
        // Set background colours for two badges
        if(indexPath.row == 2) {
            cell?.badgeColor = .orange
        } else if(indexPath.row == 3) {
            cell?.badgeColor = .red
        }
        
        return cell!
    }
}

