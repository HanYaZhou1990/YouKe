//
//  CourseListViewController.h
//  YouKe
//
//  Created by 韩亚周 on 16/2/2.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "HYZViewController.h"
#import "MainNewsCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "PublicSource.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"

/*!课程列表页面*/
@interface CourseListViewController : HYZViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView    *courseTableView;
/*!加载列表需要的id*/
@property (nonatomic, strong) NSString       *itemIdString;

@property (nonatomic, strong) NSMutableArray *messageMutableArray;

@end
