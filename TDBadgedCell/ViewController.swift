//
//  ViewController.swift
//  TDBadgedCell
//
//  Created by Tim Davies on 07/09/2016.
//  Copyright © 2016 Tim Davies. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    /// List of example table view cells
    let demoItems : [[String:String]] = [
        ["title" : "This is an example badge", "badge": "1"],
        ["title" : "This is a second example badge", "badge": "123"],
        ["title" : "A text badge", "badge": "Warning!"],
        ["title" : "Another text badge with a really long title!", "badge": "Danger!"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> TDBadgedCell {
        var cell : TDBadgedCell? = tableView.dequeueReusableCell(withIdentifier:"BadgedCell") as! TDBadgedCell?;
        if((cell == nil)) {
            cell = TDBadgedCell(style: .default, reuseIdentifier: "BadgedCell");
        }
        
        
        cell?.textLabel!.text = demoItems[indexPath.row]["title"]
        cell?.badgeString = demoItems[indexPath.row]["badge"]!
        
        // Set accessory views for two badges
        if(indexPath.row == 0) {
            cell?.accessoryType = .disclosureIndicator
        }
        
        if(indexPath.row == 1) {
            cell?.badgeColor = .lightGray
            cell?.badgeTextColor = .black
            cell?.accessoryType = .checkmark
        }
        
        // Set background colours for two badges
        if(indexPath.row == 2) {
            cell?.badgeColor = .orange
        } else if(indexPath.row == 3) {
            cell?.badgeColor = .red
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

