//
//  BYtabButton.m
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "BYtabButton.h"

@implementation BYtabButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)set_Image:(UIImage *)image for_State:(UIControlState)controlState
{
    [self setImage:nil forState:controlState];
    if (controlState==UIControlStateSelected) {
        self.imgView.image = image;
    }
    
}

+(instancetype)newOfbuttonFrame:(CGRect)rect setImage:(UIImage *)image withTitle:(NSString *)title
{
    BYtabButton *button = [[self alloc] initWithFrame:rect];
    button.imgView = [[UIImageView alloc] initWithFrame:ccr(2, 2, rect.size.width-4, 3*rect.size.height/4-4)];
    button.imgView.image = image;
    
    button.label = [[UILabel alloc] initWithFrame:ccr(3, 3*rect.size.height/4, rect.size.width, rect.size.height/4)];
    button.label.text = title;
    
    [button addSubview:button.label];
    [button addSubview:button.imgView];
    
    return button;
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
