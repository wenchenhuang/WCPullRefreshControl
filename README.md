# WCPullRefreshControl
An IOS pull refresh library
WCPullRefreshControl
===========
##Support
* Support different kinds of scrollview,such as UIScrollview,tableview,webview.
* Support custom refreshing view. 

 <img src="https://raw.github.com/wenchenhuang/WCPullRefreshControl/master/BlueRoundCircle.gif" width="320" />

Custom view

<img src="https://raw.github.com/wenchenhuang/WCPullRefreshControl/master/RoundCircle.gif" width="320" />

* Support different kinds of device size(Iphone,ipad,not apple watch)

<img src="https://raw.github.com/wenchenhuang/WCPullRefreshControl/master/Ipad.gif" width="320" />

* Support Device orientation

<img src="https://raw.github.com/wenchenhuang/WCPullRefreshControl/master/ori.gif" width="500" />


* Support mix different progress and refreshing item Together(Up to 3*4=12 kinds)
<img src="https://raw.github.com/wenchenhuang/WCPullRefreshControl/master/mix.gif" width="640"/>


## Installation

1. Download the latest code version.
2. Open your project in Xcode, then drag and drop `classes folder` into your project. Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. Wherever you need it, just `WCSimplePullRefreshControl.h"`

## Usage

###Simple way
*  Keep a property of WCPullRefreshControl,let your class conforms to UIScrollveiwDelegate
*  Initialise and use block to pass in refreshing action(Maybe fetching something from internet)
*  When refreshing action finished call `finishRefreshingSuccessully`
Sample


```objective-c
@interface DemoTableview()<UIScrollViewDelegate,WCPullRefreshControlDelegate>
@property (strong,nonatomic)WCSimplePullRefreshControl * pullRefresh;

@end

@implementation DemoTableview
-(void)viewDidLoad{
    self.pullRefresh = [[WCSimplePullRefreshControl alloc] initWithScrollview:self.tableView Action:^{
        [self performSelector:@selector(reset) withObject:nil afterDelay:2.0];
    }];
}
-(void)reset{
    [self.pullRefresh finishRefreshingSuccessully:YES];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.pullRefresh updateWHenScrollDidEndDraging];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.pullRefresh updateWhenScrollviewScroll];
}
````
###Custom refreshcontrol
* Keep a property of WCRefreshControl,and let your class conforms to UIScrollveiwDelegate and WCPullRefreshControlDelegate.
* Use complex init method to custom pull refresh and set delegate to self
* Use delegate to handle refreshing action
Sample

```objective-c
@interface DemoTableview()<UIScrollViewDelegate,WCPullRefreshControlDelegate>
@property (strong,nonatomic)WCSimplePullRefreshControl * pullRefresh;

@end

@implementation DemoTableview
-(void)viewDidLoad{
    self.pullRefresh = [[WCSimplePullRefreshControl alloc] initWithScrollview:self.tableView
Action:^{

}
                                                                 progressItem:WCProgressItemTypeMagicSquare
                                                               refreshingItem:WCRefreshingItemTypeMagicSquare
                                                                   lastUpdate:nil
                                                               showLastUpdate:YES
                                                                    textColor:[UIColor purpleColor]
                                                                    itemColor:[UIColor grayColor]
                                                                   pullHeight:64];
    self.pullRefresh.delegate = self;
}
-(void)reset{
    [self.pullRefresh finishRefreshingSuccessully:YES];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.pullRefresh updateWHenScrollDidEndDraging];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.pullRefresh updateWhenScrollviewScroll];
}
-(void)DidStartRefreshingWithScrollview:(UIScrollView *)scrollview{
    [self performSelector:@selector(reset) withObject:nil afterDelay:2.0];
}

```


## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE). 
## Bug
If you find bug,please send email to njuhwc@163.com


