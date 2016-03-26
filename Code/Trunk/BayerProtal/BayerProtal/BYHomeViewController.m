//
//  BYHomeViewController.m
//  BayerProtal
//
//  Created by admin on 14-10-23.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "BYHomeViewController.h"
#import "AppDelegate.h"

#import "BYViewController.h"
#import "BYTabBarController.h"
#import "MessageViewController.h"
#import "FAQViewController.h"
#import "RefreshViewController.h"
#import "SettingViewController.h"
#import "LastViewController.h"
#import "BPush.h"
#import "IpaRequestManger.h"
@interface BYHomeViewController ()<UIScrollViewDelegate>
{
    UIView *navView;
    UIButton *chineseBut;
    UIButton *englishBut;
    UIButton *muserButOne;
    UIButton *muserButTwo;
    UIView *contentHenView;
    UIView *contentShuView;
    
    UIScrollView * byScrollView;
    NSMutableArray *imalist;
    NSArray * array;
    UIPageControl *page;
    UIButton *button;
    BOOL isHen;
    UILabel *label;
    UIButton *muserHenbut3;
    UIButton *muserHenbut5;
    UIButton *muserHenbut2;

}
@property (nonatomic, assign) int lastPageIndex;

@end

@implementation BYHomeViewController

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
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"on" forKey:@"isVoiceOn"];
    [[NSUserDefaults standardUserDefaults]setObject:@"on" forKey:@"DataSynchronization"];
    
    [self makeView];
    
//    if (![[[NSUserDefaults standardUserDefaults]stringForKey:@"FirstLogin"] isEqualToString:[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"]])
//    {
//        
//    //加载引导页
//    [[NSUserDefaults standardUserDefaults] setValue:[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"] forKey:@"FirstLogin"];
//        [self makeGuideView];
//    
//     }

    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [self henOfHomeView];
           }
    else{
        [self shuOfHomeView];
    }
}

-(void)henOfHomeView
{
    if (contentShuView) {
        contentShuView.hidden = YES;
        contentHenView.hidden = NO;
        
    }
    
    byScrollView.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    NSArray *imaArr= [NSArray arrayWithObjects:@"app_category -提示1 横屏.jpg",@"app_category -提示2 横屏.jpg", nil];
    for (int i=0; i<[imalist count]; i++) {
        UIImageView *imView = [imalist objectAtIndex:i];
        imView.frame = CGRectMake(self.view.frame.size.height*i , 0, self.view.frame.size.height, self.view.frame.size.width);
        if (i<[imaArr count]) {
            imView.image = [UIImage imageNamed:[imaArr objectAtIndex:i ]];
        }
        
        if (i == array.count - 1) {
            imView.userInteractionEnabled = YES;
//            button.frame = ccr(0, 0, VIEW_W(imView), VIEW_H(imView));
            button.frame = CGRectMake(VIEW_H(self.view) - 270, self.view.frame.size.width/2 + 60, 200, 90);
            [imView addSubview:button];
        }
    }
    isHen = YES;
    [byScrollView setContentSize:CGSizeMake(self.view.frame.size.height*([array count] + 1), self.view.frame.size.width)];
    [byScrollView setContentOffset:CGPointMake(self.view.frame.size.height*page.currentPage, 0)];
}

-(void)shuOfHomeView
{
    if (contentHenView) {
        contentShuView.hidden = NO;
        contentHenView.hidden = YES;
        }
   
    isHen = NO;
    byScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    NSArray *imaArr= [NSArray arrayWithObjects:@"app_category -提示1 竖屏.jpg",@"app_category -提示2 竖屏.jpg", nil];
     for (int i=0; i<[imaArr count]; i++) {
        UIImageView *imView = [imalist objectAtIndex:i];
        imView.frame = CGRectMake(self.view.frame.size.width*i , 0, self.view.frame.size.width, self.view.frame.size.height);
         if (i<[imaArr count]) {
             imView.image = [UIImage imageNamed:[imaArr objectAtIndex:i ]];
         }
        if (i == array.count - 1) {
            imView.userInteractionEnabled = YES;
//            button.frame = ccr(0, 0, VIEW_W(imView), VIEW_H(imView));
            button.frame = CGRectMake(VIEW_W(self.view) - 200, VIEW_H(self.view)/2 + 100, 130, 80);
            [imView addSubview:button];
        }
    }
    [byScrollView setContentSize:CGSizeMake(self.view.frame.size.width*([array count]+1), self.view.frame.size.height)];
    [byScrollView setContentOffset:CGPointMake(self.view.frame.size.width*page.currentPage, 0)];
}

