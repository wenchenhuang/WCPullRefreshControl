# WCPullRefreshControl

WCPullRefreshControl is a  "Pull refresh" library. It is quite easy to add "Pull refresh" to your project with just several lines of code.

===========
##What is it looks like

 <img src="https://raw.github.com/wenchenhuang/WCPullRefreshControl/master/BlueRoundCircle.gif" width="320" />
 <img src="https://raw.github.com/wenchenhuang/WCPullRefreshControl/master/magic.gif" width="320" />
<img src="https://raw.github.com/wenchenhuang/WCPullRefreshControl/master/mix.gif" width="640"/>
 ===========

##Features

* Support different kinds of scrollview,such as UIScrollview,tableview,webview.
* Support different kinds of device size(Iphone,ipad)
* Support Device orientation


===========
##Requirements

* ARC

===========

## Installation

1. Download the latest code version.
2. Open your project in Xcode, then drag and drop **classes folder** into your project. Make sure to select Copy items when asked if you extracted the code archive outside of your project.
 
===========

##Getting Started

*  Import `WCSimplePullRefreshControl.h`

*  Keep a property of **WCPullRefreshControl**,let your class conforms to **UIScrollveiwDelegate**

```objective-c
@property (strong,nonatomic)WCSimplePullRefreshControl * pullRefresh;
````

*  Initialise it property if you want to use block to handle refreshing action,just write code in action block

```objective-c
self.pullRefresh = [[WCSimplePullRefreshControl alloc] initWithScrollview:self.tableView Action:^{
        [self performSelector:@selector(reset) withObject:nil afterDelay:2.0];
    }];
````

* Call these two methods in `UIScrollviewDelegate` method
```objective-c
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.pullRefresh updateWhenScrollDidEndDraging];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.pullRefresh updateWhenScrollviewScroll];
}
````

*  When refreshing action finished call `finishRefreshingSuccessully:`,you pass in a Bool to tell refresh control whether refreshing finish successfully or not.

===========
## Delegate
You can set delegate of `WCSimpleRefreshControl` to the class that use it. Note you have to comforms to `WCPullRefreshControlDelegate` first.

Then in delegate method, you can handle refreshing action.
```objective-c
-(void)DidStartRefreshingWithScrollview:(UIScrollView *)scrollview{
	//Handle refreshing action
}
````

===========
## Method
```objective-c
-(instancetype)initWithScrollview:(UIScrollView *)scrollview
                           Action:(WCRefreshAction)action
                     progressItem:(WCProgressItemType)progressType
                   refreshingItem:(WCRefreshingItemType)refreshingType
                       lastUpdate:(NSDate *)date
                   showLastUpdate:(BOOL)isShowLastUpdate
                        textColor:(UIColor *)textcolor
                        itemColor:(UIColor *)itemColor
                       pullHeight:(CGFloat)pullHeight
````
* scrollveiw - the scrollview that you want this view to be attached.
* Action - refreshing action.For example, do some internet fetching
* progressType - define the progress type(3 kinds)
* refreshingType - define the refreshing type(4 kinds)
* date - last update date
* isShowLastUpdate - whether label shows last update date
* textcolor - text color of label
* itemColor - Stroke color of refreshing item and progress item
* pullHeight - length to pull before start to refreshing

===========

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE). 

===========

## Bug
If you find bug,please send email to njuhwc@163.com


