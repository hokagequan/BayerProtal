//
//  MessageViewController.h
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UITableView * messageListTableView;

@property (nonatomic,strong) NSArray * desList;
@property (nonatomic,strong) NSArray * timeList;

@property (nonatomic,strong) UISearchBar * messageSearchBar;


@end
