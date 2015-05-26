//
//  WCPullRefreshControl.h
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/13.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+WCPullRefresh.h"
#import "WCProgressItem.h"
#import "WCRefreshingItem.h"
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
-(void)updateWhenScrollDidEndDraging;
-(void)finishRefreshingSuccessully:(BOOL)success;
//-(void)manualStartRefreshingWithAction:(WCRefreshAction)action;
-(void)manualStartRefreshingWithAction;
/*!
 * @discussion Main init mtehod, you can custom the refreshcontrol as you like
 * @param scrollview The scrollview that you attached to.Such as tableview,webview,collectview
 * @param action The action that excute during refreshing.Such as fetching something from internet
 * @param progressType Type of progresssview
 * @param refreshingType Type of refreshingview
 * @param date Last update.If you want the refreshcontrol to show lastupdate.This can not be nil.
 * @param isShowLastUpdate Whether to show last update date
 * @param textcolor Color of textlabel
 * @param progressColor Color of progress and refreshing item
 * @param pullHeight Max length to trigger refreshing action
 * @return UIView *
 */
-(instancetype)initWithScrollview:(UIScrollView *)scrollview
                           Action:(WCRefreshAction) action
                     progressItem:(WCProgressItemType)progressType
                   refreshingItem:(WCRefreshingItemType)refreshingType
                       lastUpdate:(NSDate *)date
                   showLastUpdate:(BOOL)isShowLastUpdate
                        textColor:(UIColor *)textcolor
                        itemColor:(UIColor *)progressColor
                       pullHeight:(CGFloat)pullHeight;
-(instancetype)initWithScrollview:(UIScrollView *)scrollview
                           Action:(WCRefreshAction) action;

-(instancetype)initWithScrollview:(UIScrollView *)scrollview
                           Action:(WCRefreshAction) action
                       lastUpdate:(NSDate *)date
                   showLastUpdate:(BOOL)isShowLastUpdate;
@end
