//
//  BYTabBarController.h
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BYTabBardelegate <NSObject>
@optional
//横屏
-(void)fitTheLandScreen;
//竖屏
-(void)fitTheVerticalScreen;

/**
*  刷新功能
*/
-(void)refreshCurrentViewController;

@end

@interface BYTabBarController : UITabBarController

@property (nonatomic,weak)id<BYTabBardelegate>tabDelegate;

@property (nonatomic,weak) UIButton * selectBtn;

@property (nonatomic,strong) UIView * myTabView;

@property (nonatomic)BOOL open;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UIButton *hiddenBT;



@end
