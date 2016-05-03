//
//  JEShowImageView.h
//  ImageTest
//
//  Created by 尹现伟 on 14-11-19.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JEShowImageView : UIControl


- (void)ShowView:(id)ImageView inView:(UIView *)v;

@end
@interface UIView (show)

- (void)ShowView:(id)view;

@end