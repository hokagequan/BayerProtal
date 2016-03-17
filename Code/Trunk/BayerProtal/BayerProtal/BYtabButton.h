//
//  BYtabButton.h
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYtabButton : UIButton

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *label;


+(instancetype)newOfbuttonFrame:(CGRect)rect setImage:(UIImage *)image withTitle:(NSString *)title;

-(void)set_Image:(UIImage *)image for_State:(UIControlState)controlState;


@end
