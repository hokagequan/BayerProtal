//
//  LastViewController.m
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "LastViewController.h"

@interface LastViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LastViewController
{
    UILabel *label;
    UIScrollView *lastScroll;
    UILabel * titleLabel;
    UIImageView *lognBt;
    CGFloat labelH;
}
@synthesize navView;

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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLastViewLanguage:) name:@"changeLanguage" object:nil];
     self.view.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
     [self CreateNavgationView];
     [self makeView];
     [self lastViewLoadData];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
       [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
        
    }
    else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
        
    }
}


-(void)makeView
{
    self.webView = [[UIWebView alloc]initWithFrame:ccr(TabBar_WIDTH, Nav_HEIGHT, 1024-TabBar_WIDTH, 768 - (Nav_HEIGHT))];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    [self.view addSubview:self.webView];
    
    NSLog(@"%f",self.view.frame.size.height);
//  lastScroll = [[UIScrollView alloc] initWithFrame:ccr(0, Nav_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - (Nav_HEIGHT))];
//    lastScroll.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
//    lastScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [lastScroll setContentSize:ccs(self.view.frame.size.width, SCREEN_HEIGHT*2)];
//    [self.view addSubview:lastScroll];
//    
//    label = [[UILabel alloc] initWithFrame:ccr(10, 0, self.view.frame.size.width-20, self.view.frame.size.height*3)];
//    label.numberOfLines = 0;
//    label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
//    [lastScroll addSubview:label];
    
}

-(void)lastViewLoadData
{
    if ([UItool isChinese]==YES) {
        titleLabel.text = @"信息";
        NSString *path = [JEUtits pathWithFileName:@"Info-Cn"];
        NSString *HTMLData = [JEUtits stringWithPath:path];
        [self.webView loadHTMLString:HTMLData baseURL:[[NSBundle mainBundle]bundleURL]];
    }
    else{
        titleLabel.text = @"Information";
        NSString *path = [JEUtits pathWithFileName:@"Info-En"];
        NSString *HTMLData = [JEUtits stringWithPath:path];
        [self.webView loadHTMLString:HTMLData baseURL:[[NSBundle mainBundle]bundleURL]];
    }
}

-(void)changeLastViewLanguage:(NSNotification *)noti
{
    [self lastViewLoadData];
}

//-(void)henOfLastview
//{
//    lastScroll = [[UIScrollView alloc] initWithFrame:ccr(0, Nav_HEIGHT, self.view.frame.size.height, self.view.frame.size.width - (Nav_HEIGHT))];
//    labelH = [label.text stringSizeWithFont:label.font size:ccs(VIEW_H(self.view), 10000) breakmode: NSLineBreakByCharWrapping].height;
//    label.frame = ccr(10, 0, self.view.frame.size.width-20, labelH+50);
//    [lastScroll setContentSize:ccs(self.view.frame.size.height, labelH+100)];
//}
//-(void)shuOfLastView
//{
//    lastScroll = [[UIScrollView alloc] initWithFrame:ccr(0, Nav_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - (Nav_HEIGHT))];
//    labelH = [label.text stringSizeWithFont:label.font size:ccs(VIEW_W(label), 10000) breakmode: NSLineBreakByCharWrapping].height;
//    label.frame = ccr(10, 0, self.view.frame.size.width-20, labelH+50);
//    [lastScroll setContentSize:ccs(self.view.frame.size.width, labelH+100)];
//}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];

            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];

            break;
        case UIInterfaceOrientationLandscapeLeft:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];

            break;
        case UIInterfaceOrientationLandscapeRight:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];

            break;
            
        default:
            break;
    }
}

-(void)CreateNavgationView{
    
    navView = [[UIView alloc] initWithFrame:ccr(0, 0, 1024, Nav_HEIGHT)];
    navView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    navView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    titleLabel = [[UILabel alloc] initWithFrame:ccr(1024/2-100, Nav_HEIGHT/2-50, 200, 100)];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:30];
    [navView addSubview:titleLabel];
    [self.view addSubview:navView];
    
    lognBt = [[UIImageView alloc] initWithFrame:ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-53)/2, 53, 53)];
    lognBt.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [navView addSubview:lognBt];
    lognBt.image = [UIImage imageNamed:@"logo.png"];
    lognBt.hidden = YES;
    titleLabel.frame = ccr(SCREEN_WIDTH/2-100, navView.frame.size.height/2-35, 200, 100);
    lognBt.frame = ccr(1024-80, (Nav_HEIGHT-45)/2, 53, 53);
    //[lognBt setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
