//
//  MainContentCell.m
//  YouKe
//
//  Created by 韩亚周 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainContentCell.h"

@implementation MainContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xEBEBEB);
        
        _titleLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLable.backgroundColor = UIColorFromRGB(0xFBFBFB);
        _titleLable.textColor = UIColorFromRGB(0x000000);
        [self.contentView addSubview:_titleLable];
        
        _collectionView = [[UIView alloc]initWithFrame:CGRectZero];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_collectionView];
        
        
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|[_titleLable]|"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_titleLable)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|[_collectionView]|"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_collectionView)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-10-[_titleLable(==30)][_collectionView]|"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_titleLable,_collectionView)]];
        
    }
    return self;
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
