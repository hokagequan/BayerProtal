//
//  JEShowImageView.m
//  ImageTest
//
//  Created by 尹现伟 on 14-11-19.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "JEShowImageView.h"

@interface JEShowImageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGRect rect;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation JEShowImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)rotation_icon:(float)n {
    
    //    CGFloat contentoffset_x =self.scrollView.contentOffset.x / VIEW_W(self) ;
    
    if (n == 0.f || n==180.f) {
        self.scrollView.frame = ccr(TabBar_WIDTH, 0, 1024-TabBar_WIDTH, 768-Nav_HEIGHT);
    }else{
        self.scrollView.frame = ccr(TabBar_WIDTH, 0, 1024-TabBar_WIDTH, 768-Nav_HEIGHT);
    }
    
    self.scrollView.contentSize = ccs(VIEW_W(self.scrollView) * self.scrollView.subviews.count, VIEW_H(self.scrollView));
    for (int i =0; i<self.scrollView.subviews.count; i++) {
        id obj = self.scrollView.subviews[i];
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)obj;
            imageView.frame = ccr(i*VIEW_W(self.scrollView), 0, VIEW_W(self.scrollView), VIEW_H(self.scrollView));
        }
    }
    [self.scrollView setContentOffset:ccp(self.pageControl.currentPage * VIEW_W(self), 0)];
}



- (void)orientationChanged:(NSNotification *)note  {      UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    switch (o) {
        case UIDeviceOrientationPortrait:            // Device oriented vertically, home button on the bottom
            [self  rotation_icon:0.0];
            break;
        case UIDeviceOrientationPortraitUpsideDown:  // Device oriented vertically, home button on the top
            [self  rotation_icon:180.0];
            break;
        case UIDeviceOrientationLandscapeLeft :      // Device oriented horizontally, home button on the right
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
            
            [self  rotation_icon:90.0*3];
            break;
        case UIDeviceOrientationLandscapeRight:      // Device oriented horizontally, home button on the left
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
            
            [self  rotation_icon:90.0];
            break;
        default:
            break;
    }
}

- (void)addobserver{
    // Do any additional setup after loading the view from its nib.
    //----- SETUP DEVICE ORIENTATION CHANGE NOTIFICATION -----
    UIDevice *device = [UIDevice currentDevice]; //Get the device object
    [device beginGeneratingDeviceOrientationNotifications]; //Tell it to start monitoring the accelerometer for orientation
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; //Get the notification centre for the app
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:device];
}

- (void)removeobserver{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UIDevice *device = [UIDevice currentDevice]; //Get the device object
    [nc removeObserver:self name:UIDeviceOrientationDidChangeNotification object:device];
}


static CGSize appScreenSize;
static UIInterfaceOrientation lastOrientation;

+(CGSize) screenSize{
    UIInterfaceOrientation orientation =[UIApplication sharedApplication].statusBarOrientation;
    if(appScreenSize.width==0 || lastOrientation != orientation){
        appScreenSize = CGSizeMake(0, 0);
        CGSize screenSize = [[UIScreen mainScreen] bounds].size; // 这里如果去掉状态栏，只要用applicationFrame即可。
        if(orientation == UIDeviceOrientationLandscapeLeft ||orientation == UIDeviceOrientationLandscapeRight){
            // 横屏，那么，返回的宽度就应该是系统给的高度。注意这里，全屏应用和非全屏应用，应该注意自己增减状态栏的高度。
            appScreenSize.width = screenSize.height;
            appScreenSize.height = screenSize.width;
        }else{
            appScreenSize.width = screenSize.width;
            appScreenSize.height = screenSize.height;
        }
        lastOrientation = orientation;
    }
    return appScreenSize;
}

- (void)ShowView:(id)ImageView inView:(UIView *)v{
    [self addobserver];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.frame = ccr(TabBar_WIDTH, Nav_HEIGHT, 1024-TabBar_WIDTH, 768-Nav_HEIGHT);
    self.backgroundColor = [UIColor blackColor];
    if(!self.scrollView){
        self.scrollView = [[UIScrollView alloc]initWithFrame:ccr(0, 0, VIEW_W(self), VIEW_H(self))];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.scrollView.showsHorizontalScrollIndicator=NO;
        self.scrollView.showsVerticalScrollIndicator=NO;
        self.scrollView.delegate = self;
    }
    if (!self.pageControl) {
        self.pageControl = [[UIPageControl alloc]initWithFrame:ccr(0, VIEW_H(self) - 100, VIEW_W(self), 100)];
        self.pageControl.userInteractionEnabled = NO;
        self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    }
    
    [self addSubview:self.scrollView];
    if ([ImageView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)ImageView;
        self.rect = imageView.frame;
        
        UIScrollView *scr = (UIScrollView *)imageView.superview;
        scr.showsHorizontalScrollIndicator=NO;
        scr.showsVerticalScrollIndicator=NO;
        
        if ([scr isKindOfClass:[UIScrollView class]]) {
            NSArray *ary = scr.subviews;
            CGFloat xPos = 0;
            self.pageControl.numberOfPages = ary.count;
            [self.scrollView setContentSize:ccs(ary.count * VIEW_W(self), VIEW_H(self))];
            for (int i = 0;i<ary.count;i++) {
                id obj = ary[i];
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageOld = (UIImageView *)obj;
                    if ([obj isEqual:ImageView]) {
                        xPos = VIEW_W(self) * i;
                        self.pageControl.currentPage = i;
                    }
                    UIImageView *imageV = [[UIImageView alloc]initWithFrame:ccr(i*VIEW_W(self.scrollView), 0, VIEW_W(self), VIEW_H(self))];
                    imageV.userInteractionEnabled= YES;
                    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
                    imageV.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                    [imageV addGestureRecognizer:tapGesture];
                    imageV.image = imageOld.image;
                    imageV.contentMode = UIViewContentModeScaleAspectFit;
                    [self.scrollView addSubview:imageV];
                }
            }
            [self.scrollView setContentOffset:ccp(xPos, 0)];
            [self addSubview:self.pageControl];
        }
        
        [v addSubview:self];
        
    }
}
/*
 - (void)willMoveToSuperview:(UIView *)newSuperview
 {
 self.center = ccp(VIEW_W(self) / 2, VIEW_H(self) / 2);
 self.frame = self.rect;
 
 [UIView animateWithDuration:0.45f animations:^{
 self.frame = ccr(0, 0, [JEShowImageView screenSize].width, [JEShowImageView screenSize].height);
 } completion:^(BOOL finished) {
 
 }];
 [super willMoveToSuperview:newSuperview];
 }
 
 - (void)removeFromSuperview
 {
 [UIView animateWithDuration:0.25f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
 self.frame = self.rect;
 self.center = ccp(VIEW_W(self) / 2, VIEW_H(self) / 2);
 } completion:^(BOOL finished) {
 [super removeFromSuperview];
 }];
 }*/

- (void)event:(UITapGestureRecognizer *)gesture
{
    [self removeobserver];
    [self removeFromSuperview];
}

#pragma makr - UIScrollViewDelegate

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x)/VIEW_W(self);
    
    self.pageControl.currentPage = index;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
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

@implementation UIView (show)
- (void)ShowView:(id)view{
    [[[JEShowImageView alloc]init] ShowView:view inView:self];
}


@end