-(void)makeGuideView
{
    imalist = [NSMutableArray array];
    byScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [byScrollView setShowsHorizontalScrollIndicator:NO];
    [byScrollView setShowsVerticalScrollIndicator:NO];
    byScrollView.pagingEnabled = YES;
    byScrollView.bounces = NO;
    byScrollView.delegate = self;
    [self.view addSubview:byScrollView];
    array = [[NSArray alloc] initWithObjects:@"app_category -提示1 竖屏.jpg",@"app_category -提示2 竖屏.jpg",  nil];
    for (int i=0; i<[array count]+1; i++) {
        if (i == 2) {
            break;
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [imalist addObject:imageView];
        [byScrollView addSubview:imageView];
        if (i==[array count]-2) {
            button = [[UIButton alloc ]initWithFrame:CGRectZero];
//            [button setBackgroundColor:[UIColor redColor]];
//            button.autoresizingMask =
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            //[byScrollView addSubview:button];
        }
    }
    page = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 2*self.view.frame.size.height/3, 100, 50)];
    page.numberOfPages = [array count];
    page.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:page];

}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    int index = scrollView.contentOffset.x/scrollView.frame.size.width;
    if (index == 2) {
        [self buttonAction:nil];
    }
}
-(void)buttonAction:(id)sender
{
    byScrollView.hidden = YES;
    page.hidden = YES;
    [button removeFromSuperview];
    [page removeFromSuperview];
    [byScrollView removeFromSuperview];
}

