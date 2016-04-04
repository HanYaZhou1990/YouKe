//
//  PublicSource.h
//  YouKe
//
//  Created by 韩亚周 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#ifndef PublicSource_h
#define PublicSource_h

#import "BaseHelper.h"

    //自定义一个设置颜色的方法，可以根据十六进制数据来设置颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/*自定义一个设置颜色的方法，可以根据十六进制数据来设置颜色,可以设置alpha*/
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//屏幕尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) //屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) //屏幕高度

#define YKusercode       [[NSUserDefaults standardUserDefaults] valueForKey:@"usercode"]//用户id
#define YKpassword       [[NSUserDefaults standardUserDefaults] valueForKey:@"password"]//用户密码
#define YKbasehost      [[NSUserDefaults standardUserDefaults] valueForKey:@"basehost"]//服务器地址

#endif /* PublicSource_h */
