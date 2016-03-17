//
//  appCellView.h
//  BayerProtal
//
//  Created by admin on 14-10-16.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol appViewDelegate <NSObject>
@optional
-(void)moreButtonAction:(UIButton *)button ;
@end
@interface appCellView : UIView

@property (nonatomic,weak) id <appViewDelegate>delegate;

@property (nonatomic,strong) UIButton *imaButton;

@property (nonatomic,strong) UIButton *moreButton;

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * desLabel;

@property (nonatomic,strong) BYapp *byApp;

@property  CGRect viewFrame;

-(void)makeTheNewUI;
/*
 *  newView
 */
+(id)makeTheNewViewWithFrame:(CGRect)frame;

-(void)makeTheNewUI:(BYapp *)app;

@end
