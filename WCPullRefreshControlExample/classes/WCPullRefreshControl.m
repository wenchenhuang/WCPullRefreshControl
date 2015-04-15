//
//  WCPullRefreshControl.m
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/13.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

//************
//This is
#import "WCPullRefreshControl.h"

@interface WCPullRefreshControl()

@end
@implementation WCPullRefreshControl
-(void)updateWHenScrollDidEndDraging{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a sublass",NSStringFromSelector(_cmd)];
}
-(void)updateWhenScrollviewScroll{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a sublass",NSStringFromSelector(_cmd)];
}

-(void)finishRefreshingSuccessully:(BOOL)success{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a sublass",NSStringFromSelector(_cmd)];
}


@end
