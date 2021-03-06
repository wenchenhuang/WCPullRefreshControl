//
//  WCGraintCircleLayer.m
//  WCGraintCircleView
//
//  Created by huangwenchen on 15/4/24.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "WCGraintCircleLayer.h"
@interface WCGraintCircleLayer()
@property (strong,nonatomic)CAShapeLayer * maskShapeLayer;
@end

@implementation WCGraintCircleLayer
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.maskShapeLayer.strokeEnd = progress;
    self.maskShapeLayer.strokeEnd = 0.015 + (0.985-0.015)*progress;
}
-(instancetype)initGraintCircleWithBounds:(CGRect)bounds Position:(CGPoint)position FromColor:(UIColor *)fromColor ToColor:(UIColor *)toColor LineWidth:(CGFloat) linewidth{
    if (self = [super init]) {
        self.bounds = bounds;
        self.position = position;
        NSArray * colors = [self graintFromColor:fromColor ToColor:toColor Count:4.0];
        for (int i = 0; i < colors.count -1; i++) {
            CAGradientLayer * graint = [CAGradientLayer layer];
            graint.bounds = CGRectMake(0,0,CGRectGetWidth(bounds)/2,CGRectGetHeight(bounds)/2);
            NSValue * valuePoint = [[self positionArrayWithMainBounds:self.bounds] objectAtIndex:i];
            graint.position = valuePoint.CGPointValue;
            UIColor * fromColor = colors[i];
            UIColor * toColor = colors[i+1];
            NSArray *colors = [NSArray arrayWithObjects:(id)fromColor.CGColor, toColor.CGColor, nil];
            NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
            NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
            NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
            graint.colors = colors;
            graint.locations = locations;
            graint.startPoint = ((NSValue *)[[self startPoints] objectAtIndex:i]).CGPointValue;
            graint.endPoint = ((NSValue *)[[self endPoints] objectAtIndex:i]).CGPointValue;
            [self addSublayer:graint];
            //Set mask
            self.maskShapeLayer = [CAShapeLayer layer];
            CGRect rect = CGRectMake(0,0,CGRectGetWidth(self.bounds) - 2 * linewidth, CGRectGetHeight(self.bounds) - 2 * linewidth);
            self.maskShapeLayer.bounds = rect;
            self.maskShapeLayer.position = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
            self.maskShapeLayer.strokeColor = [UIColor blueColor].CGColor;
            self.maskShapeLayer.fillColor = [UIColor clearColor].CGColor;
            self.maskShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:CGRectGetWidth(rect)/2].CGPath;
            self.maskShapeLayer.lineWidth = linewidth;
            self.maskShapeLayer.lineCap = kCALineCapRound;
            self.maskShapeLayer.strokeStart = 0.015;
            self.maskShapeLayer.strokeEnd = 0.985;
            [self setMask:self.maskShapeLayer];
        }
    }
    return self;
}
-(NSArray *)positionArrayWithMainBounds:(CGRect)bounds{
    CGPoint first = CGPointMake(CGRectGetWidth(bounds)/4 *3, CGRectGetHeight(bounds)/4 *1);
    CGPoint second = CGPointMake(CGRectGetWidth(bounds)/4 *3, CGRectGetHeight(bounds)/4 *3);
    CGPoint thrid = CGPointMake(CGRectGetWidth(bounds)/4 *1, CGRectGetHeight(bounds)/4 *3);
    CGPoint fourth = CGPointMake(CGRectGetWidth(bounds)/4 *1, CGRectGetHeight(bounds)/4 *1);
    return @[[NSValue valueWithCGPoint:first],
             [NSValue valueWithCGPoint:second],
             [NSValue valueWithCGPoint:thrid],
             [NSValue valueWithCGPoint:fourth]];
}
-(NSArray *)startPoints{
    return @[[NSValue valueWithCGPoint:CGPointMake(0,0)],
             [NSValue valueWithCGPoint:CGPointMake(1,0)],
             [NSValue valueWithCGPoint:CGPointMake(1,1)],
             [NSValue valueWithCGPoint:CGPointMake(0,1)]];
}
-(NSArray *)endPoints{
    return @[[NSValue valueWithCGPoint:CGPointMake(1,1)],
             [NSValue valueWithCGPoint:CGPointMake(0,1)],
             [NSValue valueWithCGPoint:CGPointMake(0,0)],
             [NSValue valueWithCGPoint:CGPointMake(1,0)]];
}
-(NSArray *)graintFromColor:(UIColor *)fromColor ToColor:(UIColor *)toColor Count:(NSInteger)count{
    CGFloat fromR = 0.0,fromG = 0.0,fromB = 0.0,fromAlpha = 0.0;
    [fromColor getRed:&fromR green:&fromG blue:&fromB alpha:&fromAlpha];
    CGFloat toR = 0.0,toG = 0.0,toB = 0.0,toAlpha = 0.0;
    [toColor getRed:&toR green:&toG blue:&toB alpha:&toAlpha];
    NSMutableArray * result = [[NSMutableArray alloc] init];
    for (int i = 0; i <= count; i++) {
        CGFloat oneR = fromR + (toR - fromR)/count * i;
        CGFloat oneG = fromG + (toG - fromG)/count * i;
        CGFloat oneB = fromB + (toB - fromB)/count * i;
        CGFloat oneAlpha = fromAlpha + (toAlpha - fromAlpha)/count * i;
        UIColor * onecolor = [UIColor colorWithRed:oneR green:oneG blue:oneB alpha:oneAlpha];
        [result addObject:onecolor];
    }
    //    [result addObject:[self midColorWithFromColor:fromColor ToColor:toColor Progress:0.0]];
    //    [result addObject:[self midColorWithFromColor:fromColor ToColor:toColor Progress:0.2]];
    //    [result addObject:[self midColorWithFromColor:fromColor ToColor:toColor Progress:0.4]];
    //    [result addObject:[self midColorWithFromColor:fromColor ToColor:toColor Progress:0.6]];
    //    [result addObject:[self midColorWithFromColor:fromColor ToColor:toColor Progress:1.0]];
    
    return result;
}
-(UIColor *)midColorWithFromColor:(UIColor *)fromColor ToColor:(UIColor*)toColor Progress:(CGFloat)progress{
    CGFloat fromR = 0.0,fromG = 0.0,fromB = 0.0,fromAlpha = 0.0;
    [fromColor getRed:&fromR green:&fromG blue:&fromB alpha:&fromAlpha];
    CGFloat toR = 0.0,toG = 0.0,toB = 0.0,toAlpha = 0.0;
    [toColor getRed:&toR green:&toG blue:&toB alpha:&toAlpha];
    CGFloat oneR = fromR + (toR - fromR) * progress;
    CGFloat oneG = fromG + (toG - fromG) * progress;
    CGFloat oneB = fromB + (toB - fromB) * progress;
    CGFloat oneAlpha = fromAlpha + (toAlpha - fromAlpha) * progress;
    UIColor * onecolor = [UIColor colorWithRed:oneR green:oneG blue:oneB alpha:oneAlpha];
    return onecolor;
}

@end
