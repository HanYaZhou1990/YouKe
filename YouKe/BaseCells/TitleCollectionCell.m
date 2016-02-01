//
//  TitleCollectionCell.m
//  HNRuMi
//
//  Created by hanyazhou on 15/5/22.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import "TitleCollectionCell.h"

@interface TitleCollectionCell ()

@end

@implementation TitleCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"TitleCollectionCell" owner:self options:nil];
        if (views.count < 1) {
            return nil;
        }
        if (![views[0] isKindOfClass:[TitleCollectionCell class]]) {
            return nil;
        }
        self = views[0];
    }
    return self;
}

- (void)awakeFromNib{}

- (void)drawRect:(CGRect)rect{
    CGFloat width = CGRectGetWidth(self.frame);
    
    UIColor *color = _lingColor;
    [color set]; //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];    
    [aPath moveToPoint:CGPointMake(0, rect.size.height-1)];/*起始点*/
    [aPath addLineToPoint:CGPointMake(width, rect.size.height-1)];
    aPath.lineWidth = 2.0;
    [aPath stroke];
}

@end
