//
//  MainWebcastViewController.m
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainWebcastViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "MainWebcastStruct.h"

@interface MainWebcastViewController ()
{
    NSMutableArray  *datasource;
}
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
    
    datasource = [[NSMutableArray alloc]init];
    
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
    
    if ([BaseHelper isCanUseHost]==YES)
        {
        [self getUseData]; //发送直播协议
        }
}

- (void)refreshItemClicked:(UIButton *)barItem
{
    if ([BaseHelper isCanUseHost]==YES)
        {
        [self getUseData]; //发送直播协议
        }
    else
        {
        [BaseHelper waringInfo:@"服务器地址为空，请去“设置－服务器设置”中设置服务器地址!"];
        }
}

    //获取直播协议
-(void)getUseData
{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useurl = [NSString stringWithFormat:@"http://%@8099/live/json.php",YKbasehost];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    [session GET:useurl
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress){
            /*数据请求的进度*/
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     NSArray *responseArray = (NSArray *)responseObject;
         //打印结果 方便查看
         //NSString *responseString = [BaseHelper dictionaryToJson:responseDic];
         // NSLog(@"返回结果字符串 : %@",responseString);
     if (![responseArray isKindOfClass:[NSNull class]]&&responseArray!=nil){
         if (responseArray.count>0){
         [datasource removeAllObjects];
         for (int i=0; i<responseArray.count; i++){
              NSDictionary *useDic = [responseArray objectAtIndex:i];
             MainWebcastStruct *webcastStruct = [[MainWebcastStruct alloc]initWithDictionary:useDic];
             [datasource addObject:webcastStruct];
         }}}
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     [BaseHelper waringInfo:@"加载失败"];
         // NSLog(@"%@", [error localizedDescription]);
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
