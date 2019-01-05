# TDBadgedCell 
[![Version](https://img.shields.io/cocoapods/v/TDBadgedCell.svg?style=flat-square)](http://cocoapods.org/pods/TDBadgedCell/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square)](https://github.com/Carthage/Carthage)
![Platform](https://img.shields.io/cocoapods/p/TDBadgedCell.svg?style=flat-square)
![License](https://img.shields.io/cocoapods/l/TDBadgedCell.svg?style=flat-square)
![Downloads](https://img.shields.io/cocoapods/dt/TDBadgedCell.svg?style=flat-square)

TDBadgedCell grew out of the need for TableViewCell badges and the lack of them in iOS (see the [article explaining this on ~~TUAW~~ Engadget](https://www.engadget.com/2010/01/07/iphone-devsugar-simple-table-badges/)). Recently the project has been re-written in Swift and much simplified.

<img src="http://up.tmdvs.me/j2a9/d" width="432">&nbsp;
<img src="http://up.tmdvs.me/j23l/d" width="432">

## Usage and examples
TDBadgedCell is designed to be a drop in replacement to UITableViewCell with the added benifit of a simple badge on the right hand side of the cell, similar to those you'll find in Mail.app and Settings.app. All you need to do to implement TDBadgedCell is supply a TDBadgedCell instance in your `cellForRowAt indexPath:` method:

```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  var cell = tableView.dequeueReusableCell(withIdentifier:"BadgedCell") as? TDBadgedCell;
  if(cell == nil) {
    cell = TDBadgedCell(style: .default, reuseIdentifier: "BadgedCell");
  }

  // ...
  
  return cell!
}
```

You can modify the badges appearance in a number of different ways.

- ### Setting badge value
  To set the content of your badge (String) simply do:

  ```Swift
  cell.badgeString = "Hello, World!"
  ```

- ### Changing the badge color
  You can set _badgeColor_ and _badgeColorHighlighted_ to modify the colour of the badges:

  ```Swift
  cell.badgeColor = .orange
  cell.badgeColorHighlighted = .green
  ```

- ### Setting the font size and text color
  By default the badge text will be clipped out of the badge background allowing you to see through to the background colour beneath. However you can specify a text color manually along with the badges font size:

  ```Swift
  cell.badgeTextColor = .black;
  cell.badgeFontSize = 18;
  ```
  
- ### Corner radius
  You can modify the badges corner radius allowing you to change the badges shape from the default "pill" shape to a square or rounded rectangle:
  
  ```Swift
  cell.badgeRadius = 0;
  ```

- ### Badge Offset
  You can set the badge's offset from the right hand side of the Table View Cell
  ```Swift
  cell.badgeOffset = CGPoint(x:10.0, y:0)
  ```

- ### Badge Text Offset
  You can add an offset to the text within the badge
  ```Swift
  cell.badgeTextOffset = 5.0
  ```
  
If you have any feedback or feature requests, simply [open an issue](https://github.com/tmdvs/TDBadgedCell/issues) on the TDBadgedCell github repo.

## Licence and that stuff
TDBadgedCell is a free to use class for everyone. I wrote it so people could have the badges Apple never provided us with. If you modify the source please share alike and if you think you've improved upon what I have written I recommend sending me a pull request.

**Please note:** If you are using TDBadgedCell in your project please make sure you leave credit where credit is due. Chances are I won't notice if you haven't left credit but karma will…
