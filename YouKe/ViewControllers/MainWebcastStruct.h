//
//  MainWebcastStruct.h
//  YouKe
//
//  Created by wwr on 16/4/4.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import <Foundation/Foundation.h>
    //直播协议结构体
@interface MainWebcastStruct : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *type;

- (id)initWithDictionary:(NSDictionary *)userDictionary;

@end
