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
        self.backgroundColor = UIColorFromRGB(0xCBCBCB);
        _titleLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLable.backgroundColor = UIColorFromRGB(0xEBEBEB);
        _titleLable.textColor = UIColorFromRGB(0x000000);
        [self addSubview:_titleLable];
        
        [self addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|[_titleLable]|"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_titleLable)]];
        [self addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-10-[_titleLable]|"
                                          options:1.0
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(_titleLable)]];
    }
    return self;
}

@end
