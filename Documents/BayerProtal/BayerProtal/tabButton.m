
//
//  tabButton.m
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "tabButton.h"

@implementation tabButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(instancetype)newOfbuttonFrame:(CGRect)rect  withTitle:(NSString *)title andTag:(NSInteger)tag
{
    tabButton *buttonView = [[self alloc]initWithFrame:rect];
    buttonView.button = [[UIButton alloc] initWithFrame:ccr(0, 0, rect.size.width, rect.size.height)];
    
    buttonView.button.tag = tag;
    buttonView.tag = tag;
    
//    buttonView.label = [[UILabel alloc] initWithFrame:ccr(3, 3*rect.size.height/4, rect.size.width, rect.size.height/4)];
//    buttonView.label.font = [UIFont systemFontOfSize:18];
//    buttonView.label.textAlignment = NSTextAlignmentCenter;
//    buttonView.label.text = title;
//    [buttonView addSubview:buttonView.label];
    [buttonView addSubview:buttonView.button];
    return buttonView;
}



-(void)setBadgeValueView:(NSString *)num
{
   
        
        UIButton * badgeValueView = [[UIButton alloc] initWithFrame:ccr(self.frame.size.width-60, 0, 40, 40)];
        [badgeValueView setBackgroundImage:[UIImage imageNamed:@"u24.png"] forState:(UIControlStateNormal)];
        
        badgeValueView.titleLabel.font = [UIFont systemFontOfSize:14];
        [badgeValueView setTitle:[NSString stringWithFormat:@"%@",num] forState:(UIControlStateNormal)];
        [badgeValueView setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        badgeValueView.adjustsImageWhenHighlighted = NO;
        
        [self addSubview:badgeValueView];
        
        
    

}

-(void)setImage:(UIImage*)imge forState:(UIControlState)controlState
{
    [self.button setImage:imge forState:controlState];
}
-(void)set_BackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    [self.button setBackgroundImage:image forState:state];
}
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)event
{
    [self.button addTarget:target action:action forControlEvents:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
