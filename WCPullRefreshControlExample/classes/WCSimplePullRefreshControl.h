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
