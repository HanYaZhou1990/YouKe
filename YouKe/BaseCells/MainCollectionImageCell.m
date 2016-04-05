//
//  MainCollectionImageCell.m
//  YouKe
//
//  Created by 韩亚周 on 16/2/2.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainCollectionImageCell.h"

@implementation MainCollectionImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _titleImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_titleImageView];
        
        self.backgroundColor = UIColorFromRGB(0xF5F5F5);
        _titleLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = UIColorFromRGB(0x3D3D3d);
        _titleLable.adjustsFontSizeToFitWidth = YES;
        _titleLable.minimumScaleFactor = 0.8f;
        [self addSubview:_titleLable];
        
        /*!为了展示方形图片，取图片宽度作为高度*/
        CGFloat imageHeight = CGRectGetWidth(frame)-4;
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-2-[_titleLable]-2-|"
                              options:1.0
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_titleLable)]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-2-[_titleImageView]-2-|"
                              options:1.0
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_titleImageView)]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[_titleImageView(==%f)]-[_titleLable]|",imageHeight]
                              options:1.0
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_titleImageView,_titleLable)]];
    }
    return self;
}

@end
