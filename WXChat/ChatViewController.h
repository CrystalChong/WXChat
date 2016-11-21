//
//  ChatViewController.h
//  WXChat
//
//  Created by zsm on 14-12-15.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewExt.h"

@interface ChatViewController : UIViewController

@property (nonatomic,strong) NSDictionary *friendDic;
@property (nonatomic ,assign) BOOL isCall;
@end
