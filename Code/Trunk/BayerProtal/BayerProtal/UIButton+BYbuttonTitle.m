//
//  UIButton+BYbuttonTitle.m
//  BayerProtal
//
//  Created by admin on 14-9-26.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "UIButton+BYbuttonTitle.h"

@implementation UIButton (BYbuttonTitle)

+(instancetype)newOfButtonWithTitle:(NSString *)title andDescrption:(NSString*)description andFrame:(CGRect)frame and:(NSString *)ima and:(NSInteger)btTag and:(SEL)action
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor colorWithRed:95/255.0 green:158/255.0 blue:160/255.0 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.numberOfLines = 0;
    desLabel.text = description;
    // 32 178 170
    //[@"" boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>]
    //NSDictionary *attributes = @{NSFontAttributeName:desLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [desLabel.text boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
    //CGSize size1 = [desLabel.text sizeWithFont:desLabel.font constrainedToSize:CGSizeMake(frame.size.width, frame.size.height*2/3) lineBreakMode:NSLineBreakByTruncatingTail];
   // CGSize titleSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(frame.size.width, frame.size.height*1/3) lineBreakMode:NSLineBreakByTruncatingTail];
     CGSize titleSize=[desLabel.text boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
    desLabel.frame = ccr(0, frame.size.height-size.height-5, frame.size.width, size.height);
    titleLabel.frame = ccr(0, frame.size.height-size.height-titleSize.height-20, frame.size.width, titleSize.height);
    [button addSubview:titleLabel];
    [button addSubview:desLabel];
     button.layer.borderColor = [UIColor blackColor].CGColor;
     button.layer.borderWidth = 1;
     button.tag = btTag;
    [button setBackgroundImage:[UIImage imageNamed:ima] forState: UIControlStateNormal];
    [button addTarget:nil action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
}

-(void)newOf_ButtonWithTitle:(NSString *)title andDescrption:(NSString*)description andFrame:(CGRect)frame and:(NSString *)ima and:(NSInteger)btTag and:(SEL)action
{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor colorWithRed:95/255.0 green:158/255.0 blue:160/255.0 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.numberOfLines = 0;
    desLabel.text = description;
    // 32 178 170
    //[@"" boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>]
    
//    CGSize size = [desLabel.text sizeWithFont:desLabel.font constrainedToSize:CGSizeMake(frame.size.width, frame.size.height*2/3) lineBreakMode:NSLineBreakByTruncatingTail];
//    CGSize titleSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(frame.size.width, frame.size.height*1/3) lineBreakMode:NSLineBreakByTruncatingTail];
//    desLabel.frame = ccr(0, frame.size.height-size.height-5, frame.size.width, size.height);
//    titleLabel.frame = ccr(0, frame.size.height-size.height-titleSize.height-20, frame.size.width, titleSize.height);
    [self addSubview:titleLabel];
    [self addSubview:desLabel];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1;
    self.tag = btTag;
    [self setBackgroundImage:[UIImage imageNamed:ima] forState: UIControlStateNormal];
    [self addTarget:nil action:action forControlEvents:UIControlEventTouchUpInside];
    

}

-(void)set_Frame:(CGRect)frame
{
    
}

-(void)setBadgeValueView:(NSString *)num
{
    UIButton * badgeValueView = (UIButton *)[self viewWithTag:100000];
    if (!badgeValueView) {
        badgeValueView = [[UIButton alloc] initWithFrame:ccr(self.bounds.size.width - 40, 0, 40, 40)];
    }
     badgeValueView.tag = 100000;
    [badgeValueView setBackgroundImage:[UIImage imageNamed:@"u24.png"] forState:(UIControlStateNormal)];
    
    badgeValueView.titleLabel.font = [UIFont systemFontOfSize:14];
    [badgeValueView setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    badgeValueView.adjustsImageWhenHighlighted = NO;
    [self addSubview:badgeValueView];
    [self bringSubviewToFront:badgeValueView];
    
    if (![num isEqualToString:@"0"]) {
        badgeValueView.hidden = NO;
        [badgeValueView setTitle:[NSString stringWithFormat:@"%@",num] forState:(UIControlStateNormal)];
        
    }
    
    else{
        badgeValueView.hidden = YES;
    }
}

@end