-(void)makeView
{
    navView = [[UIView alloc] initWithFrame:CGRectZero];
    navView.frame = ccr(0, 0, self.view.frame.size.width, Nav_HEIGHT);
    navView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    navView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    navView.backgroundColor = [UIColor colorWithRed:4/255.0 green:126/255.0 blue:163/255.0 alpha:1.0];
    [self.view addSubview:navView];
    
    UIButton *logoBT = [[UIButton alloc] initWithFrame:ccr(self.view.frame.size.width-73, (Nav_HEIGHT-63)/2, 63, 63)];
    logoBT.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    [logoBT setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    logoBT.hidden = YES;
    [navView addSubview:logoBT];
    label = [[UILabel alloc] initWithFrame:ccr(logoBT.frame.size.width+8, (Nav_HEIGHT-53)/2, 200, 53)];
    label.font = [UIFont systemFontOfSize:30];
    label.textColor = [UIColor whiteColor];
    
    [navView addSubview:label];
    
    
    englishBut = [[UIButton alloc] initWithFrame:ccr(self.view.frame.size.width-210, Nav_HEIGHT/3+25, 130, Nav_HEIGHT/3)];
   // englishBut.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    //englishBut.titleLabel.font = [UIFont systemFontOfSize:30];
    [englishBut setTitle:@"English" forState:UIControlStateNormal];
    [navView addSubview:englishBut];
    
    chineseBut = [[UIButton alloc] initWithFrame:ccr(self.view.frame.size.width-180-20-englishBut.frame.size.width, Nav_HEIGHT/3+25, 100, Nav_HEIGHT/3)];
   // chineseBut.titleLabel.font = [UIFont systemFontOfSize:30];
    [chineseBut setTitle:@"中文" forState:UIControlStateNormal];
    [navView addSubview:chineseBut];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"languageTag"]isEqualToString:@"english"]) {
//        [chineseBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [englishBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [englishBut.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
        [chineseBut.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
        label.text = @"Bay Assistant";
    }
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"languageTag"]isEqualToString:@"chinese"])
    {
//        [chineseBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [englishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chineseBut.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
        [englishBut.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
        label.text = @"拜助理";
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"chinese" forKey:@"languageTag"];
        [[NSUserDefaults standardUserDefaults]synchronize];
//        [chineseBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [englishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chineseBut.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
        [englishBut.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
        label.text = @"拜助理";

    }
    
   
    UIView *view1 = [[UIView alloc] initWithFrame:ccr(englishBut.frame.origin.x-16, 2*Nav_HEIGHT/3-10, 4, Nav_HEIGHT/3)];
    view1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin ;
    [navView addSubview:view1];
    view1.backgroundColor = [UIColor whiteColor];
    
    chineseBut.tag = 1;
    englishBut.tag = 2;
    
    englishBut.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin ;
    chineseBut.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    [englishBut addTarget:self action:@selector(choseTheLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [chineseBut addTarget:self action:@selector(choseTheLanguage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    contentHenView = [[UIView alloc] initWithFrame:ccr(0, Nav_HEIGHT, 1024, 768-Nav_HEIGHT)];
    [self.view addSubview:contentHenView];
    contentHenView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_x.png"]];
    //btn_green.png
    UIImage *image1 = [UIImage imageNamed:@"Bayer"];//bcs
    UIImage *image2 = [UIImage imageNamed:@"Bayer-"];//bhcs需要通知
    UIImage *image6 = [UIImage imageNamed:@"Bayer--"];//bhc

    CGFloat k = image1.size.width/image1.size.height;
    UIButton *muserHenBut1 = [[UIButton alloc] initWithFrame:ccr(50, 80,k*200, 200)];
    CGFloat m = image2.size.height/image2.size.width;
    CGFloat width = 300;
    muserHenbut2 = [[UIButton alloc] initWithFrame:ccr(1024-width-50, 768-width*m-180, width, width*m)];
    [muserHenBut1 setBackgroundImage:image6 forState:UIControlStateNormal];//bhcs
    [muserHenbut2 setBackgroundImage:image1 forState:UIControlStateNormal];//bcs

    [muserHenbut2 addTarget:self action:@selector(muserTwoAction:) forControlEvents:UIControlEventTouchUpInside];
    [muserHenBut1 addTarget:self action:@selector(muserOneAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentHenView addSubview:muserHenBut1];
    [contentHenView addSubview:muserHenbut2];

     muserHenbut3 = [[UIButton alloc] initWithFrame:ccr(50, 768-width*m-180,k*200, 200)];
    [muserHenbut3 setBackgroundImage:image6 forState:UIControlStateNormal];//bhc
    [muserHenbut3 addTarget:self action:@selector(muserOneAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentHenView addSubview:muserHenbut3];
    muserHenbut3.hidden = YES;
    
    muserHenbut5 = [[UIButton alloc] initWithFrame:ccr(1024/2-(width)/2, 80,k*200, 200)];
    [muserHenbut5 setBackgroundImage:image6 forState:UIControlStateNormal];//bcss
    muserHenbut5.hidden = YES;
    [muserHenbut5 addTarget:self action:@selector(muserOneAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentHenView addSubview:muserHenbut5];
    
    
    muserHenBut1.tag = 1;
    muserHenbut2.tag = 2;
    muserHenbut3.tag = 3;
    muserHenbut5.tag = 5;
    
    
    contentShuView = [[UIView alloc] initWithFrame:ccr(0, Nav_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-Nav_HEIGHT)];
    [self.view addSubview:contentShuView];
    contentShuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_y.png"]];
    UIImage *image3 = [UIImage imageNamed:@"btn_green.png"];//bcs
    CGFloat j = image3.size.width/image3.size.height;
    UIButton *muserHenBut3 = [[UIButton alloc] initWithFrame:ccr(20, Nav_HEIGHT+20,j*200, 200)];
    UIImage *image4 = [UIImage imageNamed:@"btn_blue.png"];//bhc
    CGFloat l = image4.size.width/image4.size.height;
    CGFloat h = 200;
    UIButton *muserHenbut4 = [[UIButton alloc] initWithFrame:ccr(SCREEN_WIDTH-h*l-20, SCREEN_HEIGHT-h-100-Nav_HEIGHT, h*l, h )];
   // muserHenbut4.frame = ccr(0, 500,200, 300 );
    
    [muserHenBut3 setBackgroundImage:image4 forState:UIControlStateNormal];
    [muserHenbut4 setBackgroundImage:image3 forState:UIControlStateNormal];
    [muserHenbut4 addTarget:self action:@selector(muserTwoAction:) forControlEvents:UIControlEventTouchUpInside];//bcs
    [muserHenBut3 addTarget:self action:@selector(muserOneAction:) forControlEvents:UIControlEventTouchUpInside];//bhc

    [contentShuView addSubview:muserHenBut3];
    [contentShuView addSubview:muserHenbut4];
    
    contentShuView.hidden = YES;
    contentHenView.hidden = YES;

}

-(void)choseTheLanguage:(id)sender
{
    UIButton *but = sender;
    if (but.tag==1) {
        [[NSUserDefaults standardUserDefaults]setObject:@"chinese" forKey:@"languageTag"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [chineseBut.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
        [englishBut.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
        label.text = @"拜助理";
//        [chineseBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [englishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        NSLog(@"chinese");
    }
    else{
        [[NSUserDefaults standardUserDefaults]setObject:@"english" forKey:@"languageTag"];
         [[NSUserDefaults standardUserDefaults]synchronize];
       // [chineseBut setTitle:@"chinese" forState:UIControlStateNormal];
        [englishBut.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
        [chineseBut.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
        label.text = @"Bay Assistant";
//        [chineseBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [englishBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        NSLog(@"english");
    }
    
}

-(void)muserOneAction:(UIButton *)sender
{
//    if ([UItool isConnectionAvailable]==YES) {
//
    
    if (sender.tag == 1) {
        
        UIImage *image2 = [UIImage imageNamed:@"南区"];//bhcs需要通知
        UIImage *image6 = [UIImage imageNamed:@"西区"];//bhc
        UIImage *image7 = [UIImage imageNamed:@"北区"];//bhcn需要通知
        
        muserHenbut3.hidden = NO;
        muserHenbut5.hidden = NO;
        sender.hidden = YES;
        
        [muserHenbut3 setBackgroundImage:image6 forState:UIControlStateNormal];//bhcW
        [muserHenbut5 setBackgroundImage:image2 forState:UIControlStateNormal];//bhcS
        [muserHenbut2 setBackgroundImage:image7 forState:UIControlStateNormal];//bhcN
       

    } else if (sender.tag == 5) {//南区有通知
        
            //注册通知模式
            if([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
        
            {
        
                [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings
        
                                                                                    settingsForTypes:(UIUserNotificationTypeSound|UIUserNotificationTypeAlert|UIUserNotificationTypeBadge)
        
                                                                                    categories:nil]];
        
                [[UIApplication sharedApplication]registerForRemoteNotifications];
        
            }else{
        
                //这里还是原来的代码
        
                //注册启用push
        
                [[UIApplication sharedApplication]registerForRemoteNotificationTypes:
                 
                 (UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
                
            }
        
            [self choseRootViewController];
        [ [NSUserDefaults standardUserDefaults] setObject:@"BHC" forKey:@"userGroup"];
        [ [NSUserDefaults standardUserDefaults] synchronize];

        
    }else{
        
            [self choseRootViewController];
        [ [NSUserDefaults standardUserDefaults] setObject:@"BHC" forKey:@"userGroup"];
        [ [NSUserDefaults standardUserDefaults] synchronize];

    }
    
    
    
    
    
    
    
    
    
//    }
//    else{
//        [self alert];
//    }
    
    

    
}
-(void)muserTwoAction:(id)sender
{
//    if ([UItool isConnectionAvailable]) {
        [ [NSUserDefaults standardUserDefaults] setObject:@"BCS" forKey:@"userGroup"];
        [ [NSUserDefaults standardUserDefaults] synchronize];
        [self choseRootViewController];
//    }
//    else{
//        [self alert];
//    }
    
}

-(void)alert
{
    NSString *str;NSString *std;NSString*stw;
    if ([UItool isChinese]==YES) {
        str = @"提示";
        std = @"加载失败，请确保网络处于连接状态且VPN已打开";
        stw =@"确定";
    }
    else{
        str = @"Alert";
        std = @"Loading failed, please ensure the internet and VPN are connected.";
        stw = @"YES";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:std delegate:self cancelButtonTitle:stw otherButtonTitles:nil];
    [alert show];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            [self shuOfHomeView];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            [self shuOfHomeView];
            break;
        case UIInterfaceOrientationLandscapeLeft:
            [self henOfHomeView];
            break;
        case UIInterfaceOrientationLandscapeRight:
            [self henOfHomeView];
            break;
            
        default:
            break;
    }
}



-(void)choseRootViewController
{
    //注册百度推送 回调appdelegate onMethod:
    [BPush bindChannel];
    
    BYViewController *byView = [[BYViewController alloc] init];
    UINavigationController *byNav = [[UINavigationController alloc]initWithRootViewController:byView];
    byNav.navigationBar.hidden = YES;
    
    MessageViewController *view = [[MessageViewController alloc]init];
    UINavigationController *byNavMessage = [[UINavigationController alloc] initWithRootViewController:view];
    byNavMessage.navigationBar.hidden = YES;
    
    FAQViewController *faqView = [[FAQViewController alloc]init];
    UINavigationController *byNavFAQ = [[UINavigationController alloc] initWithRootViewController:faqView];
    byNavFAQ.navigationBar.hidden = YES;
    
    RefreshViewController *refreshView = [[RefreshViewController alloc] init];
    UINavigationController *refreshNav = [[UINavigationController alloc] initWithRootViewController:refreshView];
    refreshNav.navigationBar.hidden = YES;
    
    SettingViewController *setView = [[SettingViewController alloc]init];
    UINavigationController *setNav = [[UINavigationController alloc]initWithRootViewController:setView];
    setNav.navigationBar.hidden = YES;
    
    LastViewController *lastView = [[LastViewController alloc]init];
    UINavigationController *laseNav = [[UINavigationController alloc]initWithRootViewController:lastView];
    laseNav.navigationBar.hidden = YES;
    BYTabBarController *byTab = [[BYTabBarController alloc]init];
    [byTab setViewControllers:@[byNav,byNavMessage,byNavFAQ,refreshNav,setNav,laseNav]];
    
    
    AppDelegate * app =  [UIApplication sharedApplication].delegate;
    app.window.rootViewController =  byTab;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    page.currentPage = scrollView.contentOffset.x/self.view.frame.size.width;
    page.currentPageIndicatorTintColor = [UIColor redColor];
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
