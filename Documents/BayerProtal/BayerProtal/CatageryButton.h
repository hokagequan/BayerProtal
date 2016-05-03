//
//  CatageryButton.h
//  testLoad
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatageryButton : UIButton

@property (nonatomic,strong) UILabel *nameLabel;

+(instancetype)makeButtonWithFrame:(CGRect)frame andTitleFrame:(CGRect)titleFrame;

-(void)catageryButton_setTitle:(NSString *)title and:(UIFont*)font;

-(void)set_buttonFrame:(CGRect)frame andTitleFrame:(CGRect)titleFrame andFont:(UIFont*)font;
/*
 * 前提是存在button的frame
 */
-(void)set_title:(NSString *)title and:(UIFont *)font andButtonFrame:(CGRect)frame;

+(CatageryButton *)make_typeTwoButtonWithFrame:(CGRect)frame andTitleFrame:(CGRect)titleFrame;


@end
