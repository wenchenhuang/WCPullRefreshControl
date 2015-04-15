//
//  NSDate+WCPullRefresh.m
//  WCPullRefreshControl
//
//  Created by huangwenchen on 15/4/13.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "NSDate+WCPullRefresh.h"

@implementation NSDate (WCPullRefresh)
+(NSString *)stringFromLastdate:(NSDate *) lastDate
{
    if (lastDate == nil) {
        return @"This is first update";
    }else{
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *datestr = [formatter stringFromDate:lastDate];
        return [NSString stringWithFormat:@"Last update: %@",datestr];
    }
}
@end
