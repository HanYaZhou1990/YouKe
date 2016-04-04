//
//  MainWebcastStruct.m
//  YouKe
//
//  Created by wwr on 16/4/4.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainWebcastStruct.h"
#import "BaseHelper.h"
@implementation MainWebcastStruct

- (id)initWithDictionary:(NSDictionary *)userDictionary
{
    if (self = [super init])
        {
          _name =[BaseHelper isSpaceString:[userDictionary objectForKey:@"name"] andReplace:@""];
        _url = [BaseHelper isSpaceString:[userDictionary objectForKey:@"url"] andReplace:@""];
        _type = [BaseHelper isSpaceString:[userDictionary objectForKey:@"type"] andReplace:@""];
        }
    return self;
}

@end
