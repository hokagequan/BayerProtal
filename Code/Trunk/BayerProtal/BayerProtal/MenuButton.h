//
//  MenuButton.h
//  BayerProtal
//
//  Created by admin on 14-9-28.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuButton : UIButton

@property (nonatomic,strong)UILabel *tilLabel;
@property (nonatomic,strong)UILabel *desLabel;
@property CGSize desSize;
@property CGSize titleSize;

+(instancetype)newOfButtonWithTitle:(NSString *)title andDescrption:(NSString*)description andFrame:(CGRect)frame and:(NSString *)ima and:(NSInteger)btTag and:(SEL)action;

//-(void)set_Frame:(CGRect)frame;

@end
