//
//  RegisterViewController.m
//  YouKe
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "RegisterViewController.h"
#import "WWTextField.h"
@interface RegisterViewController ()<UITextFieldDelegate>
{
    WWTextField          *userAccountField;
    WWTextField          *userPswField;
    WWTextField          *userNameField;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userAccountField = [[WWTextField alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 44)];
    userAccountField.placeholder = @"请输入账号";
    userAccountField.font = [UIFont systemFontOfSize:16];
    userAccountField.textColor = [UIColor blackColor];
    userAccountField.borderStyle = UITextBorderStyleNone;
    userAccountField.delegate =self;
    userAccountField.returnKeyType = UIReturnKeyNext;
    [self.view addSubview:userAccountField];
    
    
    userPswField = [[WWTextField alloc]initWithFrame:CGRectMake(userAccountField.frame.origin.x, userAccountField.frame.size.height+userAccountField.frame.origin.y+15, userAccountField.frame.size.width, userAccountField.frame.size.height)];
    userPswField.placeholder = @"请输入密码";
    userPswField.font = [UIFont systemFontOfSize:16];
    userPswField.textColor = [UIColor blackColor];
    userPswField.borderStyle = UITextBorderStyleNone;
    userPswField.delegate =self;
    userPswField.returnKeyType = UIReturnKeyNext;
    userPswField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userPswField];
    
    
    userNameField = [[WWTextField alloc]initWithFrame:CGRectMake(userPswField.frame.origin.x, userPswField.frame.size.height+userPswField.frame.origin.y+15, userPswField.frame.size.width, userPswField.frame.size.height)];
    userNameField.placeholder = @"请输入您的姓名";
    userNameField.font = [UIFont systemFontOfSize:16];
    userNameField.textColor = [UIColor blackColor];
    userNameField.borderStyle = UITextBorderStyleNone;
    userNameField.delegate =self;
    userNameField.returnKeyType = UIReturnKeyDone;
    userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:userNameField];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(userNameField.frame.origin.x, userNameField.frame.size.height+userNameField.frame.origin.y+20 , userNameField.frame.size.width, 50);
    [registerButton setBackgroundColor:[UIColor orangeColor]];
    [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerButton setTitle:@"立即注册" forState:UIControlStateHighlighted];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    registerButton.layer.masksToBounds=YES;
    registerButton.layer.cornerRadius=4;
    [registerButton addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];

}

//注册
-(void)registerBtnClick
{
    //发送注册请求 请求成功返回
    [userAccountField resignFirstResponder];
    [userPswField resignFirstResponder];
    [userNameField resignFirstResponder];
    
    NSString *accountStr = [userAccountField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *pwdStr = [userPswField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *nameStr = [userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (accountStr==nil||[accountStr isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"账号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (pwdStr==nil||[pwdStr isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (nameStr==nil||[nameStr isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"姓名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [self sendRegisterData];
}

//注册协议
-(void)sendRegisterData
{
    NSDictionary *parameters = @{@"user.usercode":userAccountField.text,
                                 @"user.username":userNameField.text,
                                 @"user.password":[MD5 md5HexDigest:userPswField.text]};
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:@"http://182.92.156.64/userregistered.action"
      parameters:parameters
        progress:^(NSProgress * _Nonnull downloadProgress) {
            /*数据请求的进度*/
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", dic);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", [error localizedDescription]);
        }];
}

#pragma mark -
#pragma mark 屏幕点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userAccountField resignFirstResponder];
    [userPswField resignFirstResponder];
    [userNameField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField ==userAccountField)
    {
        [userPswField becomeFirstResponder];
    }
    if (textField ==userPswField)
    {
        [userNameField becomeFirstResponder];
    }
    if (textField.returnKeyType == UIReturnKeyDone)
    {
        [self registerBtnClick];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = @"";
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
