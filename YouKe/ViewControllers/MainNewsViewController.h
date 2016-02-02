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

/*!新闻*/
@interface MainNewsViewController : HYZViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView    *nesTableView;

@end
