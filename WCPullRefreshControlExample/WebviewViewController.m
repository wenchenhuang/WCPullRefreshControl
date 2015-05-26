//
//  WebviewViewController.m
//  WCPullRefreshControlExample
//
//  Created by huangwenchen on 15/4/23.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "WebviewViewController.h"
#import "WCPullRefreshControl.h"
@interface WebviewViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (strong,nonatomic) WCPullRefreshControl * pullRefresh;

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (strong,nonatomic) NSURLRequest * request;
@end

@implementation WebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]];
    self.webview.scrollView.delegate = self;
    self.webview.delegate = self;
    self.pullRefresh = [[WCPullRefreshControl alloc] initWithScrollview:self.webview.scrollView
                                                                       Action:^{
                                                                           if (self.webview.isLoading) {
                                                                               [self.webview stopLoading];
                                                                           }
                                                                           [self.webview loadRequest:self.request];
                                                                       }
                                                                 progressItem:WCProgressItemTypeMagicSquare
                                                               refreshingItem:WCRefreshingItemTypeMagicSquare
                                                                   lastUpdate:[NSDate date]
                                                               showLastUpdate:YES
                                                                    textColor:[UIColor blueColor]
                                                                    itemColor:[UIColor lightGrayColor]
                                                                   pullHeight:64];
}
-(void)viewDidAppear:(BOOL)animated{
    [self.pullRefresh manualStartRefreshingWithAction];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.pullRefresh finishRefreshingSuccessully:true];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.pullRefresh finishRefreshingSuccessully:false];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.pullRefresh updateWhenScrollDidEndDraging];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.pullRefresh updateWhenScrollviewScroll];
}

@end
