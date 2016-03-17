//
//  HeadView.m
//  BayerProtal
//
//  Created by admin on 14-10-20.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "HeadView.h"
#import "faqInfor.h"

@implementation HeadView
{
    UIButton *_bgButton;
    UIView *view;
    

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";
    
    HeadView *headView = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
        
    }
  
    return headView;
}
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:bgButton];
       
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        bgButton.imageView.contentMode = UIViewContentModeCenter;
//        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [bgButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _bgButton = bgButton;
        _numLabel = [[AttributedLabel alloc] initWithFrame:ccr(5, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height)];
        [_numLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
//        self.layer.borderWidth=0.2;
//        self.layer.borderColor = [UIColor blackColor].CGColor;
        view = [[UIView alloc] initWithFrame:ccr(0, self.bounds.size.height-3, self.bounds.size.width, 1)];
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:_numLabel];
        [self addSubview:view];
        
            }
    return self;
}

-(void)buttonAction:(id)sender
{
    _information.opened = !_information.isOpened;
    
    if ([self.delegate respondsToSelector:@selector(clickHeadView)]) {
        [self.delegate clickHeadView];
    }
    if ([self.delegate respondsToSelector:@selector(clickHeadView:isOpen:)]) {
        [self.delegate clickHeadView:self isOpen:_information.isOpened];
    }
}

- (void)setInformation:(JEFAQContentModel *)information
{
    _information = information;
    //_numLabel.text = @"wdadasdasdasdasdasdasdasdasd";
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _bgButton.frame = self.bounds;
    _numLabel.frame = ccr(10, self.bounds.origin.y, self.bounds.size.width-10, self.bounds.size.height);
    view.frame = ccr(0, self.bounds.size.height-3, self.bounds.size.width, 1);
    //_numLabel.frame = self.bounds;
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
