//
//  AboutViewController.m
//  YouKe
//
//  Created by mac on 16/2/2.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "AboutViewController.h"

#define APP_NAME ([[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleDisplayName"])
//软件版本号
#define SOFTWARE_VERSION ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"])
@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *sectionOneLArray;
}
@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    sectionOneLArray = @[@"当前版本",@"官方网站"];
    [self setTheTableView];
}

- (void)setTheTableView
{
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.backgroundView = nil;
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    [self.view addSubview:myTableView];
}
#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return sectionOneLArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.text = [sectionOneLArray objectAtIndex:indexPath.row];
    
    switch (indexPath.row)
    {
        case 0:
        {
            //软件版本
            NSString *myVersionStr = [NSString stringWithFormat:@"V%@",SOFTWARE_VERSION];
            [cell.detailTextLabel setText:myVersionStr];
        }
            break;
        case 1:
        {
            [cell.detailTextLabel setText:@"http://www.ytk.com"];
        }
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        UIImageView *logoImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2, 30, 70, 70)];
        logoImg.image = [UIImage imageNamed:@"Icon-180.png"];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(0, 110, SCREEN_WIDTH, 25);
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:18];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        //nameLabel.text = APP_NAME;
        nameLabel.text = @"优课通";
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        [headView setBackgroundColor:[UIColor clearColor]];
        [headView addSubview:logoImg];
        [headView addSubview:nameLabel];
        
        return headView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 150;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
