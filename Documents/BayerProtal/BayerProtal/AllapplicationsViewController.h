//
//  AllapplicationsViewController.h
//  BayerProtal
//
//  Created by admin on 14-11-24.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllapplicationsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>

@property (nonatomic,strong) UITableView * BYlistTableview;

@property (nonatomic,strong) UISearchBar * appSearchBar;

@property (nonatomic,strong) UISearchDisplayController * BYsearchDisplayCon;

@property (nonatomic,strong) UITableView * alertTableView;

@property (nonatomic,strong) UIView *alphaView;



@property (nonatomic,strong) NSMutableArray * tempArray;



@end
