//
//  WCRefreshingItem.h
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/11.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, WCRefreshingItemType) {
    WCRefreshingItemTypeSystemIndicator,
    WCRefreshingItemTypeRoundCircle,
    WCRefreshingItemTypeStar,
    WCRefreshingItemTypeMagicSquare,
    WCRefreshingItemTypeGradientCircle,

};
@interface WCRefreshingItem : UIView
-(instancetype)initWithFrame:(CGRect)frame Type:(WCRefreshingItemType)type Color:(UIColor *)color;
-(void)startAnimating;
-(void)stopAnimating;
@end
