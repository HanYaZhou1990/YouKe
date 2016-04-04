//
//  MainNewsCell.m
//  YouKe
//
//  Created by 韩亚周 on 16/2/2.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainNewsCell.h"

@implementation MainNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _titleImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_titleImageView];
        
        _titleLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLable.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_titleLable];
        
        _timeLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _timeLable.translatesAutoresizingMaskIntoConstraints = NO;
        _timeLable.font = [UIFont systemFontOfSize:12.0f];
        _timeLable.minimumScaleFactor = 0.6f;
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.textColor = UIColorFromRGB(0x858585);
        [self.contentView addSubview:_timeLable];
        
        _detailLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _detailLable.translatesAutoresizingMaskIntoConstraints = NO;
        _detailLable.font = [UIFont systemFontOfSize:14.0f];
        _detailLable.textColor = UIColorFromRGB(0x3D3D3D);
        _detailLable.numberOfLines = 3;
        [self.contentView addSubview:_detailLable];
        
        [self.contentView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:@"H:|-10-[_titleImageView(==80)]-[_titleLable]-[_timeLable(==74)]-10-|"
                                        options:1.0
                                        metrics:nil
                                         views:NSDictionaryOfVariableBindings(_titleImageView,_titleLable,_timeLable)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:[_titleImageView]-[_detailLable]-10-|"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_titleImageView,_detailLable)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-12-[_titleImageView]-12-|"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_titleImageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-10-[_titleLable]-[_detailLable]|"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_titleLable,_detailLable)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-8-[_timeLable]"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_timeLable)]];
    }
    return self;
}

@end
