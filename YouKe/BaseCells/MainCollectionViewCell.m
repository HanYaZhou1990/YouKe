//
//  MainCollectionViewCell.m
//  YouKe
//
//  Created by 韩亚周 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = RGBACOLOR(234, 234, 234, 1).CGColor;
        self.backgroundColor = RGBACOLOR(245, 245, 245, 1);
        _titleLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = RGBACOLOR(102, 102, 102, 1);
        _titleLable.adjustsFontSizeToFitWidth = YES;
        _titleLable.minimumScaleFactor = 0.8f;
        [self addSubview:_titleLable];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-2-[_titleLable]-2-|"
                              options:1.0
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_titleLable)]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[_titleLable]|"
                              options:1.0
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_titleLable)]];
    }
    return self;
}

@end
