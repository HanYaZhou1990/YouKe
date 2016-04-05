//
//  PlayRecordViewController.m
//  YouKe
//
//  Created by mac on 16/2/2.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "PlayRecordViewController.h"
#import "MainNewsCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "PublicSource.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "NSObject+Document.h"
#import "MWPhotoBrowser.h"

@interface PlayRecordViewController ()<UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate>
{
    MWPhotoBrowser *photoBrowser;
    NSMutableArray *browserPhotos;
}
@property (nonatomic, strong) UITableView    *courseTableView;
@property (nonatomic, strong) NSMutableArray *messageMutableArray;
@end

@implementation PlayRecordViewController

- (void)viewDidLoad
{
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
    [self getUseData];
}

- (void)getUseData
{
        //从数据库中获取播放记录
    _messageMutableArray = [NSMutableArray arrayWithArray:[NSObject getDataWithTable:@"record"][@"message"]];
    [_courseTableView reloadData];
    
}

#pragma mark -
#pragma mark UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageMutableArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([[_messageMutableArray[indexPath.row] allKeys] containsObject:@"title"]) {
        cell.titleLable.text = [NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"title"]];
        cell.detailLable.text = [NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"content"]];
        cell.timeLable.text = [[NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"createtime"]] substringWithRange:NSMakeRange(0, 11)];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",YKbasehost,_messageMutableArray[indexPath.row][@"smaillpic"]]]
                               placeholderImage:[UIImage imageNamed:@"Icon-180.png"]
                                        options:SDWebImageRetryFailed];
    }else{
        cell.titleLable.text = [NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"name"]];
        cell.detailLable.text = [NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"remark"]];
        cell.timeLable.text = [[NSString stringWithFormat:@" %@",_messageMutableArray[indexPath.row][@"createtime"]] substringWithRange:NSMakeRange(0, 11)];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",YKbasehost,_messageMutableArray[indexPath.row][@"smaillpic"]]]
                               placeholderImage:[UIImage imageNamed:@"Icon-180.png"]
                                        options:SDWebImageRetryFailed];

    }
    return cell;
}
#pragma mark -
#pragma mark UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*filetype*/
    /*是视频*/
    /*http://182.92.156.64/web/phoneplay.action?resource.id=8a7ca891501c1ef90150453e06900009*/
    if ([_messageMutableArray[indexPath.row][@"filetype"] integerValue] == 1 ||
        [_messageMutableArray[indexPath.row][@"filetype"] integerValue] == 2) {
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        WebViewController *webVC = [[WebViewController alloc]init];
        backButtonItem.title = [_messageMutableArray[indexPath.row][@"name"] length]>6?@"详情":_messageMutableArray[indexPath.row][@"name"];
        self.navigationItem.backBarButtonItem = backButtonItem;
        webVC.webUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/web/phoneplay.action?resource.id=%@",YKbasehost,_messageMutableArray[indexPath.row][@"id"]]];
        webVC.contentDictionary = _messageMutableArray[indexPath.row];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }else if ([[_messageMutableArray[indexPath.row] allKeys] containsObject:@"title"]){
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        WebViewController *webVC = [[WebViewController alloc]init];
        backButtonItem.title = [_messageMutableArray[indexPath.row][@"title"] length]>6?@"详情":_messageMutableArray[indexPath.row][@"title"];
        self.navigationItem.backBarButtonItem = backButtonItem;
        webVC.webUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/web/newsplay.action?news.id=%@",YKbasehost,_messageMutableArray[indexPath.row][@"id"]]];
        webVC.contentDictionary = _messageMutableArray[indexPath.row];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else if ([_messageMutableArray[indexPath.row][@"filetype"] integerValue] == 3)
        {
        [self getImageDataWithIndex:indexPath.row];
        }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            //本地移除该数据 刷新列表
        [tableView beginUpdates];
        [NSObject deleteDataWithTable:@"record" andIndex:indexPath.row];
        [_messageMutableArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
        }
}
- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark 多图浏览
-(void)getImageDataWithIndex:(NSInteger)index
{
    NSInteger  useIndex = 0;
    NSString   *imageSelectString = [NSString stringWithFormat:@"http://%@/%@",YKbasehost,_messageMutableArray[index][@"largepic"]];
    NSMutableArray  *contentImages = [[NSMutableArray alloc]init];
    for (int i=0; i<_messageMutableArray.count; i++)
        {
        if ([_messageMutableArray[i][@"filetype"] integerValue] == 3)
            {
            NSString *imageString =  [NSString stringWithFormat:@"http://%@/%@",YKbasehost,_messageMutableArray[i][@"largepic"]];
            [contentImages addObject:imageString];
            }
        }
    if (contentImages.count>0)
        {
        if (browserPhotos)
            {
            [browserPhotos removeAllObjects];
            }
        else
            {
            browserPhotos = [[NSMutableArray alloc]init];
            }
        for (int i = 0; i < contentImages.count; i ++)
            {
            NSString *urlString = contentImages[i];
            [browserPhotos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:urlString]]];
            if ([urlString isEqualToString:imageSelectString])
                {
                useIndex = i;
                }
            }
        if (photoBrowser)
            {
            photoBrowser = nil;
            }
        photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        photoBrowser.displaySelectionButtons = NO;
        photoBrowser.displayActionButton = NO;
        [photoBrowser showNextPhotoAnimated:YES];
        [photoBrowser showPreviousPhotoAnimated:YES];
        [photoBrowser setCurrentPhotoIndex:useIndex];
        [self.navigationController pushViewController:photoBrowser animated:YES];
        }
}

#pragma mark - MWPhotoBrowerDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return browserPhotos.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;
{
    if (index < browserPhotos.count)
        {
        return [browserPhotos objectAtIndex:index];
        }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
