//
//  JEFAQTableViewCell.h
//  BayerProtal
//
//  Created by 尹现伟 on 14/10/27.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UtilityKit/UtilityKit.h>

@interface JEFAQTableViewCell : UITableViewCell

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) NSString *HTMLdata;

- (void)loadData:(id)data;
@end
