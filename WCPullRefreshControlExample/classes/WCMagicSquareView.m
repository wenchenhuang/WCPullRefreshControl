//
//  WCMagicSquareView.m
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/13.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//
#import "WCMagicSquareView.h"
@interface WCMagicSquareView()
@property (strong,nonatomic)UIView * view1;
@property (strong,nonatomic)UIView * view2;
@property (strong,nonatomic)UIView * view3;
@property (strong,nonatomic)UIView * view4;
@property (nonatomic) CGFloat maxwidth;
@end
static const CGFloat space = 5.0;
static const CGFloat squareLength = 15.0;
static const CGFloat speedfast = 1.5;
static const CGFloat speedslow = 1.0;
@implementation WCMagicSquareView
-(void)startAnimating{
    [self addAnimationToView:self.view1 WithDuration:0.45 Delay:0.0];
    [self addAnimationToView:self.view2 WithDuration:0.45 Delay:0.15];
    [self addAnimationToView:self.view3 WithDuration:0.45 Delay:0.30];
    [self addAnimationToView:self.view4 WithDuration:0.45 Delay:0.45];

}

-(void)stopAnimating{
    [self deleteAnimationWith:self.view1];
    [self deleteAnimationWith:self.view2];
    [self deleteAnimationWith:self.view3];
    [self deleteAnimationWith:self.view4];

}
-(NSArray *)keysArray{
    return @[@"view1",@"view2",@"view3",@"view4"];
}
-(NSArray *)centerArray{
    return @[[NSValue valueWithCGPoint:[self centerOfView1]],
             [NSValue valueWithCGPoint:[self centerOfView2]],
             [NSValue valueWithCGPoint:[self centerOfView3]],
             [NSValue valueWithCGPoint:[self centerOfView4]]];
}
-(instancetype)initWithProgress:(CGFloat)progress Color:(UIColor *)color MaxWidth:(CGFloat)maxwidth{
    if (self = [super initWithFrame:CGRectMake(0,0,maxwidth,squareLength)]) {
        self.progress = progress;
        self.maxwidth = maxwidth;
        //Set up view
        for (int index = 0;index < [self centerArray].count;index ++) {
            NSValue * nsCenter = [[self centerArray] objectAtIndex:index];
            NSString * key = [[self keysArray] objectAtIndex:index];
            UIView * oneview = [[UIView alloc] initWithFrame:CGRectMake(0,0,squareLength, squareLength)];
            oneview.layer.cornerRadius = 4.0;
            oneview.backgroundColor = color;
            oneview.center = nsCenter.CGPointValue;
            oneview.alpha = 1.0;
            [self setValue:oneview forKey:key];
            [self addSubview:oneview];
        }
        [self updateAlpha];
    }
    return self;
}
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self updateSubviews];
}
-(void)updateAlpha{
    self.view2.alpha = MIN(1.0,speedslow * self.progress);
    self.view3.alpha = MIN(1.0,speedfast * self.progress);
    self.view1.alpha = MIN(1.0,speedfast * self.progress);
    self.view4.alpha = MIN(1.0,speedslow * self.progress);

}
-(void)addAnimationToView:(UIView *)view WithDuration:(CGFloat)duration Delay:(CGFloat)delay
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:delay];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatCount:99999];
    [UIView setAnimationRepeatAutoreverses:YES];
    view.transform = CGAffineTransformMakeScale(1.0,1.4);
    view.alpha = 0.5;
    [UIView commitAnimations];
}
-(void)deleteAnimationWith:(UIView *)view{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationBeginsFromCurrentState:YES];
    view.transform = CGAffineTransformMakeScale(1.0,1.0);
    view.alpha = 1.0;
    [UIView commitAnimations];
}
-(CGPoint)centerOfView1{
    CGFloat minX = squareLength /2;
    CGFloat maxX = self.maxwidth / 2 - space/2 - squareLength / 2;
    CGFloat x = (maxX- minX)*self.progress*speedfast + minX;
    CGFloat y = 10;
    x = MIN(maxX,x);
    return CGPointMake(x,y);
}
-(CGPoint)centerOfView2{
    CGFloat minX = squareLength /2;
    CGFloat maxX = self.maxwidth / 2 - space/2 * 3 - squareLength / 2*3;
    CGFloat x = (maxX - minX)*self.progress*speedslow + squareLength /2;
    CGFloat y = 10;
    x = MIN(maxX,x);
    return CGPointMake(x,y);
}
-(CGPoint)centerOfView3{
    CGFloat maxX = self.maxwidth - squareLength /2;
    CGFloat minx = self.maxwidth/2 + space/2 + squareLength / 2;
    CGFloat x = maxX - (maxX - minx)*self.progress*speedfast;
    CGFloat y = 10;
    x = MAX(minx,x);
    return CGPointMake(x,y);

}
-(CGPoint)centerOfView4{
    CGFloat maxX = self.maxwidth - squareLength /2;
    CGFloat minx = self.maxwidth/2 + space/2 * 3 + squareLength/2 * 3;
    CGFloat x = maxX - (maxX - minx)*self.progress*speedslow;
    CGFloat y = 10;
    x = MAX(minx,x);
    return CGPointMake(x,y);

}
-(void)updateSubviews{
    self.view1.center = [self centerOfView1];
    self.view2.center = [self centerOfView2];
    self.view3.center = [self centerOfView3];
    self.view4.center = [self centerOfView4];
    [self updateAlpha];
}
@end
