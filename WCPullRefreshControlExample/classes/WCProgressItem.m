//
//  WCProgressItem.m
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/11.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "WCProgressItem.h"
#import "CAShapeLayer+WCPullRefresh.h"
#import "WCMagicSquareView.h"
static const CGFloat offset = 4.0;
static const CGFloat arrowOffset = 2.0;
@interface WCProgressItem()
@property (strong,nonatomic)CAShapeLayer * shapelayer;
@property (strong,nonatomic)CAShapeLayer * arrowLayer;
@property (nonatomic)WCProgressItemType type;
@property (strong,nonatomic) WCMagicSquareView * squareview;

@end

@implementation WCProgressItem
-(instancetype)initWithFrame:(CGRect)frame Type:(WCProgressItemType)type Color:(UIColor *)color{
    if (self = [super initWithFrame:frame]) {
        switch (type) {
            case WCProgressItemTypeRoundCricle:
                self.shapelayer = [CAShapeLayer createCircleWithBounds: CGRectMake(0,0,frame.size.width,frame.size.height)
                                                              Position:CGPointMake(frame.size.width/2,frame.size.height/2)
                                                           StrokeColor:color
                                                             LineWidth:2.0];
                self.arrowLayer = [CAShapeLayer createArrowLayerWithBound:CGRectMake(0,0,frame.size.width,frame.size.height)
                                                                 Position:CGPointMake(frame.size.width/2,frame.size.height/2)
                                                              StrokeColor:color
                                                                LineWidth:1.0
                                                                   offSet:offset
                                                                arrowSize:arrowOffset];
                [self.layer addSublayer:self.arrowLayer];
                [self.layer addSublayer:self.shapelayer];
                break;
            case WCProgressItemTypeStar:
                self.shapelayer = [CAShapeLayer create25_25StarLayerWithStrokeColor:[UIColor blueColor] LineWidth:2.0];
                [self.layer addSublayer:self.shapelayer];
                break;
            case WCProgressItemTypeMagicSquare:
                self.frame = CGRectMake(0,0,320,20);
                self.squareview = [[WCMagicSquareView alloc] initWithProgress:0.0 Color:color MaxWidth:320];
                [self addSubview:self.squareview];
                break;
            default:
                break;
        }
        self.shapelayer.strokeStart = 0.0;
        self.shapelayer.strokeEnd = 0.0;
        self.type = type;
    }
    return self;
}
-(void)LogFrame:(CGRect)rect{
    NSLog(@"%f %f %f %f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
}
-(void)setProgress:(CGFloat)progress{
    switch (self.type) {
        case WCProgressItemTypeRoundCricle:
            _progress = progress*0.95;
            self.shapelayer.strokeStart = 0.05;
            self.shapelayer.strokeEnd = _progress;

            break;
        case WCProgressItemTypeStar:
            _progress = progress;
            self.shapelayer.strokeEnd = _progress;
            break;
        case WCProgressItemTypeMagicSquare:
            _progress = progress;
            self.squareview.progress = _progress;
        default:
            break;
    }
}
@end
