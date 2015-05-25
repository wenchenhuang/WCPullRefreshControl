//
//  WCRefreshingItem.m
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/11.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "WCRefreshingItem.h"
#import "CAShapeLayer+WCPullRefresh.h"
#import "WCMagicSquareView.h"
#import "WCGraintCircleLayer.h"
@interface WCRefreshingItem()

@property (strong,nonatomic)UIActivityIndicatorView * spinner;
@property (strong,nonatomic)CAShapeLayer * shapelayer;
@property (nonatomic)WCRefreshingItemType type;
@property (strong,nonatomic) WCMagicSquareView * squareview;
@property (strong,nonatomic) WCGraintCircleLayer * graintlayer;
@end

@implementation WCRefreshingItem

-(instancetype)initWithFrame:(CGRect)frame Type:(WCRefreshingItemType)type Color:(UIColor *)color{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        switch (type) {
            case WCRefreshingItemTypeSystemIndicator:
                self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                [self.spinner setColor:color];
                self.spinner.frame  =self.bounds;
                self.spinner.hidesWhenStopped = NO;
                [self addSubview:self.spinner];
                break;
            case WCRefreshingItemTypeRoundCircle:
                self.shapelayer = [CAShapeLayer createCircleWithBounds: CGRectMake(0,0,frame.size.width,frame.size.height)
                                                                Position: CGPointMake(frame.size.width/2,frame.size.height/2)
                                                           StrokeColor: color
                                                             LineWidth:2.0];
                self.shapelayer.strokeStart = 0.0;
                self.shapelayer.strokeEnd = 0.9;
                [self.layer addSublayer:self.shapelayer];
                break;
            case WCRefreshingItemTypeStar:
                self.shapelayer = [CAShapeLayer create25_25StarLayerWithStrokeColor:color LineWidth:2.0];
                [self.layer addSublayer:self.shapelayer];
                break;
            case WCRefreshingItemTypeMagicSquare:
                self.squareview = [[WCMagicSquareView alloc] initWithProgress:1.0 Color:color MaxWidth:320];
                self.frame = CGRectMake(0,0,320,20);
                [self addSubview:self.squareview];
                break;
            case WCRefreshingItemTypeGradientCircle:
                self.graintlayer = [[WCGraintCircleLayer alloc] initGraintCircleWithBounds:CGRectMake(0, 0, frame.size.width, frame.size.height)
                                                                                  Position:CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2)
                                                                                 FromColor:[UIColor clearColor]
                                                                                   ToColor:color
                                                                                 LineWidth:3.0];
                [self.layer addSublayer:self.graintlayer];
                break;
            default:
                break;
        }
      
    }
    return self;
}
-(void)startAnimating{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform";
    animation.values = @[[self transformWithRotation:M_PI* 0.0],
                         [self transformWithRotation:M_PI* 0.5],
                         [self transformWithRotation:M_PI],
                         [self transformWithRotation:M_PI * 1.5],
                         [self transformWithRotation:2*M_PI]];
    animation.duration = 1.0;
    animation.repeatCount = INFINITY;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    switch (self.type) {
        case WCRefreshingItemTypeSystemIndicator:
            [self.spinner startAnimating];
            break;
        case WCRefreshingItemTypeMagicSquare:
            [self.squareview startAnimating];
            break;
        case WCRefreshingItemTypeGradientCircle:
            [self.graintlayer addAnimation:animation forKey:@"rotate"];
            break;
        case WCRefreshingItemTypeRoundCircle:
        case WCRefreshingItemTypeStar:
            [self.shapelayer addAnimation:animation forKey:@"rotate"];

            break;
        default:
            break;
    }
}
-(NSValue *)transformWithRotation:(CGFloat)rotate{
    return  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(rotate,0,0,1)];
}
-(void)stopAnimating{
    switch (self.type) {
        case WCRefreshingItemTypeSystemIndicator:
            [self.spinner stopAnimating];
            break;
        case WCRefreshingItemTypeMagicSquare:
            [self.squareview stopAnimating];
            break;
        case WCRefreshingItemTypeGradientCircle:
        case WCRefreshingItemTypeRoundCircle:
        case WCRefreshingItemTypeStar:
            [self.shapelayer removeAnimationForKey:@"rotate"];
            
            break;
        default:
            break;
    }
}
@end
