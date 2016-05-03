//
//  FAQViewController.h
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"

@interface FAQViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) UIView *NavView;

@property (nonatomic,strong) UIWebView * webView;

@property (nonatomic,strong) UITableView *faqTableView;

@property (nonatomic,strong) UIButton *myButton;

@property NSInteger isOpen;

@property (nonatomic,strong) UISearchBar * faqSearchBar;


@end
