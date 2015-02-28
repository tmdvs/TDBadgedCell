# TDBadgedCell
TDBadgedCell grew out of the need for TableViewCell badges and the lack of them in iOS (see the [article explaining this on TUAW](http://www.tuaw.com/2010/01/07/iphone-devsugar-simple-table-badges/). TDBadgedCell was written originally using CGPaths but as more people began to use TDBadgeCell the more customisation people wanted. The class works in both ARC and non-ARC projects automatically (thanks [coryallegory](http://github.com/coryallegory)).

To set the content of your badge (NSString) simply do:

```Objective-C
cell.badgeString = @"130990";
```

You can set _badgeColor_ and _badgeColorHighlighted_ to modify the colour of the badges:

```Objective-C
cell.badgeColor = [UIColor colorWithRed:0.792 green:0.197 blue:0.219 alpha:1.000];
```

You can also specify a border radius and font size for your badges:

```Objective-C
cell.badge.radius = 9;
cell.badge.fontSize = 18;
```

Below is an example of those different options enabled in the demo app.

![Example Image](http://up.tmdvs.me/image/401P1Q2i3T00/d)

## Licence and that stuff
TDBadgedCell is a free to use class for everyone. I wrote it so people could have the badges Apple never provided us with. If you modify the source please share alike and if you think you've improved upon what I have written I recomend sending me a pull request.

**Please note:** If you are using TDBadgedCell in your project please make sure you leave credit where credit is due. Chances are I won't notice if you haven't left credit but karma will…
