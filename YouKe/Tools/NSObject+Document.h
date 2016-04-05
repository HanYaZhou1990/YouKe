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
/*!保存数据到某个表中*/
+ (BOOL)save:(NSDictionary *)dataDictionary toTable:(NSString *)tableName;
/*!获取某个表中的所有数据*/
+ (NSDictionary *)getDataWithTable:(NSString *)tableName;
/*!删除某个表中的某条数据*/
+ (BOOL)deleteDataWithTable:(NSString *)tableName andIndex:(NSInteger)index;
/*!判断有没有某个文件*/
+ (BOOL)fileIsExists:(NSString*)tableName;

@end
