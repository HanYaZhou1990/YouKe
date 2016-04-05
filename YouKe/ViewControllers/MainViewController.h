//
//  MainViewController.h
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "HYZViewController.h"
#import "MainCollectionReusableView.h"
#import "MainCollectionViewCell.h"
#import "PublicSource.h"
#import "MainMenuView.h"
#import "MainCollectionImageCell.h"
#import "CourseListViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "PublicSource.h"
#import "UIImageView+WebCache.h"

/*!首页*/
@interface MainViewController : HYZViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView     *mainCollectionView;

@property (nonatomic, strong) NSMutableArray       *contentArray;

@property (nonatomic, strong) NSMutableArray       *itemsMutableArray;

@end
