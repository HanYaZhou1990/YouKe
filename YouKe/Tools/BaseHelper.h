//
//  BaseHelper.h
//  YouKe
//
//  Created by wwr on 16/4/4.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
@interface BaseHelper : NSObject

+ (NSString *)isSpaceString:(NSString *)firstStr andReplace:(NSString *)replaceStr;

+(BOOL)isCanUseHost;

+ (void)waringInfo:(NSString *)msgInfo;

    //字典转化为字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

    //字符串转化为字典
+ (NSDictionary *)jsonToDictionary:(NSString *)str;
@end
