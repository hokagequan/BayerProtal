//
//  MenuButton.m
//  BayerProtal
//
//  Created by admin on 14-9-28.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "MenuButton.h"

@implementation MenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(instancetype)newOfButtonWithTitle:(NSString *)title andDescrption:(NSString*)description andFrame:(CGRect)frame and:(NSString *)ima and:(NSInteger)btTag and:(SEL)action
{
    MenuButton *button = [[self alloc] initWithFrame:frame];
    button.tilLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    button.desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    button.tilLabel.text = title;
    button.tilLabel.font = [UIFont systemFontOfSize:24];
    button.tilLabel.textColor = [UIColor colorWithRed:95/255.0 green:158/255.0 blue:160/255.0 alpha:1];
    button.tilLabel.textAlignment = NSTextAlignmentCenter;
    button.desLabel.textAlignment = NSTextAlignmentCenter;
    button.desLabel.numberOfLines = 0;
    button.desLabel.text = description;
    
    // 32 178 170
    //[@"" boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>]
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    button.desLabel.textAlignment = NSTextAlignmentCenter;
    button.desLabel.numberOfLines = 0;
  //  NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:button.desLabel.font,NSFontAttributeName,nil];
    
    NSDictionary *attributes = @{NSFontAttributeName:button.desLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
   button.desSize = [button.desLabel.text boundingRectWithSize:CGSizeMake(frame.size.width, frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
//    button.desSize = [ button.desLabel.text sizeWithFont: button.desLabel.font constrainedToSize:CGSizeMake(frame.size.width, frame.size.height*2/3) lineBreakMode:NSLineBreakByTruncatingTail];
    button.tilLabel.textAlignment = NSTextAlignmentCenter;
    button.tilLabel.numberOfLines = 0;
    
    
    NSDictionary *attributes2 = @{NSFontAttributeName: button.tilLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    button.desSize = [button.desLabel.text boundingRectWithSize:CGSizeMake(frame.size.width, frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes2 context:nil].size;
     //button.titleSize = [ button.tilLabel.text sizeWithFont: button.tilLabel.font constrainedToSize:CGSizeMake(frame.size.width, frame.size.height*1/3) lineBreakMode:NSLineBreakByTruncatingTail];
    NSLog(@"%f",frame.size.width);
    button.desLabel.frame = ccr(0, frame.size.height-button.desSize.height-5, frame.size.width, button.desSize.height);
    button.tilLabel.frame = ccr(0, frame.size.height- button.titleSize.height- button.titleSize.height-20, frame.size.width,  button.titleSize.height);
    [button addSubview:button.tilLabel];
    [button addSubview:button.desLabel];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 1;
    button.tag = btTag;
    [button setBackgroundImage:[UIImage imageNamed:ima] forState: UIControlStateNormal];
    [button addTarget:nil action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
}
//cccc改
//-(void)set_Frame:(CGRect)frame
//{
//    self.frame = frame;
//    //self.desSize = [ self.desLabel.text sizeWithFont: self.desLabel.font constrainedToSize:CGSizeMake(frame.size.width, frame.size.height*2/3) lineBreakMode:NSLineBreakByTruncatingTail];
//   // self.titleSize = [ self.tilLabel.text sizeWithFont: self.tilLabel.font constrainedToSize:CGSizeMake(frame.size.width, frame.size.height*1/3) lineBreakMode:NSLineBreakByTruncatingTail];
//    self.desLabel.frame = ccr(0, frame.size.height-self.desSize.height-5, frame.size.width, self.desSize.height);
//    self.tilLabel.frame = ccr(0, frame.size.height-self.desSize.height-self.titleSize.height-20, frame.size.width, self.titleSize.height);
//    [self addSubview:self.titleLabel];
//    [self addSubview:self.desLabel];
//}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
