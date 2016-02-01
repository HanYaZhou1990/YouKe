//
//  MainCollectionReusableView.m
//  YouKe
//
//  Created by 韩亚周 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainCollectionReusableView.h"

@implementation MainCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xF0F0F0);
        _titleLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = [UIFont systemFontOfSize:15.0f];
        _titleLable.textColor = UIColorFromRGB(0x000000);
        [self addSubview:_titleLable];
        
        [self addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|[_titleLable]|"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_titleLable)]];
        [self addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-8-[_titleLable]-2-|"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_titleLable)]];
    }
    return self;
}

@end
