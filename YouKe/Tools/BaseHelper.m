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


    //提示框
+ (void)waringInfo:(NSString *)msgInfo
{
    
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                  message:msgInfo
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil,nil];
    [alert show];
}

    //字典转化为字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (dic!=nil)
        {
        NSError *parseError = nil;
        NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    return @"";
    
}

    //字符串转化为字典
+ (NSDictionary *)jsonToDictionary:(NSString *)str
{
    if (str!=nil)
        {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        return dic;
        }
    return nil;
}

@end
