//
//  MainSettingViewController.m
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainSettingViewController.h"

@interface MainSettingViewController ()

@end

@implementation MainSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"index.png"] selectedImage:[UIImage imageNamed:@"index-click.png"]];
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
