//
//  FriendsViewController.h
//  WXChat
//
//  Created by zsm on 14-12-5.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
@interface FriendsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic, retain) NSArray *dataList;

@end
