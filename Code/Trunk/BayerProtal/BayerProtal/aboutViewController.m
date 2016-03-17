//
//  aboutViewController.m
//  BayerProtal
//
//  Created by admin on 14-10-24.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "aboutViewController.h"

@interface aboutViewController ()
{
    UIView *aboutView;
    UILabel *label;
}

@end

@implementation aboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLanguage:) name:@"changeLanguage" object:nil];
    [self makeView];
    [self aboutViewLoadData];
}

-(void)changeLanguage:(NSNotification *)noti
{
    [self aboutViewLoadData];
}

-(void)makeView
{
    aboutView = [[UIView alloc]initWithFrame:ccr(1024/6+TabBar_WIDTH/2, Nav_HEIGHT+50, 1024*2/3, 768/3)];
    aboutView.layer.borderWidth = 1;
    aboutView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:aboutView];
    
    label = [[UILabel alloc] initWithFrame:ccr(aboutView.frame.size.width/2-150, aboutView.frame.size.height/2-150, 300, 300)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [aboutView addSubview:label];
    
}

-(void)aboutViewLoadData
{
    if ([UItool isChinese]==YES) {
        label.text = [NSString stringWithFormat:@"拜助理 \n\n版本%@ \n\n拜耳中国版权所有",[UItool getAppVersion]];
        self.titleLabel.text = @"关于";
    }
    else{
        label.text = [NSString stringWithFormat:@"Bay Assistant \n\nVersion%@ \n\nBayer China All Rights Reserved",[UItool getAppVersion]];
        self.titleLabel.text = @"About";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [self henOfView];
    }
    else{
        [self shuOfView];
    }
}

-(void)henOfView
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
}
-(void)shuOfView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            [self shuOfView];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            [self shuOfView];
            break;
        case UIInterfaceOrientationLandscapeLeft:
            [self henOfView];
            break;
        case UIInterfaceOrientationLandscapeRight:
            [self henOfView];
            break;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
