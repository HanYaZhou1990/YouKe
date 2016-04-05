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
#import "MainNewsCell.h"
#import <MediaPlayer/MediaPlayer.h>
@interface MainWebcastViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *datasource;
    UITableView     *useTableView;
}
    //播放器视图控制器
@property (nonatomic,strong) MPMoviePlayerViewController *moviePlayerViewController;
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
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    useTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    useTableView.backgroundColor = [UIColor clearColor];
    [useTableView registerClass:[MainNewsCell class] forCellReuseIdentifier:@"cell"];
    useTableView.dataSource = self;
    useTableView.delegate = self;
    useTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:useTableView];
    
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
    
    NSString *useurl = [NSString stringWithFormat:@"http://%@:8099/live/json.php",YKbasehost];
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
             }
             [useTableView reloadData];
         }}
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     [BaseHelper waringInfo:@"加载失败"];
         // NSLog(@"%@", [error localizedDescription]);
     }];
}

#pragma mark -
#pragma mark UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [datasource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (datasource.count>0)
        {
        MainWebcastStruct *webcastStruct = [datasource objectAtIndex:indexPath.row];
        cell.titleLable.text = webcastStruct.name;
        cell.detailLable.text = @"";
        cell.timeLable.text = @"";
        cell.titleImageView.image = [UIImage imageNamed:@"Icon-180.png"];
        }
    return cell;
}
#pragma mark -
#pragma mark UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        //打开系统播放器 直播
    MainWebcastStruct *webcastStruct = [datasource objectAtIndex:indexPath.row];
    NSString *playUrl = [NSString stringWithFormat:@"http://%@:8080%@.m3u8",YKbasehost,webcastStruct.name];
        //测试直播地址
    playUrl  = @"http://devstreaming.apple.com/videos/wwdc/2015/413eflf3lrh1tyo/413/hls_vod_mvp.m3u8";
    [self playVideoWithUrl:[NSURL URLWithString:playUrl]];
}

#pragma mark - 视频播放器相关
    //网络播放
-(void)playVideoWithUrl:(NSURL *)videoUrl
{
    if (_moviePlayerViewController)
        {
            //保证每次点击都重新创建视频播放控制器视图，避免再次点击时由于不播放的问题
        self.moviePlayerViewController=nil;
        [self deleteNotification];
        }
    _moviePlayerViewController=[[MPMoviePlayerViewController alloc]initWithContentURL:videoUrl];
    [self addNotification];
        //[self presentMoviePlayerViewControllerAnimated:self.moviePlayerViewController];
    [self presentViewController:self.moviePlayerViewController animated:YES completion:nil];
}

/* 添加通知监控媒体播放控制器状态 */
-(void)addNotification
{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayerViewController.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerViewController.moviePlayer];
}
-(void)deleteNotification
{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayerViewController.moviePlayer];
    [notificationCenter removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerViewController.moviePlayer];
}
/* 播放状态改变，注意播放完成时的状态是暂停*/
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification
{
    switch (self.moviePlayerViewController.moviePlayer.playbackState)
    {
        case MPMoviePlaybackStatePlaying:
        NSLog(@"正在播放...");
        break;
        case MPMoviePlaybackStatePaused:
        NSLog(@"暂停播放.");
        break;
        case MPMoviePlaybackStateStopped:
        NSLog(@"停止播放.");
        break;
        default:
        NSLog(@"播放状态:%li",(long)self.moviePlayerViewController.moviePlayer.playbackState);
        break;
    }
}
    //播放完成
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification
{
    NSLog(@"播放完成.%li",(long)self.moviePlayerViewController.moviePlayer.playbackState);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
