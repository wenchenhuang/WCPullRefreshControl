//
//  WCMagicSquareView.h
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/13.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "WCPullRefreshControl.h"

@interface WCMagicSquareView : WCPullRefreshControl
-(instancetype)initWithProgress:(CGFloat)progress Color:(UIColor*)color MaxWidth:(CGFloat)maxwidth;
-(void)startAnimating;
-(void)stopAnimating;
@property (nonatomic)CGFloat progress;

@end
