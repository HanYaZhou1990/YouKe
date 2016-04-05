//
//  CourseListViewController.m
//  YouKe
//
//  Created by 韩亚周 on 16/2/2.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "CourseListViewController.h"

@implementation CourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _messageMutableArray = [NSMutableArray array];
        
    _courseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_courseTableView registerClass:[MainNewsCell class] forCellReuseIdentifier:@"cell"];
    _courseTableView.dataSource = self;
    _courseTableView.delegate = self;
    _courseTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _courseTableView.tableFooterView = [UIView new];
    [self.view addSubview:_courseTableView];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_courseTableView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_courseTableView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[_courseTableView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_courseTableView)]];
    [self getDataWithIdString:_itemIdString];
}

- (void)getDataWithIdString:(NSString *)idString{
    /*http://182.92.156.64/jsonlist.action?resource.channelid=ff8081814d55186d014d555dc34e0007*/
    [_messageMutableArray removeAllObjects];
    if ([BaseHelper isCanUseHost]==YES)
        {
        [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
        [session GET:[NSString stringWithFormat:@"http://%@/jsonlist.action?resource.channelid=%@",YKbasehost,idString]
          parameters:nil
            progress:^(NSProgress * _Nonnull downloadProgress) {
                /*数据请求的进度*/
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [_messageMutableArray addObjectsFromArray:responseObject[@"list"]];
                [_courseTableView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }];
        }
    else
        {
         [BaseHelper waringInfo:@"服务器地址为空，请去“设置－服务器设置”中设置服务器地址!"];
        }
}

#pragma mark -
#pragma mark UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_messageMutableArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLable.text = [NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"name"]];
    cell.detailLable.text = [NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"remark"]];
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
    /*filetype*/
    NSLog(@"%@",_messageMutableArray[indexPath.row][@"filetype"]);
    /*是视频*/
    /*http://182.92.156.64/web/phoneplay.action?resource.id=8a7ca891501c1ef90150453e06900009*/
    if ([_messageMutableArray[indexPath.row][@"filetype"] integerValue] == 1 ||
        [_messageMutableArray[indexPath.row][@"filetype"] integerValue] == 2) {
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = _messageMutableArray[indexPath.row][@"name"];
        self.navigationItem.backBarButtonItem = backButtonItem;
        WebViewController *webVC = [[WebViewController alloc]init];
        webVC.webUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/web/phoneplay.action?resource.id=%@",YKbasehost,_messageMutableArray[indexPath.row][@"id"]]];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
