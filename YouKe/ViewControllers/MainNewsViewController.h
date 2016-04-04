//
//  MainNewsViewController.h
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "HYZViewController.h"
#import "MainMenuView.h"
#import "MainNewsCell.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"

/*!新闻*/
@interface MainNewsViewController : HYZViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView         *nesTableView;
/*!顶部导航下边的主选项*/
@property (nonatomic ,strong) NSMutableArray      *itemsTitleArray;
/*!选择某一项后的数据*/
@property (nonatomic ,strong) NSMutableArray      *messageMutableArray;
@end
