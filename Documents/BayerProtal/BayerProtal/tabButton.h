//
//  tabButton.h
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol tabButtonDelegate <NSObject>
@optional
-(void)tabOrHidden;


@end
@interface tabButton : UIView


@property (nonatomic,strong) UIButton * button;

@property (nonatomic,strong) UILabel *label;

@property (nonatomic,weak)id<tabButtonDelegate>delegate;

//@property (nonatomic,strong) UIButton *badgeValueView;

+(instancetype)newOfbuttonFrame:(CGRect)rect  withTitle:(NSString *)title andTag:(NSInteger)tag;
//


-(void)set_BackgroundImage:(UIImage *)image forState:(UIControlState)state;

-(void)setImage:(UIImage*)imge forState:(UIControlState)controlState;

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)event;

-(void)setBadgeValueView:(NSString *)num;



@end
