//
//  MainContentCell.h
//  YouKe
//
//  Created by 韩亚周 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PublicSource.h"
/*!首页的cell
 * 纯文字
 * 图片＋文字
 */
@interface MainContentCell : UITableViewCell
/*! 表头的标题　*/
@property (nonatomic, strong) UILabel       *titleLable;
/*! 子标题数组　*/
@property (nonatomic, strong) NSArray       *childTitleArray;
/*! 子标题　*/
@property (nonatomic, strong) UIView        *collectionView;

@end
