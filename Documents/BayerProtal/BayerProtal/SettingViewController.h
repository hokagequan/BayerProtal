//
//  SettingViewController.h
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *NavView;

@property (nonatomic,strong) UITableView *firstView;

@property (nonatomic,strong) UITableView *secondView;

@property (nonatomic,strong) UIButton * exitButton;

@end
