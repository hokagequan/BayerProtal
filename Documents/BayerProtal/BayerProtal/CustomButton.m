//
//  CustomButton.m
//  BayerProtal
//
//  Created by bts on 15/11/3.
//  Copyright (c) 2015年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        _CusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-40, frame.size.height/2-60, 80, 80)];
        _TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_CusImageView.frame)+20, frame.size.width-10, 20)];
        [self addSubview:_CusImageView];
        [self addSubview:_TitleLabel];
        _TitleLabel.textAlignment = NSTextAlignmentCenter;
        _TitleLabel.font = [UIFont systemFontOfSize:21];
    }
    return self;
}
-(void)catageryButton_setTitle:(NSString *)title and:(UIFont*)font
{
    _TitleLabel.text = title;
    _TitleLabel.font = font;
    
}
@end
