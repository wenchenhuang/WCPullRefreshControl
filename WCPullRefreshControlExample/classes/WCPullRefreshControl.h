//
//  WCPullRefreshControl.h
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/13.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+WCPullRefresh.h"
static const CGFloat defaultPullHeight = 64.0;

typedef enum {
    WCPullRefreshControlStateIdle = 0,
    WCPullRefreshControlStateRefreshing = 1,
    WCPullRefreshControlStateDisappearing = 2
} WCPullRefreshControlState;

typedef void(^WCRefreshAction)(void);
@protocol WCPullRefreshControlDelegate <NSObject>
-(void)DidStartRefreshingWithScrollview:(UIScrollView *)scrollview;
@end


@interface WCPullRefreshControl : UIView
@property (weak,nonatomic)id<WCPullRefreshControlDelegate>delegate;
@property (strong,nonatomic)NSDate * lastUpdateDate;
@property (strong,nonatomic)UIScrollView * attachedScrollView;
@property (nonatomic)CGFloat pullHeight;
-(void)updateWhenScrollviewScroll;
-(void)updateWHenScrollDidEndDraging;
-(void)finishRefreshingSuccessully:(BOOL)success;

@end
