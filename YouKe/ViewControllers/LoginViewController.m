    //
    //  LoginViewController.m
    //  YouKe
    //
    //  Created by mac on 16/2/3.
    //  Copyright © 2016年 韩亚周. All rights reserved.
    //

#import "LoginViewController.h"
#import "WWTextField.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "MD5.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    WWTextField          *userAccountField;
    WWTextField          *userPswField;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userAccountField = [[WWTextField alloc]initWithLeftFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 44) andImageName:@"login_p"];
    userAccountField.placeholder = @"请输入账号";
    userAccountField.font = [UIFont systemFontOfSize:16];
    userAccountField.textColor = [UIColor blackColor];
    userAccountField.borderStyle = UITextBorderStyleNone;
    userAccountField.delegate =self;
    userAccountField.returnKeyType = UIReturnKeyNext;
    [self.view addSubview:userAccountField];
    
    
    userPswField = [[WWTextField alloc]initWithLeftFrame:CGRectMake(userAccountField.frame.origin.x, userAccountField.frame.size.height+userAccountField.frame.origin.y+15, userAccountField.frame.size.width, userAccountField.frame.size.height) andImageName:@"login_password"];
    userPswField.placeholder = @"请输入密码";
    userPswField.font = [UIFont systemFontOfSize:16];
    userPswField.textColor = [UIColor blackColor];
    userPswField.borderStyle = UITextBorderStyleNone;
    userPswField.delegate =self;
    userPswField.returnKeyType = UIReturnKeyDone;
    userPswField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userPswField.secureTextEntry = YES;//密码样式
    UIButton *findPwdButton =[UIButton buttonWithType:UIButtonTypeCustom];
    findPwdButton.backgroundColor = [UIColor clearColor];
    findPwdButton.frame = CGRectMake(0, 0, 80, userPswField.frame.size.height);
    [findPwdButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [findPwdButton setTitle:@"找回密码" forState:UIControlStateHighlighted];
    [findPwdButton setTitleColor:RGBACOLOR(52, 157, 56, 1) forState:UIControlStateNormal];
    [findPwdButton setTitleColor:RGBACOLOR(52, 157, 56, 1) forState:UIControlStateHighlighted];
    findPwdButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [findPwdButton addTarget:self action:@selector(findPwdButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    userPswField.rightView = findPwdButton;
    userAccountField.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:userPswField];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(userAccountField.frame.origin.x, userPswField.frame.size.height+userPswField.frame.origin.y+20 , userAccountField.frame.size.width, 50);
    [loginButton setBackgroundColor:[UIColor orangeColor]];
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [loginButton setTitle:@"登  录" forState:UIControlStateHighlighted];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    loginButton.layer.masksToBounds=YES;
    loginButton.layer.cornerRadius=4;
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
}

    //找回密码
-(void)findPwdButtonClicked:(id)sender
{
    
}
    //登录点击
-(void)loginButtonClicked:(id)sender
{
        //验证不可为空
    [userAccountField resignFirstResponder];
    [userPswField resignFirstResponder];
    NSString *phoneStr = [userAccountField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *pwdStr = [userPswField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //验证账号
    if (phoneStr==nil||[phoneStr isEqualToString:@""])
        {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"账号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
        }
    
        //验证密码
    if (pwdStr==nil||[pwdStr isEqualToString:@""])
        {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
        }
    
    if ([BaseHelper isCanUseHost]==YES)
        {
        [self sendLoginData]; //发送登录协议
        }
    else
        {
        [BaseHelper waringInfo:@"服务器地址为空，请去“设置－服务器设置”中设置服务器地址!"];
        }
    
}
    //登录协议
-(void)sendLoginData
{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"登录中..." animated:YES];
    
    NSString *md5Password = [MD5 md5HexDigest:userPswField.text];
    NSDictionary *parameters = @{@"user.usercode":userAccountField.text,@"user.password":md5Password};
    
    NSString *useurl = [NSString stringWithFormat:@"http://%@/userlogin.action",YKbasehost];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    [session GET:useurl
      parameters:parameters
        progress:^(NSProgress * _Nonnull downloadProgress){
            /*数据请求的进度*/
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     NSDictionary *responseDic = (NSDictionary *)responseObject;
         //打印结果 方便查看
          NSString *responseString = [BaseHelper dictionaryToJson:responseDic];
          NSLog(@"返回结果字符串 : %@",responseString);
     BOOL ret = [[responseDic valueForKey:@"ret"] boolValue];
     if (ret)
         {
         NSArray *userArray = [responseDic valueForKey:@"user"];
         if (![userArray isKindOfClass:[NSNull class]]&&userArray!=nil)
             {
             if (userArray.count>0)
                 {
                 NSDictionary *userDic = [userArray objectAtIndex:0];
                 NSString *userId = [BaseHelper isSpaceString: [userDic valueForKey:@"id"] andReplace:@""];
                  NSString *usercode = [BaseHelper isSpaceString: [userDic valueForKey:@"usercode"] andReplace:@""];
                 if (userId.length>0){
                     [[NSUserDefaults standardUserDefaults] setValue:userId forKey:@"userid"];
                     [[NSUserDefaults standardUserDefaults] setValue:usercode forKey:@"usercode"];
                     [[NSUserDefaults standardUserDefaults] setValue:md5Password forKey:@"password"];
                     [BaseHelper waringInfo:@"登录成功"];
                     [self.navigationController popViewControllerAnimated:YES];
                 }
                 else{
                     [BaseHelper waringInfo:@"登录失败"];
                 }
                 }
             else{
                 [BaseHelper waringInfo:@"登录失败"];
             }
             }
         
         }
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     [BaseHelper waringInfo:@"登录失败"];
         // NSLog(@"%@", [error localizedDescription]);
     }];
}

#pragma mark -
#pragma mark 屏幕点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userAccountField resignFirstResponder];
    [userPswField resignFirstResponder];
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
    if (textField.returnKeyType == UIReturnKeyDone)
        {
        [self loginButtonClicked:nil];
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
