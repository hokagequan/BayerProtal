//
//  BYloadView.m
//  BayerProtal
//
//  Created by admin on 14-10-30.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "BYloadView.h"

@implementation BYloadView
static BYloadView* shareLoadView=nil;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        //self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self addSubview:[self myView]];
    }
    return self;
}


-(UIView *)myView
{
    _myView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-150, self.frame.size.height/2-150, 300, 300)];
     //_myView.backgroundColor = [UIColor redColor];
    UIImageView *imagView = [[UIImageView alloc]initWithFrame:CGRectMake(_myView.frame.size.width/2-24, 0, 48, 48)];
    imagView.image = [UIImage imageNamed:@"logo.png"];
    [_myView addSubview:imagView];
    
    UIImageView *imagView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0,100, 290, 100)];
    imagView2.image = [UIImage imageNamed:@"title.png"];
    [_myView addSubview:imagView2];
    
    UIImageView *imagView3 = [[UIImageView alloc]initWithFrame:CGRectMake(250,50, 100, 100)];
    imagView3.image = [UIImage imageNamed:@"light.png"];
    [_myView addSubview:imagView3];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imagView2.frame.origin.y+imagView2.frame.size.height, 300, 50)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:33];
    label.text = @"Bay Assistant";
    [_myView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height,200, 50)];
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:30];
    label2.text = @"LOADING";
    [_myView addSubview:label2];
    
    if (_activityView==nil) {
        _activityView = [[MONActivityIndicatorView alloc] init];
        _activityView.delegate = self;
        _activityView.numberOfCircles = 6;
        _activityView.radius = 7;
        _activityView.internalSpacing = 3;
        _activityView.frame = CGRectMake(label2.frame.origin.x+label2.frame.size.width, label.frame.origin.y+label.frame.size.height+25,50, 50);
        [_myView addSubview:_activityView];
    }
    
    
    _myView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    return _myView;
}

+(void)loadState:(BOOL)isload
{
    BYloadView *loadView = [ self shareLoadView];
    loadView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    UIViewController *topVC = [loadView appRootViewController];
    //loadView.autoresizesSubviews = YES;
    if (UIInterfaceOrientationIsLandscape(topVC.interfaceOrientation)) {
        loadView.frame = ccr(0, 0, 1024, 768);
    //loadView.myView.frame = ccr(loadView.frame.size.height/2-150, loadView.frame.size.width/2-150, 300, 300);
    }
    else{
        loadView.frame = ccr(0, 0, 1024,768);
       // loadView.myView.frame = ccr(loadView.frame.size.width/2-150, loadView.frame.size.height/2-150, 300, 300);

    }
    [loadView sizeToFit];
    [topVC.view addSubview:loadView];
    
    if (isload==YES) {
        [loadView.activityView startAnimating];
    }
    else{
        [loadView.activityView stopAnimating];
        [loadView removeFromSuperview];
    }
    
}

+(void)ccloadStop
{
   BYloadView *loadView = [ self shareLoadView];
    [loadView.activityView stopAnimating];
    //        [loadView removeFromSuperview];
}

-(void)ccloadState:(BOOL)isload
{
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    UIViewController *topVC = [self appRootViewController];
    self.autoresizesSubviews = YES;
    if (UIInterfaceOrientationIsLandscape(topVC.interfaceOrientation)) {
        self.frame = ccr(0, 0, topVC.view.frame.size.height, topVC.view.frame.size.height);
    }
    else{
        self.frame = ccr(0, 0, topVC.view.frame.size.width, topVC.view.frame.size.height);
    }
    [self sizeToFit];
    [topVC.view addSubview:self];
    
    if (isload==YES) {
        [self.activityView startAnimating];
    }
    
//    else{
//        [self.activityView stopAnimating];
//        [self removeFromSuperview];
//    }
}

-(void)loadStop
{
    [_activityView stopAnimating];
    [self removeFromSuperview];
}

- (UIViewController *)appRootViewController
{
    UIViewController *result = nil;
    
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;

    
    
//    
//    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UIViewController *topVC = appRootVC;
//    if (topVC.presentedViewController) {
//        while (topVC.presentedViewController) {
//            topVC = topVC.presentedViewController;
//        }
//    }
//    
//    
//    return topVC;
}



- (UIWindow *)systemWindow {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    
    return window;
}




- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


//创建一个单例类
+(BYloadView *)shareLoadView
{
    @synchronized(self)
    {
        if (shareLoadView==nil) {
            shareLoadView = [[self alloc] init];
             //[shareLoadView addSubview:[shareLoadView myView]];
            }
       
    }
    return shareLoadView;
}


+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (shareLoadView == nil)
        {
            shareLoadView = [super allocWithZone:zone];
            return shareLoadView;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
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
