//
//  CAShapeLayer+WCPullRefresh.m
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/13.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "CAShapeLayer+WCPullRefresh.h"

@implementation CAShapeLayer (WCPullRefresh)
+(CAShapeLayer *)createCircleWithBounds:(CGRect)bounds
                               Position:(CGPoint)position
                            StrokeColor:(UIColor*)color
                              LineWidth:(CGFloat)lineWidth
{
    CAShapeLayer* shapelayer = [CAShapeLayer layer];
    shapelayer.strokeColor = color.CGColor;
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.path = [UIBezierPath bezierPathWithRoundedRect:bounds  cornerRadius:CGRectGetWidth(bounds)/2].CGPath;
    shapelayer.bounds = bounds;
    shapelayer.position = position;
    shapelayer.lineCap = kCALineCapRound;
    shapelayer.lineWidth = 2.0;
    return shapelayer;
}
+(CAShapeLayer *)createArrowLayerWithBound:(CGRect)bounds
                            Position:(CGPoint)position
                         StrokeColor:(UIColor *)color
                           LineWidth:(CGFloat)lineWidth
                              offSet:(CGFloat)offset
                           arrowSize:(CGFloat)arrowSize
{
    CAShapeLayer * arrowLayer = [CAShapeLayer layer];
    arrowLayer.strokeColor = color.CGColor;
    arrowLayer.lineCap = kCALineCapSquare;
    arrowLayer.bounds = bounds;
    arrowLayer.position = position;
    arrowLayer.lineWidth = 1.0;
    arrowLayer.fillColor = [UIColor clearColor].CGColor;
    CGMutablePathRef arrowpath = CGPathCreateMutable();
    CGPathMoveToPoint(arrowpath,nil,CGRectGetMidX(bounds) ,CGRectGetMaxY(bounds)-offset);
    CGPathAddLineToPoint(arrowpath,nil,CGRectGetMidX(bounds),offset);
    CGPathMoveToPoint(arrowpath,nil,CGRectGetMidX(bounds) ,CGRectGetMaxY(bounds) -offset);
    CGPathAddLineToPoint(arrowpath,nil,CGRectGetMidX(bounds) + arrowSize,CGRectGetMaxY(bounds) - offset - arrowSize);
    CGPathMoveToPoint(arrowpath,nil,CGRectGetMidX(bounds) ,CGRectGetMaxY(bounds) -offset);
    CGPathAddLineToPoint(arrowpath,nil,CGRectGetMidX(bounds) - arrowSize,CGRectGetMaxY(bounds) - offset - arrowSize);
    arrowLayer.path = arrowpath;
    return arrowLayer;
}
+(CAShapeLayer *)create25_25StarLayerWithStrokeColor:(UIColor*)color
                                           LineWidth:(CGFloat)lineWidth
{
    
    CAShapeLayer * starLayer = [CAShapeLayer layer];
    UIBezierPath* starPath = UIBezierPath.bezierPath;
    [starPath moveToPoint: CGPointMake(12.5, 0)];
    [starPath addLineToPoint: CGPointMake(16.91, 6.43)];
    [starPath addLineToPoint: CGPointMake(24.39, 8.64)];
    [starPath addLineToPoint: CGPointMake(19.63, 14.82)];
    [starPath addLineToPoint: CGPointMake(19.85, 22.61)];
    [starPath addLineToPoint: CGPointMake(12.5, 20)];
    [starPath addLineToPoint: CGPointMake(5.15, 22.61)];
    [starPath addLineToPoint: CGPointMake(5.37, 14.82)];
    [starPath addLineToPoint: CGPointMake(0.61, 8.64)];
    [starPath addLineToPoint: CGPointMake(8.09, 6.43)];
    [starPath closePath];
    starLayer.path = starPath.CGPath;
    starLayer.strokeColor = color.CGColor;
    starLayer.fillColor = [UIColor clearColor].CGColor;
    starLayer.lineJoin = kCALineJoinMiter;
    starLayer.lineWidth = lineWidth;
    starLayer.bounds = CGRectMake(0,0,25.0,25.0);
    starLayer.position = CGPointMake(12.5,12.5);
    return starLayer;
}
@end
