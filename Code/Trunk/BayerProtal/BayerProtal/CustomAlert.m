//
//  CustomAlert.m
//  BayerProtal
//
//  Created by bts on 15/11/4.
//  Copyright (c) 2015年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "CustomAlert.h"
#import "BayerProtal-Swift.h"
#import "AppDelegate.h"

@implementation CustomAlert

#define kTitleYOffset 35.0f
#define kTitleHeight 25.0f
#define kAlertWidth 521.0f
#define kAlertHeight 262.0f
#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content

{
    if (self = [super init]) {
        

        //self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 7.0;
        //self.layer.borderWidth = 5;
        //self.layer.borderColor = CGColorCreateGenericRGB(<#CGFloat red#>, <#CGFloat green#>, <#CGFloat blue#>, <#CGFloat alpha#>)
//        self.layer.borderColor = [UIColor whiteColor].CGColor;
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"熊猫1_03_03"]];
        // self.backgroundColor=[UIColor redColor];
        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kAlertWidth, kAlertHeight)];
        imageView.image = [UIImage imageNamed:@"521"];
        
        [self addSubview:imageView];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, kTitleYOffset, kAlertWidth-145, kTitleHeight)];
        self.alertTitleLabel.textColor = [UIColor colorWithRed:0/255.0 green:145/255.0 blue:195/255.0 alpha:1.0];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        // self.alertTitleLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:64.0/255.0 blue:71.0/255.0 alpha:1];
        self.alertTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.alertTitleLabel];

        CGFloat contentLabelWidth = kAlertWidth - 195;
        self.alertContentLabel = [[UITextView alloc] initWithFrame:CGRectMake(160, kTitleYOffset+kTitleHeight, contentLabelWidth, 100)];
        self.alertContentLabel.textColor = [UIColor blackColor];
        //self.alertContentLabel.numberOfLines = 7;
        self.alertContentLabel.textAlignment  = NSTextAlignmentLeft;
        // self.alertContentLabel.textColor = [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1];
        self.alertContentLabel.font = [UIFont systemFontOfSize:14.0f];
        self.alertContentLabel.scrollEnabled = NO;
        _alertContentLabel.editable = NO;
       // _alertContentLabel.adjustsFontSizeToFitWidth = YES;
        //self.alertContentLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.alertContentLabel];
        
//#define kSingleButtonWidth 160.0f
//#define kCoupleButtonWidth 107.0f
//#define kButtonHeight 40.0f
//#define kButtonBottomOffset 10.0f
        
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
       // _alertContentLabel.backgroundColor = [UIColor redColor];
        
        
//        UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [xButton setImage:[UIImage imageNamed:@"关闭按钮_03"] forState:UIControlStateNormal];
//        [xButton setImage:[UIImage imageNamed:@"关闭按钮_03"] forState:UIControlStateHighlighted];
//        xButton.backgroundColor = [UIColor redColor];
//        xButton.frame = CGRectMake(kAlertWidth - 28, 0, 25, 25);
//        [imageView addSubview:xButton];
//        [xButton addTarget:self action:@selector(dismisAlert) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
  //      [button setImage:[UIImage imageNamed:@"关闭按钮"] forState:UIControlStateNormal];
//       [button setImage:[UIImage imageNamed:@"关闭按钮"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(kAlertWidth - 28, 0, 30, 30);
        [self addSubview:button];
        [button addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(160,  CGRectGetMaxY(self.alertContentLabel.frame), contentLabelWidth, 40)];
        detailLabel.font = [UIFont systemFontOfSize:14];
        //detailLabel.backgroundColor = [UIColor redColor];
        detailLabel.textColor = [UIColor colorWithRed:0/255.0 green:145/255.0 blue:195/255.0 alpha:1.0];
        detailLabel.numberOfLines = 2;
        [self addSubview:detailLabel];
        detailLabel.text = @"祝您拥有精彩的一天，并为拜耳医药保健奉行LIFE价值观成为中国排名第三的跨国制药公司而感到自豪！";
        
        UIButton *OpenButton = [[UIButton alloc]initWithFrame:CGRectMake(kAlertWidth/2-75, CGRectGetMaxY(detailLabel.frame)+5, 150, 35)];
        OpenButton.layer.cornerRadius = 4;
        OpenButton.layer.masksToBounds = YES;
        OpenButton.titleLabel.font = [UIFont systemFontOfSize:13];
        OpenButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:145/255.0 blue:195/255.0 alpha:1.0];
        [OpenButton setTitle:@"有疑问？联系合规！" forState:UIControlStateNormal];
        [self addSubview:OpenButton];
        [OpenButton addTarget:self action:@selector(OpenUrl) forControlEvents:UIControlEventTouchUpInside];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}
- (void)OpenUrl {
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://bsgsgps0297.ap.bayer.cnb:8080/BayAssistant/hegui/index.html"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationPresentHeGui" object:nil];
}
- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    //self.frame = ccr(0, Nav_HEIGHT, 300, 300);
    [topVC.view addSubview:self];
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
- (void)dismissAlert
{
    
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(topVC.view.bounds), kAlertWidth, kAlertHeight);
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        if (_leftLeave) {
            
            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
        }else {
            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        }
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

@end

@implementation UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

