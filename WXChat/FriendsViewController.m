//
//  FriendsViewController.m
//  WXChat
//
//  Created by zsm on 14-12-5.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendCell.h"
#import "ChatViewController.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"好友列表";
    
    // 1.初始化数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Friends" ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSMutableDictionary *subDic in array) {
        [mArray addObject:[subDic mutableCopy]];
    }
    self.dataList = mArray;
    
    // 2.初始化子视图
    [self _initView];
}

// 2.初始化子视图
- (void)_initView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 获取当前组所在的字典
    NSDictionary *groupDic = [self.dataList objectAtIndex:section];
    if ([groupDic[@"opened"] boolValue]) {
        // 获取改组的好友
        NSArray *friends = groupDic[@"friends"];
        return friends.count;
    } else {
        return 0;
    }
    
}

/*
    {
        root:[    //好友分组
                {   //好友组的详情
                    groupName:"我的好友",
                    loginNum:"10",   
                    opened:@YES,
                    friends:[
                                {
                                    gid:"123456",
                                    name:"朱思明",
                                    content:"个性签名"
                                },...
                            ]
                },...
             ]
    }
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellid";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendCell" owner:self options:nil] lastObject];
    }
    
    // 获取当前组所在的字典
    NSDictionary *groupDic = [self.dataList objectAtIndex:indexPath.section];
    // 获取改组的好友
    NSArray *friends = groupDic[@"friends"];
    cell.friendDic = friends[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    headView.delegate = self;
    headView.friendGroup = self.dataList[section];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取当前组所在的字典
    NSDictionary *groupDic = [self.dataList objectAtIndex:indexPath.section];
    // 获取改组的好友
    NSArray *friends = groupDic[@"friends"];
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    chatVC.friendDic = friends[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
    
}

#pragma mark - HeadViewDelegate
- (void)clickHeadView
{
    [_tableView reloadData];
}

@end
