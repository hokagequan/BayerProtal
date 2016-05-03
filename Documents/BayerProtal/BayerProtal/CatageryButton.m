//
//  CatageryButton.m
//  testLoad
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "CatageryButton.h"

@implementation CatageryButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return self;
}
+(CatageryButton *)make_typeTwoButtonWithFrame:(CGRect)frame andTitleFrame:(CGRect)titleFrame
{
    CatageryButton *button = [[self alloc] initWithFrame:frame];
    button.nameLabel.frame = titleFrame;
    button.nameLabel.textColor = [UIColor whiteColor];
    button.nameLabel.textAlignment = NSTextAlignmentRight;
    button.nameLabel.numberOfLines = 0;
    [button addSubview:button.nameLabel];
    return button;

}

+(CatageryButton *)makeButtonWithFrame:(CGRect)frame andTitleFrame:(CGRect)titleFrame
{
    CatageryButton *button = [[self alloc] initWithFrame:frame];
    button.nameLabel.frame = titleFrame;
    button.nameLabel.textColor = [UIColor whiteColor];
    button.nameLabel.textAlignment = NSTextAlignmentCenter;
    button.nameLabel.numberOfLines = 0;
    [button addSubview:button.nameLabel];
    return button;
}

-(void)catageryButton_setTitle:(NSString *)title and:(UIFont*)font
{
    _nameLabel.text = title;
    _nameLabel.font = font;

}

-(void)set_buttonFrame:(CGRect)frame andTitleFrame:(CGRect)titleFrame andFont:(UIFont*)font
{
    self.frame = frame;
    _nameLabel.frame = titleFrame;
    _nameLabel.font = font;
    [self addSubview:_nameLabel];
    
}


-(void)set_title:(NSString *)title and:(UIFont *)font andButtonFrame:(CGRect)frame
{
    self.frame = frame;
    _nameLabel.text = title;
    _nameLabel.font = font;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.numberOfLines = 0;

    CGFloat h = [_nameLabel.text stringSizeWithFont:_nameLabel.font size:ccs(VIEW_W(self), VIEW_H(_nameLabel)) breakmode: NSLineBreakByCharWrapping].height;
    _nameLabel.frame = ccr(0, VIEW_H(self)-h, VIEW_W(self), h);
    
    [self addSubview:_nameLabel];
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
