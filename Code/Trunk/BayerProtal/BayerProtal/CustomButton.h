//
//  CustomButton.h
//  BayerProtal
//
//  Created by bts on 15/11/3.
//  Copyright (c) 2015年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton
@property (nonatomic , retain) UILabel *TitleLabel;
@property (nonatomic , retain) UIImageView *CusImageView;
-(void)catageryButton_setTitle:(NSString *)title and:(UIFont*)font;
@end
