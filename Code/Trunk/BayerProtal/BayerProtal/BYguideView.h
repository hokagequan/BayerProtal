//
//  BYguideView.h
//  BayerProtal
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYguideView : UIScrollView<UIScrollViewDelegate>

@property (strong, nonatomic) UIPageControl *page;

-(id)initWithFrame:(CGRect)frame andArray:(NSArray *)array;

@end
