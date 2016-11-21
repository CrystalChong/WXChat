//
//  FriendCell.h
//  WXChat
//
//  Created by zsm on 14-11-26.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UITableViewCell
{
    __weak IBOutlet UIImageView *_userImageView;
    __weak IBOutlet UILabel *_nameLabel;
    
    __weak IBOutlet UILabel *_contentLabel;
}
@property (nonatomic, strong) NSDictionary *friendDic;
@end
