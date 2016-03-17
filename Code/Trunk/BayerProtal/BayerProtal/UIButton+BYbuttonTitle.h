//
//  UIButton+BYbuttonTitle.h
//  BayerProtal
//
//  Created by admin on 14-9-26.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BYbuttonTitle)


+(instancetype)newOfButtonWithTitle:(NSString *)title andDescrption:(NSString*)description andFrame:(CGRect)frame and:(NSString *)ima and:(NSInteger)btTag and:(SEL)action;

-(void)set_Frame:(CGRect)frame;

-(void)newOf_ButtonWithTitle:(NSString *)title andDescrption:(NSString*)description andFrame:(CGRect)frame and:(NSString *)ima and:(NSInteger)btTag and:(SEL)action;

-(void)setBadgeValueView:(NSString *)num;
@end
