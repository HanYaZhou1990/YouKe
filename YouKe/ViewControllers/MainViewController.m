//
//  MainViewController.m
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = UIColorFromRGB(0xCBCBCB);
    _contentArray = @[@"语文",@"历史",@"数学",@"地理",@"英语",@"思想政治"];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    self.mainCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_mainCollectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_mainCollectionView registerClass:[MainCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    _mainCollectionView.delegate=self;
    _mainCollectionView.dataSource=self;
    _mainCollectionView.showsHorizontalScrollIndicator=NO;
    _mainCollectionView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    _mainCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _mainCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainCollectionView];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_mainCollectionView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_mainCollectionView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[_mainCollectionView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_mainCollectionView)]];

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
    MainCollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    collectionViewCell.titleLable.text = _contentArray[indexPath.row];
    collectionViewCell.titleLable.font = [UIFont systemFontOfSize:15.0f];
    return collectionViewCell;
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

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout -
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 1, 0, 1);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((CGRectGetWidth(self.view.frame) - 5)/4, 36);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
