//
//  WWTextField.m
//  YouKe
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "WWTextField.h"

@implementation WWTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, frame.size.height)];
        leftView.backgroundColor = [UIColor clearColor];
        self.leftView =  leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=4;
    }
    return self;
}

- (id)initWithLeftFrame:(CGRect)frame andImageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
        leftView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *leftImg = [[UIImageView alloc]init];
        leftImg.frame = CGRectMake((frame.size.height-26)/2, (frame.size.height-26)/2, 26, 26);
        leftImg.image = [UIImage imageNamed:imageName];
        [leftView addSubview:leftImg];
        
        self.leftView =  leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=4;
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
