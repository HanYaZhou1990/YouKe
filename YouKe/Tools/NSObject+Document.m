//
//  NSObject+Document.m
//  YouKe
//
//  Created by 韩亚周 on 16/4/5.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "NSObject+Document.h"

@implementation NSObject(Document)

static NSObject *object = nil;
+ (NSObject *)defaultLibrary{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        object = [[NSObject alloc] init];
    });
    
    return object;
}
+ (BOOL)save:(NSDictionary *)dataDictionary toTable:(NSString *)tableName
{
    NSString *filePaht = [[self documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",tableName]];
    return [dataDictionary writeToFile:filePaht atomically:YES];
}

+ (NSString *)documentPath{
    /*获取Documents文件夹目录,第一个参数是说明获取Doucments文件夹目录，第二个参数说明是在当前应用沙盒中获取，所有应用沙盒目录组成一个数组结构的数据存放*/
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [docPath objectAtIndex:0];
    return documentsPath;
}

+(BOOL)fileIsExists:(NSString*)tableName{
    NSString *filePaht = [[self documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",tableName]];
    return [[NSFileManager defaultManager]fileExistsAtPath:filePaht]?YES:NO;
}

@end
