//
//  MainCollectionImageCell.h
//  YouKe
//
//  Created by 韩亚周 on 16/2/2.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicSource.h"

/*!首页子标题
  图片 ＋ 文字\
 */
@interface MainCollectionImageCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView      *titleImageView;
/*!子标题*/
@property (nonatomic, strong) UILabel          *titleLable;

@end
