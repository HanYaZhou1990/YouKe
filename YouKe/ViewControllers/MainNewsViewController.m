//
//  MainNewsViewController.m
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainNewsViewController.h"

@interface MainNewsViewController ()

@property (nonatomic, strong) MainMenuView          *menuView;

@end

@implementation MainNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻" image:[UIImage imageNamed:@"xx_tabbar_icon2_up.png"] selectedImage:[UIImage imageNamed:@"xx_tabbar_icon2_down.png"]];
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xffffff)];
        }
    return self;
}
- (void)refreshItemClicked:(UIButton *)barItem{
    _menuView.selectedItem = [NSIndexPath indexPathForItem:0 inSection:0];
    [self getData];
}

- (void)getData{
    if ([BaseHelper isCanUseHost]==YES)
        {
        /*http://182.92.156.64/jsonchannel.action?channel.parentid=402882ea49da8f830149da9943050002&channel.type=2*/
        [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
        [session GET:[NSString stringWithFormat:@"http://%@/jsonchannel.action?channel.parentid=402882ea49da8f830149da9943050002&channel.type=2",YKbasehost]
          parameters:nil
            progress:^(NSProgress * _Nonnull downloadProgress) {
                /*数据请求的进度*/
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [_itemsTitleArray removeAllObjects];
                [_itemsTitleArray addObjectsFromArray:responseObject[@"list"]];
                NSMutableArray *titleArray = [NSMutableArray array];
                [_itemsTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx==0) {
                        [self getDataWithIdString:obj[@"id"]];
                    }
                    [titleArray addObject:obj[@"name"]];
                }];
                _menuView.titleArray = titleArray;
                [_menuView.mainTitleCollectionView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }];
        }
    else
        {
         [BaseHelper waringInfo:@"服务器地址为空，请去“设置－服务器设置”中设置服务器地址!"];
        }
}
- (void)getDataWithIdString:(NSString *)idString{
    /*http://182.92.156.64/jsonnews.action?news.channelid=402882ea49da8f830149da99794d0003*/
    if ([BaseHelper isCanUseHost]==YES)
        {
        [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
        [session GET:[NSString stringWithFormat:@"http://%@/jsonnews.action?news.channelid=%@",YKbasehost,idString]
          parameters:nil
            progress:^(NSProgress * _Nonnull downloadProgress) {
                /*数据请求的进度*/
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [_messageMutableArray removeAllObjects];
                [_messageMutableArray addObjectsFromArray:responseObject[@"list"]];
                [_nesTableView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }];
        }
    else
        {
         [BaseHelper waringInfo:@"服务器地址为空，请去“设置－服务器设置”中设置服务器地址!"];
        }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _itemsTitleArray = [NSMutableArray array];
    _messageMutableArray = [NSMutableArray array];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"新闻" forState:UIControlStateNormal];
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
    
    /*导航上中间的活动和群组按钮*/
    _menuView = [[MainMenuView alloc] initWithFrame:CGRectZero];
//    _menuView.titleArray = @[@"校内新闻",@"国内新闻",@"教育新闻"];
    _menuView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    _menuView.selectedItem = [NSIndexPath indexPathForItem:0 inSection:0];
    _menuView.translatesAutoresizingMaskIntoConstraints = NO;
    [_menuView collectionItemClicked:^(UICollectionView *collectionView, NSIndexPath *indexPath){
        if (_menuView.selectedItem.row == indexPath.row) {
            return ;
        }
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionPush;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.fillMode = kCAFillModeForwards;
        transition.duration = 0.3;
        transition.subtype = _menuView.selectedItem.row >indexPath.row ? kCATransitionFromLeft:kCATransitionFromRight;
        [[self.nesTableView layer] addAnimation:transition forKey:@"UITableViewReloadDataAnimationKey"];
        _menuView.selectedItem = indexPath;
        [_nesTableView reloadData];
        [self getDataWithIdString:_itemsTitleArray[indexPath.row][@"id"]];
    }];
    [self.view addSubview:_menuView];
    
    _nesTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_nesTableView registerClass:[MainNewsCell class] forCellReuseIdentifier:@"cell"];
    _nesTableView.dataSource = self;
    _nesTableView.delegate = self;
    _nesTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _nesTableView.tableFooterView = [UIView new];
    [self.view addSubview:_nesTableView];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_nesTableView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_nesTableView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_menuView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_menuView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[_menuView(==44)]-1-[_nesTableView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_menuView,_nesTableView)]];
    
    [self getData];
}

#pragma mark -
#pragma mark UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_messageMutableArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLable.text = [NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"title"]];
    cell.detailLable.text = [NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"content"]];
    cell.timeLable.text = [[NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"createtime"]] substringWithRange:NSMakeRange(0, 11)];
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",YKbasehost,_messageMutableArray[indexPath.row][@"smaillpic"]]]
                           placeholderImage:[UIImage imageNamed:@"Icon-180.png"]
                                    options:SDWebImageRetryFailed];
    return cell;
}
#pragma mark -
#pragma mark UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*http://182.92.156.64/web/newsplay.action?news.id=8a7ca8914e24303e014e61fbc86a0017*/
    
    NSMutableArray *dataMuableArray = [NSObject fileIsExists:@"record"]?[NSMutableArray arrayWithArray:[NSObject getDataWithTable:@"record"][@"message"]]:[NSMutableArray array];
    [[dataMuableArray firstObject] isEqualToDictionary:_messageMutableArray[indexPath.row]]?:[dataMuableArray insertObject:_messageMutableArray[indexPath.row] atIndex:0];
    [NSObject save:@{@"message":dataMuableArray} toTable:@"record"];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = [_messageMutableArray[indexPath.row][@"title"] length]>6?@"详情":_messageMutableArray[indexPath.row][@"title"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    WebViewController *webVC = [[WebViewController alloc]init];
    webVC.webUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/web/newsplay.action?news.id=%@",YKbasehost,_messageMutableArray[indexPath.row][@"id"]]];
    webVC.contentDictionary = _messageMutableArray[indexPath.row];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
