//
//  MainViewController.m
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()


@property (nonatomic, strong) MainMenuView          *menuView;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"xx_tabbar_icon1_up.png"] selectedImage:[UIImage imageNamed:@"xx_tabbar_icon1_down.png"]];
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xffffff)];
        }
    return self;
}

- (void)refreshItemClicked:(UIButton *)barItem{
    _menuView.selectedItem = [NSIndexPath indexPathForItem:0 inSection:0];
    [self getData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"优课通" forState:UIControlStateNormal];
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
    
    _itemsMutableArray = [NSMutableArray array];
    
    /*导航上中间的活动和群组按钮*/
    _menuView = [[MainMenuView alloc] initWithFrame:CGRectZero];
//    _menuView.titleArray = @[@"视频",@"音频",@"图片",@"课外"];
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
        [[self.mainCollectionView layer] addAnimation:transition forKey:@"UITableViewReloadDataAnimationKey"];
        _menuView.selectedItem = indexPath;
        [_mainCollectionView reloadData];
        [self getDataWithIdString:_itemsMutableArray[indexPath.row][@"id"]];
    }];
    [self.view addSubview:_menuView];
    
    
    _contentArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    self.mainCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_mainCollectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_mainCollectionView registerClass:[MainCollectionImageCell class] forCellWithReuseIdentifier:@"imageCell"];
    [_mainCollectionView registerClass:[MainCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    _mainCollectionView.delegate=self;
    _mainCollectionView.dataSource=self;
    _mainCollectionView.showsHorizontalScrollIndicator=NO;
    _mainCollectionView.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    _mainCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _mainCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainCollectionView];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_mainCollectionView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_mainCollectionView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_menuView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_menuView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[_menuView(==44)][_mainCollectionView]-44-|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_menuView,_mainCollectionView)]];
    [self getData];
}

