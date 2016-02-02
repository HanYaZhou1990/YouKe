//
//  MainWebcastViewController.m
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainWebcastViewController.h"

@interface MainWebcastViewController ()

@end

@implementation MainWebcastViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"直播" image:[UIImage imageNamed:@"xx_tabbar_icon3_up.png"] selectedImage:[UIImage imageNamed:@"xx_tabbar_icon3_down.png"]];
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xffffff)];
        }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
