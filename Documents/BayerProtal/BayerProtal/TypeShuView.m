//
//  TypeShuView.m
//  BayerProtal
//
//  Created by admin on 14-10-21.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "TypeShuView.h"
#import "appCellView.h"
#import "BYapp.h"

@implementation TypeShuView
@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:ccr(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:scrollView];
        scrollView.scrollEnabled = YES;
        scrollView.delaysContentTouches = YES;
    }
    return self;
}


-(void)typeShuViewInitWithList:(NSArray *)dic
{
    
    CGFloat widthScreen = [dic count]*100+20*([dic count]+1);
    if (widthScreen>SCREEN_HEIGHT) {
        [scrollView setContentSize:ccs(SCREEN_WIDTH, widthScreen)];
    }
    else{
        [scrollView setContentSize:ccs(SCREEN_WIDTH, SCREEN_HEIGHT)];
    }

    
int i =0;
int k = 0;
CGFloat height = 100;
CGFloat width = 200;
CGFloat X = 350;
CGFloat Y = 100;
//CGFloat space = 10;
int m = [dic count]%2!=0?[dic count]+1:[dic count];
int n = m/2;
int j = [dic count]<2?1:2;
int l = 0;
for ( i = 0;i<n;i++) {
    for (k=0; k<j;k++ ) {
        appCellView  * view = [[appCellView alloc] initWithFrame:ccr(X*k, Y*i+20*(i+1), width, height)];
        if (l<[dic count]) {
            BYapp *app = [dic objectAtIndex:l];
            view.nameLabel.text = app.appCname;
            view.desLabel.text = @"helloWordhahahhah";
            view.moreButton.tag = [app.appId intValue];
            [view.imaButton setBackgroundImage:[UIImage imageNamed:@"faq.png"] forState:UIControlStateNormal];
            [view.moreButton setBackgroundImage:[UIImage imageNamed:@"faq.png"] forState:UIControlStateNormal];
            l++;
        }
        
       // CGSize size = [UItool getTheLabelSize:view.nameLabel];
        [view makeTheNewUI];
        [scrollView addSubview:view];
        
        //            if (n>1&&[dic count]%2!=0&&(i+1==n&&k+1==j)) {
        //                    [view removeFromSuperview];
        //                        }
    }
    //             l<[dic count]?l++:100;
    
}
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