- (void)getData{
    if ([BaseHelper isCanUseHost]==YES)
        {
        [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
        [session GET:[NSString stringWithFormat:@"http://%@/jsonchannel.action",YKbasehost]
          parameters:nil
            progress:^(NSProgress * _Nonnull downloadProgress) {
                /*数据请求的进度*/
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [_itemsMutableArray removeAllObjects];
                [_itemsMutableArray addObjectsFromArray:responseObject[@"list"]];
                NSMutableArray *titleArray = [NSMutableArray array];
                [_itemsMutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    [_contentArray removeAllObjects];
    if ([BaseHelper isCanUseHost]==YES)
        {
        [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
        [session GET:[NSString stringWithFormat:@"http://%@/jsonchannel.action?channel.parentid=%@",YKbasehost,idString]
          parameters:nil
            progress:^(NSProgress * _Nonnull downloadProgress) {
                /*数据请求的进度*/
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:responseObject[@"list"]];
                [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:obj];
                    if ([mutableDictionary[@"leaf"] integerValue] == 0) {
                        [session GET:[NSString stringWithFormat:@"http://%@/jsonlist.action?resource.channelid=%@",YKbasehost,obj[@"id"]]
                          parameters:nil
                            progress:^(NSProgress * _Nonnull downloadProgress) {
                                /*数据请求的进度*/
                            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                [mutableDictionary setObject:responseObject forKey:obj[@"id"]];
                                [_contentArray addObject:mutableDictionary];
                                [_mainCollectionView reloadData];
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            }];
                    }else{
                        [session GET:[NSString stringWithFormat:@"http://%@/jsonchannel.action?channel.parentid=%@",YKbasehost,obj[@"id"]]
                          parameters:nil
                            progress:^(NSProgress * _Nonnull downloadProgress) {
                                /*数据请求的进度*/
                            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                [mutableDictionary setObject:responseObject forKey:obj[@"id"]];
                                [_contentArray addObject:mutableDictionary];
                                [_mainCollectionView reloadData];
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            }];
                    }
                }];
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
#pragma mark UICollectionViewDataSource -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_contentArray count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSString *keyString = _contentArray[section][@"id"];
    return [_contentArray[section][keyString][@"list"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    /*http://182.92.156.64/jsonchannel.action?channel.parentid=ff8081814d55186d014d555c0dcc0001*/
    NSString *keyString = _contentArray[indexPath.section][@"id"];
    if (_menuView.selectedItem.row == 1) {
        MainCollectionImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
        imageCell.titleLable.text = _contentArray[indexPath.section][keyString][@"list"][indexPath.row][@"name"];
        imageCell.titleLable.font = [UIFont systemFontOfSize:15.0f];
        [imageCell.titleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",YKbasehost,_contentArray[indexPath.section][keyString][@"list"][indexPath.row][@"smaillpic"]]]
                               placeholderImage:[UIImage imageNamed:@"Icon-180.png"]
                                        options:SDWebImageRetryFailed];
        return imageCell;
    }else{
        MainCollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        collectionViewCell.titleLable.text = _contentArray[indexPath.section][keyString][@"list"][indexPath.row][@"name"];
        collectionViewCell.titleLable.font = [UIFont systemFontOfSize:15.0f];
            return collectionViewCell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MainCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.firstLineHeadIndent = 10;//首行缩进
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_contentArray[indexPath.section][@"name"]] attributes:@{NSParagraphStyleAttributeName:style}];
    [headerView.titleLable setAttributedText:attributedString];
    return headerView;
}

#pragma mark -
#pragma mark UICollectionViewDelegate -
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    /* 进页面之前先设置返回按钮 */
    NSString *keyString = _contentArray[indexPath.section][@"id"];
    NSDictionary *dictionary = _contentArray[indexPath.section][keyString][@"list"][indexPath.row];
    if ([_contentArray[indexPath.section][@"leaf"] integerValue] == 0) {
        NSMutableArray *dataMuableArray = [NSObject fileIsExists:@"record"]?[NSMutableArray arrayWithArray:[NSObject getDataWithTable:@"record"][@"message"]]:[NSMutableArray array];
        [[dataMuableArray firstObject][@"id"] isEqualToString:dictionary[@"id"]]?:[dataMuableArray insertObject:dictionary atIndex:0];
        [NSObject save:@{@"message":dataMuableArray} toTable:@"record"];
       
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = [dictionary[@"name"] length]>6?@"详情":dictionary[@"name"];
        self.navigationItem.backBarButtonItem = backButtonItem;
        WebViewController *webVC = [[WebViewController alloc]init];
        webVC.webUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/web/phoneplay.action?resource.id=%@",YKbasehost,dictionary[@"id"]]];
        webVC.contentDictionary = dictionary;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = _contentArray[indexPath.section][keyString][@"list"][indexPath.row][@"name"];
        self.navigationItem.backBarButtonItem = backButtonItem;
        CourseListViewController *courseViewController = [[CourseListViewController alloc]init];
        courseViewController.hidesBottomBarWhenPushed = YES;
        courseViewController.itemIdString = _contentArray[indexPath.section][keyString][@"list"][indexPath.row][@"id"];
        [self.navigationController pushViewController:courseViewController animated:YES];
    }
}
#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout -
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if ([_contentArray[section][@"leaf"] integerValue] == 0) {
        return 0.0f;
    }else{
        return 4.0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if ([_contentArray[section][@"leaf"] integerValue] == 0) {
        return 0.0f;
    }else{
        return 4.0;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 10, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_contentArray[indexPath.section][@"leaf"] integerValue] == 0) {
        return CGSizeMake((CGRectGetWidth(self.view.frame) - 10)/4, 20+((CGRectGetWidth(self.view.frame) - 22)/4*3/4)+2);
    }else {
        return CGSizeMake((CGRectGetWidth(self.view.frame) - 22)/4, 36);
    }
//    if (_menuView.selectedItem.row == 1) {
//        return CGSizeMake((CGRectGetWidth(self.view.frame) - 22)/4, 36+(CGRectGetWidth(self.view.frame) - 22)/4+8);
//    }else{
//        return CGSizeMake((CGRectGetWidth(self.view.frame) - 22)/4, 36);
//    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 36);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
