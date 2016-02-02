//
//  HostSettingViewController.m
//  YouKe
//
//  Created by mac on 16/2/2.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "HostSettingViewController.h"

@interface HostSettingViewController ()<UITextFieldDelegate>
{
    UITextField *_textField;
}
@end

@implementation HostSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(10, 7, 80, 30);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = @"请设置服务器地址:";
    [self.view addSubview:titleLabel];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH-40, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 2.0f;
    bgView.layer.borderColor = [UIColor grayColor].CGColor;
    bgView.layer.borderWidth = 0.5;
    [self.view addSubview:bgView];
    
    _textField = [[UITextField alloc]init];
    _textField.frame = CGRectMake(10, 0, SCREEN_WIDTH - 60, 40);
    NSString *useTest =  [[NSUserDefaults standardUserDefaults] valueForKey:@"host"];
    if (useTest.length>0)
    {
        _textField.text = useTest;
    }
    else
    {
        _textField.placeholder = @"请输入内容";
    }
    _textField.backgroundColor = [UIColor clearColor];
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    [_textField becomeFirstResponder];
    [bgView addSubview:_textField];
}

- (void)btnClick
{
    [_textField resignFirstResponder];
    NSString *testStr=_textField.text;
    NSString *text = [testStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text==nil ||[text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:testStr forKey:@"host"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
