//
//  WebviewViewController.m
//  WCPullRefreshControlExample
//
//  Created by huangwenchen on 15/4/23.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "WebviewViewController.h"
#import "WCSimplePullRefreshControl.h"
@interface WebviewViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (strong,nonatomic) WCSimplePullRefreshControl * pullRefresh;

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@end

@implementation WebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.baidu.com"]];
    [self.webview loadRequest:request];
    self.webview.scrollView.delegate = self;
    self.webview.delegate = self;
//    self.webview.backgroundColor = [UIColor blueColor];
    self.pullRefresh = [[WCSimplePullRefreshControl alloc] initWithScrollview:self.webview.scrollView Action:^{
        [self.webview reload];
    }];
    // Do any additional setup after loading the view.
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
