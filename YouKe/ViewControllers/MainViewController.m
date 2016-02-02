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
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"index.png"] selectedImage:[UIImage imageNamed:@"index-click.png"]];
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xffffff)];
        }
    return self;
}

- (void)refreshItemClicked:(UIBarButtonItem *)barItem{
    NSLog(@"刷新");
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
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshItemClicked:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    /*导航上中间的活动和群组按钮*/
    _menuView = [[MainMenuView alloc] initWithFrame:CGRectZero];
    _menuView.titleArray = @[@"视频",@"音频",@"图片",@"课外"];
    _menuView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    _menuView.selectedItem = [NSIndexPath indexPathForItem:0 inSection:0];
    _menuView.translatesAutoresizingMaskIntoConstraints = NO;
    [_menuView collectionItemClicked:^(UICollectionView *collectionView, NSIndexPath *indexPath){
        if (indexPath.row == 0) {
            /*视频*/
        }else if (indexPath.row == 1){
            /*音频*/
        }else if (indexPath.row == 2){
            /*图片*/
        }else{
            /*课外*/
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
    }];
    [self.view addSubview:_menuView];
    
    
    _contentArray = @[@"语文",@"历史",@"数学",@"地理",@"英语",@"思想政治"];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    self.mainCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_mainCollectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_mainCollectionView registerClass:[MainCollectionImageCell class] forCellWithReuseIdentifier:@"imageCell"];
    [_mainCollectionView registerClass:[MainCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    _mainCollectionView.delegate=self;
    _mainCollectionView.dataSource=self;
    _mainCollectionView.showsHorizontalScrollIndicator=NO;
    _mainCollectionView.backgroundColor = UIColorFromRGB(0xF0F0F0);
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

}

#pragma mark -
#pragma mark UICollectionViewDataSource -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_contentArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_menuView.selectedItem.row == 1) {
        MainCollectionImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
        imageCell.titleLable.text = _contentArray[indexPath.row];
        imageCell.titleLable.font = [UIFont systemFontOfSize:15.0f];
        return imageCell;
    }else{
        MainCollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        collectionViewCell.titleLable.text = _contentArray[indexPath.row];
        collectionViewCell.titleLable.font = [UIFont systemFontOfSize:15.0f];
            return collectionViewCell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MainCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.firstLineHeadIndent = 10;//首行缩进
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"这是第 %ld 个区",(long)indexPath.section] attributes:@{NSParagraphStyleAttributeName:style}];
    [headerView.titleLable setAttributedText:attributedString];
    return headerView;
}

#pragma mark -
#pragma mark UICollectionViewDelegate -
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"-------->第%ld区第%ld行",(long)indexPath.section,(long)indexPath.row);
}
#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout -
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 4.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 4.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 10, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_menuView.selectedItem.row == 1) {
        return CGSizeMake((CGRectGetWidth(self.view.frame) - 22)/4, 36+(CGRectGetWidth(self.view.frame) - 22)/4+8);
    }else{
        return CGSizeMake((CGRectGetWidth(self.view.frame) - 22)/4, 36);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
