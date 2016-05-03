//
//  BYloadView.h
//  BayerProtal
//
//  Created by admin on 14-10-30.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MONActivityIndicatorView.h"
@interface BYloadView : UIView<MONActivityIndicatorViewDelegate>


@property (nonatomic,strong)MONActivityIndicatorView * activityView;

@property (nonatomic,strong)UIView *myView;

+(void)loadState:(BOOL)isload;

-(void)loadStop;
+(BYloadView *)shareLoadView;
-(void)ccloadState:(BOOL)isload;

+(void)ccloadStop;



@end