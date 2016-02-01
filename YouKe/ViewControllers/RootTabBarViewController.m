//
//  RootTabBarViewController.m
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "RootTabBarViewController.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc]init];
    
    /*首页*/
    MainViewController *main = [[MainViewController alloc]init];
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:main];
    [viewControllers addObject:mainNav];
    
    /*新闻*/
    MainNewsViewController *nesViewController = [[MainNewsViewController alloc]init];
    UINavigationController *nesNav = [[UINavigationController alloc]initWithRootViewController:nesViewController];
    [viewControllers addObject:nesNav];
    
    /*直播*/
    MainWebcastViewController *webcastViewController = [[MainWebcastViewController alloc]init];
    UINavigationController *webcastNav = [[UINavigationController alloc]initWithRootViewController:webcastViewController];
    [viewControllers addObject:webcastNav];
    
    /*设置*/
    MainSettingViewController *settingViewController = [[MainSettingViewController alloc]init];
    UINavigationController *settingNav = [[UINavigationController alloc]initWithRootViewController:settingViewController];
    [viewControllers addObject:settingNav];
    
    self.viewControllers = viewControllers;
    
    self.tabBar.tintColor = UIColorFromRGB(0x2B9D43);
    
        //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x2B9D43),
      NSForegroundColorAttributeName,
      nil]forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
