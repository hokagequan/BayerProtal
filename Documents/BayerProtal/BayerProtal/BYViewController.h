//
//  BYViewController.h
//  BayerProtal
//
//  Created by admin on 14-9-24.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYTabBarController.h"



@interface BYViewController : UIViewController<BYTabBardelegate,UISearchBarDelegate>

@property (nonatomic,strong) UIView *tabView;

@property (nonatomic, strong) UIWindow * window;

@property (nonatomic,strong) UITabBarController *tabController;

@property (nonatomic,strong) UITableView *contentTableView;



@end
