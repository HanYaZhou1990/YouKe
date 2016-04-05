//
//  WebViewController.h
//  YouKe
//
//  Created by 韩亚周 on 16/4/4.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "HYZViewController.h"
#import "MBProgressHUD.h"

@interface WebViewController : HYZViewController<UIWebViewDelegate>

/*!从上级页面传过来，如果用户需要收藏，会用到*/
@property (nonatomic, strong) NSDictionary      *contentDictionary;
/*!需要被加载的网页地址*/
@property (nonatomic, strong) NSURL             *webUrl;

@end
