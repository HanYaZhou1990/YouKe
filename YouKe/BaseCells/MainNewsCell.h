//
//  MainNewsCell.h
//  YouKe
//
//  Created by 韩亚周 on 16/2/2.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicSource.h"

/*!新闻页面的cell*/
@interface MainNewsCell : UITableViewCell

/*!cell前边的主题图片*/
@property (nonatomic, strong) UIImageView     *titleImageView;
/*!新闻标题*/
@property (nonatomic, strong) UILabel         *titleLable;
/*!新闻发布时间*/
@property (nonatomic, strong) UILabel         *timeLable;
/*!新闻详情*/
@property (nonatomic, strong) UILabel         *detailLable;

@end
