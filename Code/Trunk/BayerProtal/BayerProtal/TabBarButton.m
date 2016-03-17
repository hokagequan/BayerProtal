//
//  TabBarButton.m
//  BayerProtal
//
//  Created by bts on 15/11/9.
//  Copyright (c) 2015年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        //TabBar_WIDTH, 69
        _CusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, TabBar_WIDTH, 69)];
        _TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_CusImageView.frame)-20,TabBar_WIDTH-20, 20)];
        [self addSubview:_CusImageView];
        _CusImageView.contentMode = 1;
       // [self addSubview:_TitleLabel];
        _TitleLabel.textAlignment = NSTextAlignmentCenter;
        _TitleLabel.font = [UIFont systemFontOfSize:16];
        _TitleLabel.textColor = [UIColor whiteColor];
    }
    return self;
}
-(void)catageryButton_setTitle:(NSString *)title and:(UIFont*)font
{
    _TitleLabel.text = title;
    _TitleLabel.font = font;
    
}

@end
