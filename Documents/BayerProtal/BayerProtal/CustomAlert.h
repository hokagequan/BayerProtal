//
//  CustomAlert.h
//  BayerProtal
//
//  Created by bts on 15/11/4.
//  Copyright (c) 2015年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "DXAlertView.h"

@interface CustomAlert : UIView{
    BOOL _leftLeave;
}

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
;

- (void)show;
- (void)dismissAlert;
@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UITextView *alertContentLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;
@end

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

