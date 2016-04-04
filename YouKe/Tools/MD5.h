//
//  MD5.h
//  YouKe
//
//  Created by 韩亚周 on 16/4/4.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

/*!MD5加密*/
@interface MD5 : NSObject

+ (NSString *)md5HexDigest:(NSString*)input;

@end
