//
//  WCSimplePullRefreshControl.h
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/13.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCPullRefreshControl.h"
#import "WCProgressItem.h"
#import "WCRefreshingItem.h"
@interface WCSimplePullRefreshControl :WCPullRefreshControl
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
