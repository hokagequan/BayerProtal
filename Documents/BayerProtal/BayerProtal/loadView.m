//
//  loadView.m
//  testLoadview
//
//  Created by admin on 14-10-30.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "loadView.h"

@implementation loadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
    }
    return self;
}

-(void)starte
{
    UIViewController *conView = [[UIViewController alloc]init];
    self.frame = conView.view.frame;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;;
    self.gpView = [[GPLoadingView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-25, self.frame.size.height/2-25, 50, 50)];
    UIImageView *imaView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-50, self.frame.size.height/2-70, 100, 33)];
    imaView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.gpView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    imaView.image = [UIImage imageNamed:@"title.png"];
   
    [self addSubview:self.gpView];
     [self addSubview:imaView];
    [conView.view addSubview:self];
    [self.gpView startAnimation];
}
-(void)stop
{
    [self.gpView stopAnimation];
    [self removeFromSuperview];
}


- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
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
