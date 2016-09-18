# TDBadgedCell
TDBadgedCell grew out of the need for TableViewCell badges and the lack of them in iOS (see the [article explaining this on TUAW](http://www.tuaw.com/2010/01/07/iphone-devsugar-simple-table-badges/). Recently the project has been re-written in Swift and much simplified.

***Note:*** *You can find the old Objective-C version on the [deprecetated-objective-c branch](https://github.com/tmdvs/TDBadgedCell/tree/deprecated-objective-c)*.

<img src="http://up.tmdvs.me/hOlw/d" width="432">&nbsp;
<img src="http://up.tmdvs.me/hVRS/d" width="432">

To set the content of your badge (String) simply do:

```Swift
cell.badgeString = "Hello, World!"
```

You can set _badgeColor_ and _badgeColorHighlighted_ to modify the colour of the badges:

```Swift
cell.badgeColor = UIColor.orangeColor()
```

You can also specify a border radius and font size for your badges:

```Swift
cell.badgeRadius = 9;
cell.badgeFontSize = 18;
```

## Licence and that stuff
TDBadgedCell is a free to use class for everyone. I wrote it so people could have the badges Apple never provided us with. If you modify the source please share alike and if you think you've improved upon what I have written I recommend sending me a pull request.

**Please note:** If you are using TDBadgedCell in your project please make sure you leave credit where credit is due. Chances are I won't notice if you haven't left credit but karma will…
