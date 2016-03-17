//
//  MessageTableViewCell.h
//  BayerProtal
//
//  Created by admin on 14-10-10.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *desLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *detailButton;

-(void)initWithDescrption:(BYinformation *)info;
-(void)initWithDescrptions:(NSString *)info;

@end
