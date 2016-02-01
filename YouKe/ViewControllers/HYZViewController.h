//
//  HYZViewController.h
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYZ+Color.h"

    //自定义一个设置颜色的方法，可以根据十六进制数据来设置颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/*自定义一个设置颜色的方法，可以根据十六进制数据来设置颜色,可以设置alpha*/
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

/*! 所有页面的父类*/
@interface HYZViewController : UIViewController

@end
