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
        ["title" : "Another text badge with offset from the left", "badge": "1!"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:"BadgedCell") as? TDBadgedCell

        if cell == nil {
            cell = TDBadgedCell(style: .default, reuseIdentifier: "BadgedCell")
        }

        let item = demoItems[indexPath.row]

        cell?.textLabel!.text = item["title"]
        cell?.detailTextLabel?.text = item["title"]
        cell?.badgeString = item["badge"] ?? ""

        switch indexPath.row {
        case 0:
            // Set accessory view
            cell?.accessoryType = .disclosureIndicator
        case 1:
            // Set accessory view
            cell?.badgeColor = .lightGray
            cell?.badgeTextColor = .black
            cell?.accessoryType = .checkmark
        case 2:
            //Set background colours for badge
             cell?.badgeColor = .orange
        case 3:
            //Set background colours for badge
             cell?.badgeColor = .red
        case 4:
            //Set badge title offset from left
            cell?.badgeTextOffset = 5.0
        default:
            break
        }

    // Uncomment this to test with dynamic type.
//    cell?.badgeTextStyle = .caption1

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
