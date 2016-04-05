//
//  WebViewController.m
//  YouKe
//
//  Created by 韩亚周 on 16/4/4.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) UIWebView       *webView;

@property (nonatomic, strong)UIBarButtonItem  *collectButtonItem;

@end

@implementation WebViewController

- (void)collectButtonItemClicked:(UIBarButtonItem *)item {
    NSMutableArray *dataMuableArray = [NSObject fileIsExists:@"collect"]?[NSMutableArray arrayWithArray:[NSObject getDataWithTable:@"collect"][@"message"]]:[NSMutableArray array];
    if ([dataMuableArray count] == 0) {
        [dataMuableArray insertObject:_contentDictionary atIndex:0];
    }else{
        __block BOOL hasData = NO;
        [dataMuableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj[@"id"] isEqualToString:_contentDictionary[@"id"]]) {
                hasData = YES;
                *stop = YES;
            }else{
                hasData = NO;
            }
        }];
        hasData?[dataMuableArray removeObject:_contentDictionary]:[dataMuableArray insertObject:_contentDictionary atIndex:0];
    }
    [NSObject save:@{@"message":dataMuableArray} toTable:@"collect"];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collectButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(collectButtonItemClicked:)];
    
    if (!_unNeedCollectItem) {
        NSArray *messageArray = [NSObject getDataWithTable:@"collect"][@"message"];
        if ([messageArray count] > 0) {
            __block BOOL hasData = NO;
            [messageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj[@"id"] isEqualToString:_contentDictionary[@"id"]]) {
                    hasData = YES;
                    *stop = YES;
                }else{
                    hasData = NO;
                }
            }];
            hasData?(self.navigationItem.rightBarButtonItem=nil):(self.navigationItem.rightBarButtonItem = _collectButtonItem);
        }else{
            self.navigationItem.rightBarButtonItem = _collectButtonItem;
        }
    }
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    _webView.delegate = self;
    [_webView setScalesPageToFit:YES];
    [_webView setOpaque:YES];
    [_webView loadRequest:[NSURLRequest requestWithURL:_webUrl]];
    [self.view addSubview:_webView];
    
    [self.view addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[_webView]|"
                              options:1.0
                              metrics:nil
                               views:NSDictionaryOfVariableBindings(_webView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[_webView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_webView)]];
}

#pragma mark -
#pragma mark UIWebViewDelegate -
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
