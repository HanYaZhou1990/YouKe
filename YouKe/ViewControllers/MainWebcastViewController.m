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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"直播" forState:UIControlStateNormal];
    leftButton.bounds = CGRectMake(0, 0, 60, 44);
    [leftButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds = CGRectMake(0, 0, 40, 40);
    rightButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [rightButton setImage:[UIImage imageNamed:@"refresh_nor.png"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"refresh_press.png"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(refreshItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)refreshItemClicked:(UIButton *)barItem
{
    NSLog(@"刷新");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
