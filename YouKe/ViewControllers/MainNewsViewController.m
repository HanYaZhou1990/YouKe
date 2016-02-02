//
//  MainNewsViewController.m
//  YouKe
//
//  Created by 坚磐科技 on 16/2/1.
//  Copyright © 2016年 韩亚周. All rights reserved.
//

#import "MainNewsViewController.h"

@interface MainNewsViewController ()

@property (nonatomic, strong) MainMenuView          *menuView;

@end

@implementation MainNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻" image:[UIImage imageNamed:@"xx_tabbar_icon2_up.png"] selectedImage:[UIImage imageNamed:@"xx_tabbar_icon2_down.png"]];
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xffffff)];
        }
    return self;
}
- (void)refreshItemClicked:(UIButton *)barItem{
    NSLog(@"刷新");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"新闻" forState:UIControlStateNormal];
    leftButton.bounds = CGRectMake(0, 0, 60, 44);
    [leftButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds = CGRectMake(0, 0, 40, 40);
    rightButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [rightButton setImage:[UIImage imageNamed:@"refresh_nor.png"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"refresh_press.png"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(refreshItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    /*导航上中间的活动和群组按钮*/
    _menuView = [[MainMenuView alloc] initWithFrame:CGRectZero];
    _menuView.titleArray = @[@"校内新闻",@"国内新闻",@"教育新闻"];
    _menuView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    _menuView.selectedItem = [NSIndexPath indexPathForItem:0 inSection:0];
    _menuView.translatesAutoresizingMaskIntoConstraints = NO;
    [_menuView collectionItemClicked:^(UICollectionView *collectionView, NSIndexPath *indexPath){
        if (_menuView.selectedItem.row == indexPath.row) {
            return ;
        }
        if (indexPath.row == 0) {
            /*校内新闻*/
        }else if (indexPath.row == 1){
            /*国内新闻*/
        }else{
            /*教育新闻*/
        }
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionPush;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.fillMode = kCAFillModeForwards;
        transition.duration = 0.3;
        transition.subtype = _menuView.selectedItem.row >indexPath.row ? kCATransitionFromLeft:kCATransitionFromRight;
        [[self.nesTableView layer] addAnimation:transition forKey:@"UITableViewReloadDataAnimationKey"];
        _menuView.selectedItem = indexPath;
        [_nesTableView reloadData];
    }];
    [self.view addSubview:_menuView];
    
    _nesTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_nesTableView registerClass:[MainNewsCell class] forCellReuseIdentifier:@"cell"];
    _nesTableView.dataSource = self;
    _nesTableView.delegate = self;
    _nesTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _nesTableView.tableFooterView = [UIView new];
    [self.view addSubview:_nesTableView];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_nesTableView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_nesTableView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_menuView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_menuView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[_menuView(==44)]-1-[_nesTableView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_menuView,_nesTableView)]];
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
