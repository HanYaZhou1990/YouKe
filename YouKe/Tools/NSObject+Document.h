//
//  NSObject+Document.h
//  YouKe
//
//  Created by 韩亚周 on 16/4/5.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Document)

+ (NSObject *)defaultLibrary;
/*!沙盒路径*/
+ (NSString *)documentPath;
+ (BOOL)saveData2Table:(NSString *)tableName;

@end
