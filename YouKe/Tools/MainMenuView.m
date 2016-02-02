//
//  MainMenuView.m
//  HNRuMi
//
//  Created by hanyazhou on 15/5/28.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import "MainMenuView.h"

@implementation MainMenuView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        self.mainTitleCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_mainTitleCollectionView registerClass:[TitleCollectionCell class] forCellWithReuseIdentifier:@"titleCell"];
        _mainTitleCollectionView.delegate=self;
        _mainTitleCollectionView.dataSource=self;
        _mainTitleCollectionView.showsHorizontalScrollIndicator=NO;
        _mainTitleCollectionView.backgroundColor = [UIColor clearColor];
        _mainTitleCollectionView.allowsMultipleSelection = NO;
        _mainTitleCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_mainTitleCollectionView];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-1-[_mainTitleCollectionView]|"
                              options:1.0
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_mainTitleCollectionView)]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[_mainTitleCollectionView]|"
                              options:1.0
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_mainTitleCollectionView)]];
    }
    return self;
}

#pragma mark---顶部的滑动试图
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger numberOfCell = [collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < numberOfCell; i ++) {
        NSIndexPath *cellIndexPath = [NSIndexPath indexPathForItem:i inSection:0];
        TitleCollectionCell *cell = (TitleCollectionCell *)[collectionView cellForItemAtIndexPath:cellIndexPath];
        if (cellIndexPath.section == indexPath.section && cellIndexPath.row == indexPath.row) {
            cell.backgroundColor = RGBACOLOR(255, 255, 255, 0);
            /*被选中的下划线颜色*/
            cell.lingColor = RGBACOLOR(255, 133, 10, 1);
            cell.collectiontitleLable.textColor = RGBACOLOR(255, 133, 10, 1);
            _clickedBlock(collectionView,indexPath);
            [cell setNeedsLayout];
        }else{
            cell.backgroundColor = RGBACOLOR(255, 255, 254, 0);
            /*正常下划线颜色*/
            cell.lingColor = RGBACOLOR(255, 255, 254, 0);;
            cell.collectiontitleLable.textColor = UIColorFromRGB(0x000000);
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell"forIndexPath:indexPath];
    cell.backgroundColor = RGBACOLOR(255, 255, 254, 0);
    cell.collectiontitleLable.font = [UIFont systemFontOfSize:16.0f];
    if ([_titleArray[indexPath.row] isKindOfClass:[NSString class]]) {
        cell.titleImageView.frame = CGRectZero;
        cell.collectiontitleLable.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height-1);
        cell.collectiontitleLable.text = _titleArray[indexPath.row];
        cell.collectiontitleLable.textColor = UIColorFromRGB(0x000000);
        cell.collectiontitleLable.textAlignment = NSTextAlignmentCenter;
    }else{
        cell.collectiontitleLable.frame = CGRectZero;
        cell.titleImageView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height-1);
        cell.titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.titleImageView.image = _titleArray[indexPath.row];
    }
    if (indexPath.row == self.selectedItem.row) {
        cell.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        /*被选中的下划线颜色,同时改变字体颜色*/
        cell.lingColor = RGBACOLOR(255, 133, 10, 1);
        cell.collectiontitleLable.textColor = RGBACOLOR(255, 133, 10, 1);
    }else{
        /*正常下划线颜色*/
        cell.lingColor = RGBACOLOR(255, 255, 254, 0);
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_titleArray.count < 5) {
        return CGSizeMake(CGRectGetWidth(self.frame)/_titleArray.count, self.frame.size.height-1);
    }else{
        return CGSizeMake(120, self.frame.size.height-1);
    }
}

- (void)collectionItemClicked:(collectionItemClicked)handleBlock{
    _clickedBlock = handleBlock;
}

@end
