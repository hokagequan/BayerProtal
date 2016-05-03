//
//  HeadView.h
//  BayerProtal
//
//  Created by admin on 14-10-20.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JEFAQContentModel.h"
#import "AttributedLabel.h"


@class faqInfor,HeadView;
@protocol headViewDelegate <NSObject>
@optional
-(void)clickHeadView;

-(void)clickHeadView:(HeadView *)headView isOpen:(BOOL)isOpen;

@end
@interface HeadView : UITableViewHeaderFooterView

+ (instancetype)headViewWithTableView:(UITableView *)tableView ;

@property (nonatomic,weak)id<headViewDelegate>delegate;

@property (nonatomic,strong) JEFAQContentModel *information;

@property (nonatomic,strong)AttributedLabel *numLabel;

@property  NSInteger section;

@end
