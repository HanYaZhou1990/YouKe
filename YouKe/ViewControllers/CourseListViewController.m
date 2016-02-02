//
//  CourseListViewController.m
//  YouKe
//
//  Created by 韩亚周 on 16/2/2.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "CourseListViewController.h"

@implementation CourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    _courseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_courseTableView registerClass:[MainNewsCell class] forCellReuseIdentifier:@"cell"];
    _courseTableView.dataSource = self;
    _courseTableView.delegate = self;
    _courseTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _courseTableView.tableFooterView = [UIView new];
    [self.view addSubview:_courseTableView];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_courseTableView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_courseTableView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[_courseTableView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_courseTableView)]];
}

#pragma mark -
#pragma mark UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLable.text = @" 中国邮政吃屁中国邮政吃屁";
    cell.detailLable.text = @"约3万人受影响滞留上海虹桥火车站 候车厅目前已空出一半】今天下午至晚间，因受到雨雪影响导致浙江桐乡段有列车发生故障，上海虹桥火车站多趟列车晚点致约3万名旅客滞留。晚10点，经过沪杭高铁的列车仍然大多晚点未定。目前，虹桥站候车厅约一半的空间已经空出。";
    cell.timeLable.text = @"2016-02-02";
    return cell;
}
#pragma mark -
#pragma mark UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
