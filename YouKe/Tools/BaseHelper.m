//
//  BaseHelper.m
//  YouKe
//
//  Created by wwr on 16/4/4.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "BaseHelper.h"
#import "PublicSource.h"
@implementation BaseHelper

+ (NSString *)isSpaceString:(NSString *)firstStr andReplace:(NSString *)replaceStr
{
    if ([firstStr isKindOfClass:[NSNull class]] || firstStr == nil | firstStr.length == 0)
        {
        return replaceStr;
        }
    else
        {
        firstStr = [firstStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
        
        if ([firstStr isEqualToString:@""])
            {
            return replaceStr;
            }
        else
            return firstStr;
        }
}

    //判断服务器地址是否可用
+(BOOL)isCanUseHost
{
    BOOL  isCanUse = YES;
     NSString *baseUrl = [self isSpaceString:[[NSUserDefaults standardUserDefaults] valueForKey:@"basehost"] andReplace:@""];
    if (baseUrl.length==0)
        {
        isCanUse = NO;
        }
    return isCanUse;
}

@end
