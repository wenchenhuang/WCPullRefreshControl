//
//  CAShapeLayer+WCPullRefresh.h
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/13.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CAShapeLayer (WCPullRefresh)
+(CAShapeLayer *)createCircleWithBounds:(CGRect)bounds
                               Position:(CGPoint)position
                            StrokeColor:(UIColor*)color
                              LineWidth:(CGFloat)lineWidth;

+(CAShapeLayer *)createArrowLayerWithBound:(CGRect)bounds
                            Position:(CGPoint)position
                         StrokeColor:(UIColor *)color
                           LineWidth:(CGFloat)lineWidth
                              offSet:(CGFloat)offset
                           arrowSize:(CGFloat)arrowSize;
+(CAShapeLayer *)create25_25StarLayerWithStrokeColor:(UIColor*)color
                            LineWidth:(CGFloat)lineWidth;
@end
