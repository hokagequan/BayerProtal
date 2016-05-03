//
//  ShuView.h
//  BayerProtal
//
//  Created by admin on 14-10-20.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShuView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * BYlistTableview;
@property (nonatomic,strong) NSArray * letterList;
@end
