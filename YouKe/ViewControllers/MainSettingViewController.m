//
//  MainSettingViewController.m
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainSettingViewController.h"
#import "AboutViewController.h"
#import "HostSettingViewController.h"
#import "PlayRecordViewController.h"
#import "MyCollectionViewController.h"

@interface MainSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSArray *datasource;
    NSArray *imgArray;
    BOOL isLogin;
    UIButton *registerBtn;
    UIButton *loginBtn;
}
@end

@implementation MainSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"xx_tabbar_icon4_up.png"] selectedImage:[UIImage imageNamed:@"xx_tabbar_icon4_down.png"]];
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xffffff)];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isLogin=YES;
    [self setTheTableView];
    imgArray = @[@"history",@"collect",@"host",@"about"];
    datasource = @[@"播放记录",@"我的收藏",@"服务器设置",@"关于软件"];
}

//设置表头
-(void)setTableViewHeadView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    headView.backgroundColor = [UIColor clearColor];
    myTableView.tableHeaderView = headView;
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    bgImg.image = [UIImage imageNamed:@"setting_bg"];
    [headView addSubview:bgImg];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(30, (160-50)/2, 50, 50)];
    headImg.image = [UIImage imageNamed:@"person_img"];
    [headView addSubview:headImg];
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(110, 60, SCREEN_WIDTH-110, 40);
    loginBtn.backgroundColor = [UIColor clearColor];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginBtn setTitle:@"点击登录查看更多功能" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [headView addSubview:loginBtn];
    
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(SCREEN_WIDTH-90, 30, 60, 27);
    registerBtn.backgroundColor = [UIColor clearColor];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"btn_register"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:registerBtn];
}

- (void)setTheTableView
{
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStyleGrouped];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundView = nil;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    myTableView.scrollEnabled=NO;
    [self.view addSubview:myTableView];
    [self setTableViewHeadView];
}

-(void)logoutButtonClicked:(id)sender
{
    NSLog(@"退出登录");
    isLogin=NO;
    [myTableView reloadData];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.imageView.image = [UIImage imageNamed:[imgArray objectAtIndex:indexPath.section]];
    cell.textLabel.text = [datasource objectAtIndex:indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0)
    {
        //播放记录
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = @"播放记录";
        self.navigationItem.backBarButtonItem = backButtonItem;
        PlayRecordViewController *vc = [[PlayRecordViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section==1)
    {
        //我的收藏
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = @"我的收藏";
        self.navigationItem.backBarButtonItem = backButtonItem;
        MyCollectionViewController *vc = [[MyCollectionViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section==2)
    {
        //服务器设置
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = @"服务器设置";
        self.navigationItem.backBarButtonItem = backButtonItem;
        HostSettingViewController *vc = [[HostSettingViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section==3)
    {
        //关于软件
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = @"关于软件";
        self.navigationItem.backBarButtonItem = backButtonItem;
        AboutViewController *vc = [[AboutViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3&&isLogin==YES)
    {
        CGFloat bottomHeight = 90;
        UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        logoutButton.frame = CGRectMake(20, bottomHeight-70, SCREEN_WIDTH-40, 50);
        [logoutButton setBackgroundImage:[UIImage imageNamed:@"logoutnormal.png"] forState:UIControlStateNormal];
        [logoutButton setBackgroundImage:[UIImage imageNamed:@"logoutdown.png"] forState:UIControlStateHighlighted];
        [logoutButton setTitle:@"退出" forState:UIControlStateNormal];
        [logoutButton addTarget:self action:@selector(logoutButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, bottomHeight)];
        [footView setBackgroundColor:[UIColor clearColor]];
        [footView addSubview:logoutButton];
        
        return footView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3&&isLogin==YES)
    {
        return 90;
    }
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
