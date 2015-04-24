//
//  WCProgressItem.h
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/11.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, WCProgressItemType) {
    WCProgressItemTypeRoundCricle = 0,
    WCProgressItemTypeStar = 1,
    WCProgressItemTypeMagicSquare = 2,
    WCProgressItemTypeGradientCircle = 3,
};
@interface WCProgressItem : UIView
-(instancetype)initWithFrame:(CGRect)frame Type:(WCProgressItemType)type Color:(UIColor *)color;
@property(nonatomic)CGFloat progress;
@end
