//
//  HYZViewController.m
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "HYZViewController.h"

@interface HYZViewController ()

@end

@implementation HYZViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        /*!修改导航条颜色*/
        self.navigationController.navigationBar.translucent = NO;
        [[UINavigationBar appearance] setBackgroundImage:[UIImage initWithColor:UIColorFromRGB(0x2B9D43)] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[UIImage initWithColor:[UIColor clearColor]]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xEBEBEB);
    [self changeTitleViewTextColor];
    
    UIImage *backImage = [[UIImage imageNamed:@"safari-forward.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    /*设置不显示返回按钮的文字*/
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

- (void)changeTitleViewTextColor
{
    UIColor *color = UIColorFromRGB(0xFFFFFF);
    UIFont *font = [UIFont systemFontOfSize:18];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:color,UITextAttributeTextColor,font,UITextAttributeFont, nil];
    self.navigationController.navigationBar.titleTextAttributes = dic;
#else
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = dic;
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
