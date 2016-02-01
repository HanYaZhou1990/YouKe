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
        self.backgroundColor = UIColorFromRGB(0x546465);
        _titleLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = UIColorFromRGB(0x3D3D3d);
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
