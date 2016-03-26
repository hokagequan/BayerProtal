
//  BYTabBarController.m
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "BYTabBarController.h"
#import "BYtabButton.h"
#import "tabButton.h"
#import "UIButton+BYbuttonTitle.h"
#import "IpaRequestManger.h"
#import "DXAlertView.h"
#import "TabBarButton.h"

#import "BayerProtal-Swift.h"

@interface BYTabBarController ()<UIGestureRecognizerDelegate>
{
     TabBarButton * appButton;
     TabBarButton *messageButton;
     TabBarButton *faqButton;
     TabBarButton *refreshButton;
     TabBarButton *setButton;
     UIButton *lastButton;
     TabBarButton *eventButton;
     NSMutableArray *buttonList;
    NSTimer *myTimer;
    NSArray *titleArray;
    
}

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BYTabBarController
@synthesize myTabView;
@synthesize selectBtn;
@synthesize hiddenBT;
@synthesize lineView;

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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationAction:) name:@"nstificationGo" object:nil];

   //定时刷新
   [NSTimer scheduledTimerWithTimeInterval:3600 target:self selector:@selector(TabrefershMessageWithTime) userInfo:nil repeats:YES];

    self.open = YES;
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabRefershMessage:) name:@"refershMessage" object:nil];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabRefershMessage:) name:@"refreshAll" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLanguageOfTabbar:) name:@"changeLanguage" object:nil];
    
    [self.tabBar removeFromSuperview];
    // CGRect rect = ccr(0, Nav_HEIGHT+10, TabBar_WIDTH, SCREEN_WIDTH-Nav_HEIGHT);
    myTabView = [[UIView alloc]initWithFrame:ccr(0, 0, TabBar_WIDTH, SCREEN_HEIGHT)];
    myTabView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    lineView = [[UIView alloc]initWithFrame:CGRectZero];
    //myTabView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"left_menu_x.png"]];//[UIColor colorWithWhite: alpha:0];
   // lineView.backgroundColor = [UIColor blackColor];
   // [myTabView addSubview:lineView];
    myTabView.backgroundColor = [UIColor colorWithRed:15/255.0 green:105/255.0 blue:155/255.0 alpha:1.0];
    [self.view addSubview:myTabView];
    [self makeButton];
    [self loadDataTab];
    [self menuAnimation];
    
    //隐藏功能
    
//    hiddenBT = [[UIButton alloc]initWithFrame:CGRectZero];
//    //[myTabView addSubview:hiddenBT];
//    hiddenBT.titleLabel.numberOfLines = 0;
//    [hiddenBT setBackgroundImage:[UIImage imageNamed:@"side_btn.png" ]forState:UIControlStateNormal];
//   
//    [hiddenBT addTarget:self action:@selector(hiddenTab:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:hiddenBT];
//手势滑动
//    UISwipeGestureRecognizer *swipRecognizerLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTab:)];
//    swipRecognizerLeft.delegate = self;
//    [swipRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.view addGestureRecognizer:swipRecognizerLeft];
//    
//    UISwipeGestureRecognizer *swipRecognizerRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTab:)];
//    swipRecognizerRight.delegate = self;
//    [swipRecognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.view addGestureRecognizer:swipRecognizerRight];
        //横竖屏处理
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hellowordHen" object:nil];
                   [self henOfTabar];
        
    }else
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hellowordShu" object:nil];
                [self shuOfTabar];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScreenToHen:) name:@"changeScreenToHen" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScreenToShu:) name:@"changeScreenToShu" object:nil];
}

-(void)notificationAction:(id)sender
{
    if (self.selectedIndex == 1) {
        [UItool refershMessageWithTime];
    }
    
    self.selectBtn.selected = NO;
    messageButton.selected = YES;
    self.selectBtn = messageButton;
    self.selectedIndex = messageButton.tag;
}

-(void)TabrefershMessageWithTime
{
    NSLog(@"定时器刷新1");
    [UItool saveCurrentTime];
    NSMutableDictionary * parms = [[NSMutableDictionary alloc] init];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"];
    //[parms setObject:str forKey:@"userGroup"];
    [parms setObject:str forKey:@"userGroup"];
    [parms setObject:[LocalSqlManger selectMessageMaxId] forKey:@"messageId"];
//    [UIAlertView showMessage:String(@"2 max id :%@",[LocalSqlManger selectMessageMaxId])];

    //获取消息列表
    [RequestClient POST:[ByServerURL getInformationUrl] parameters:parms success:^(NSDictionary *dict) {
        NSArray *informationArr = [[dict objectForKey:@"body"] objectForKey:@"messageList"];
        [LocalSqlManger saveTheInformationToTable:informationArr];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refershMessage" object:nil];
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)loadDataTab
{
    [lastButton setImage:[UIImage imageNamed:@"menu6.png" ]forState:UIControlStateNormal];
    [lastButton setImage:[UIImage imageNamed:@"menu6.png"] forState:UIControlStateSelected];
    
    if ([UItool isChinese]==YES) {
//        [appButton setImage:[UIImage imageNamed:@"menu1_cn.png" ]forState:UIControlStateNormal];
//        [appButton setImage:[UIImage imageNamed:@"menu1_cn.png"] forState:UIControlStateSelected];
//        [messageButton setImage:[UIImage imageNamed:@"menu2_cn.png" ]forState:UIControlStateNormal];
//        [messageButton setImage:[UIImage imageNamed:@"menu2_cn.png"] forState:UIControlStateSelected];
//        [faqButton setImage:[UIImage imageNamed:@"menu3_cn.png" ]forState:UIControlStateNormal];
//        [faqButton setImage:[UIImage imageNamed:@"menu3_cn.png"] forState:UIControlStateSelected];
//        [refreshButton setImage:[UIImage imageNamed:@"menu4_cn.png" ]forState:UIControlStateNormal];
//        [refreshButton setImage:[UIImage imageNamed:@"menu4_cn.png"] forState:UIControlStateSelected];
//        [setButton setImage:[UIImage imageNamed:@"menu5_cn.png" ]forState:UIControlStateNormal];
//        [setButton setImage:[UIImage imageNamed:@"menu5_cn.png"] forState:UIControlStateSelected];
//        [eventButton setImage:[UIImage imageNamed:@"menu7_cn.png" ]forState:UIControlStateNormal];
//        [eventButton setImage:[UIImage imageNamed:@"menu7_cn.png"] forState:UIControlStateSelected];
        
        appButton.TitleLabel.text = @"应用";
        messageButton.TitleLabel.text = @"通知";
        faqButton.TitleLabel.text = @"常见问题";
        refreshButton.TitleLabel.text = @"同步";
        setButton.TitleLabel.text = @"设置";
        eventButton.TitleLabel.text = @"活动优化器";
        titleArray = @[@"应用",@"活动优化器",@"通知",@"常见问题",@"同步",@"设置"];
        for (int i = 0; i<6; i++) {
            UILabel *label = (UILabel *)[myTabView viewWithTag:i+100];
            label.text =titleArray[i];
        }


        
    }
    else
    {
//        [appButton setImage:[UIImage imageNamed:@"menu1.png" ]forState:UIControlStateNormal];
//        [appButton setImage:[UIImage imageNamed:@"menu1.png"] forState:UIControlStateSelected];
//        appButton.TitleLabel.text = @"Application";
//        [messageButton setImage:[UIImage imageNamed:@"menu2.png" ]forState:UIControlStateNormal];
//        [messageButton setImage:[UIImage imageNamed:@"menu2.png"] forState:UIControlStateSelected];
//        [faqButton setImage:[UIImage imageNamed:@"menu3.png" ]forState:UIControlStateNormal];
//        [faqButton setImage:[UIImage imageNamed:@"menu3.png"] forState:UIControlStateSelected];
//        [refreshButton setImage:[UIImage imageNamed:@"menu4.png" ]forState:UIControlStateNormal];
//        [refreshButton setImage:[UIImage imageNamed:@"menu4.png"] forState:UIControlStateSelected];
//        [setButton setImage:[UIImage imageNamed:@"menu5.png" ]forState:UIControlStateNormal];
//        [setButton setImage:[UIImage imageNamed:@"menu5.png"] forState:UIControlStateSelected];
//        [eventButton setImage:[UIImage imageNamed:@"menu7.png" ]forState:UIControlStateNormal];
//        [eventButton setImage:[UIImage imageNamed:@"menu7.png"] forState:UIControlStateSelected];
        
        appButton.TitleLabel.text = @"Application";
        messageButton.TitleLabel.text = @"Notice";
        faqButton.TitleLabel.text = @"FAQs";
        refreshButton.TitleLabel.text = @"Sync";
        setButton.TitleLabel.text = @"Setting";
        eventButton.TitleLabel.text = @"Event Optimizer";

        titleArray = @[@"Application",@"Event Optimizer",@"Notice",@"FAQs",@"Sync",@"Setting"];
        for (int i = 0; i<6; i++) {
            UILabel *label = (UILabel *)[myTabView viewWithTag:i+100];
            label.text =titleArray[i];
        }
        
    }
    
}

-(void)closeButton:(id)sender
{
//    self.open = NO;
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//    [UIView animateWithDuration:0.3 animations:^{
//        myTabView.frame = ccr(-112, Nav_HEIGHT, TabBar_WIDTH, myTabView.frame.size.height);
//        hiddenBT.frame = ccr(0, hiddenBT.frame.origin.y, 20, 160);
//    } completion:^(BOOL finished) {
//    }];

    
}

-(void)changeLanguageOfTabbar:(NSNotification *)noti
{
    [self loadDataTab];
}

-(void)tabRefershMessage:(NSNotification *)noti
{
//    NSArray *arr = [LocalSqlManger selectClass:@"BYinformation" ThroughTheKey:@"isRead" and:@"0"];
//    int i = 0;
//    for (BYinformation *inforMation in arr) {
//        if ([inforMation.userGroup isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]]) {
//            i++;
//        }
//    }
    
    // QCW fix
    [messageButton setBadgeValueView:[NSString stringWithFormat:@"%@", @([MessageManager defaultManager].unReadCount)]];
}


-(void)henOfTabar
{
    CGRect rect = ccr(0, Nav_HEIGHT, TabBar_WIDTH, SCREEN_WIDTH-Nav_HEIGHT);
    lineView.frame = ccr(rect.size.width-30, 3, 1, rect.size.height);
    if (self.open == YES) {
        hiddenBT.frame = ccr(TabBar_WIDTH, (SCREEN_WIDTH-Nav_HEIGHT)/2-80+Nav_HEIGHT, 20, 160);

    }
    else{
        hiddenBT.frame = ccr(0, (SCREEN_WIDTH-Nav_HEIGHT)/2-80+Nav_HEIGHT, 20, 160);
    }
    
    
   
    
    appButton.frame = ccr(-2, 1*myTabView.frame.size.height/9+20, TabBar_WIDTH, 69);
    messageButton.frame = ccr(-2, 3*myTabView.frame.size.height/9+20, TabBar_WIDTH, 69);
    faqButton.frame = ccr(-2, 4*myTabView.frame.size.height/9+20, TabBar_WIDTH, 69);
    refreshButton.frame = ccr(-2, 5*myTabView.frame.size.height/9+20, TabBar_WIDTH, 69);
    setButton.frame = ccr(-2, 6*myTabView.frame.size.height/9+20, TabBar_WIDTH, 69);
    lastButton.frame = ccr(-2, 7*myTabView.frame.size.height/9+20, TabBar_WIDTH, 69);
    eventButton.frame = ccr(-2, 2*myTabView.frame.size.height/9+20, TabBar_WIDTH, 69);
    
    [appButton setBackgroundImage:[UIImage imageNamed:@"left_menu_x_on.png"] forState:UIControlStateSelected];
    [messageButton setBackgroundImage:[UIImage imageNamed:@"left_menu_x_on.png"] forState:UIControlStateSelected];
    [faqButton setBackgroundImage:[UIImage imageNamed:@"left_menu_x_on.png"] forState:UIControlStateSelected];
    [setButton setBackgroundImage:[UIImage imageNamed:@"left_menu_x_on.png"] forState:UIControlStateSelected];
    [refreshButton setBackgroundImage:[UIImage imageNamed:@"left_menu_x_on.png"] forState:UIControlStateSelected];
    [lastButton setBackgroundImage:[UIImage imageNamed:@"left_menu_x_on.png"] forState:UIControlStateSelected];
    [eventButton setBackgroundImage:[UIImage imageNamed:@"left_menu_x_on.png"] forState:UIControlStateSelected];

    NSArray *arr = [LocalSqlManger selectClass:@"BYinformation" ThroughTheKey:@"isRead" and:@"0"];
    int i = 0;
    for (BYinformation *inforMation in arr) {
        if ([inforMation.userGroup isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]]) {
            i++;
        }
    }
    if ([arr count]!=0) {
        [messageButton setBadgeValueView:[NSString stringWithFormat:@"%d",i]];
    }
    
    

    
}
-(void)shuOfTabar
{
    CGRect rect = ccr(0, Nav_HEIGHT, TabBar_WIDTH, SCREEN_HEIGHT-Nav_HEIGHT);
     lineView.frame = ccr(rect.size.width-30, 3, 1, rect.size.height);
    if (self.open==YES) {
        hiddenBT.frame = ccr(TabBar_WIDTH, (SCREEN_HEIGHT-Nav_HEIGHT)/2-80+Nav_HEIGHT, 20, 160);
    }
    else{
        hiddenBT.frame = ccr(0, (SCREEN_HEIGHT-Nav_HEIGHT)/2-80+Nav_HEIGHT, 20, 160);
    }
    

     appButton.frame = ccr(0, 0, TabBar_WIDTH, myTabView.frame.size.height/6);
     messageButton.frame = ccr(0, 1*myTabView.frame.size.height/6, TabBar_WIDTH, myTabView.frame.size.height/6);
     faqButton.frame = ccr(0, 2*myTabView.frame.size.height/6, TabBar_WIDTH, myTabView.frame.size.height/6);
     refreshButton.frame = ccr(0, 3*myTabView.frame.size.height/6, TabBar_WIDTH, myTabView.frame.size.height/6);
     setButton.frame = ccr(0, 4*myTabView.frame.size.height/6, TabBar_WIDTH, myTabView.frame.size.height/6);
     lastButton.frame = ccr(0, 5*myTabView.frame.size.height/6, TabBar_WIDTH, myTabView.frame.size.height/6);
    
    [ appButton setBackgroundImage:[UIImage imageNamed:@"left_menu_y_on.png"] forState:UIControlStateSelected];
    [ messageButton setBackgroundImage:[UIImage imageNamed:@"left_menu_y_on.png"] forState:UIControlStateSelected];
    [ faqButton setBackgroundImage:[UIImage imageNamed:@"left_menu_y_on.png"] forState:UIControlStateSelected];
    [ refreshButton setBackgroundImage:[UIImage imageNamed:@"left_menu_y_on.png"] forState:UIControlStateSelected];
    [ lastButton setBackgroundImage:[UIImage imageNamed:@"left_menu_y_on.png"] forState:UIControlStateSelected];
    [ setButton setBackgroundImage:[UIImage imageNamed:@"left_menu_y_on.png"] forState:UIControlStateSelected];
    
    NSArray *arr = [LocalSqlManger selectClass:@"BYinformation" ThroughTheKey:@"isRead" and:@"0"];
    int i = 0;
    for (BYinformation *inforMation in arr) {
        if ([inforMation.userGroup isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]]) {
            i++;
        }
    }
    
    if ([arr count]!=0) {
        [messageButton setBadgeValueView:[NSString stringWithFormat:@"%d",i]];
    }
}



-(void)makeButton
{
    titleArray = @[@"应用",@"活动优化器",@"通知",@"常见问题",@"同步",@"设置"];

    buttonList = [NSMutableArray array];
    
    appButton = [[TabBarButton alloc] initWithFrame:CGRectZero];
    [appButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    appButton.tag = 0;
    appButton.selected = YES;
    appButton.CusImageView.image = [UIImage imageNamed:@"应用"];
     self.selectBtn = appButton;
     messageButton = [[TabBarButton alloc] initWithFrame:CGRectZero];;
    messageButton.tag = 1;
    [messageButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
      messageButton.CusImageView.image = [UIImage imageNamed:@"通知-"];
    
    faqButton = [[TabBarButton alloc] initWithFrame:CGRectZero];;
    faqButton.tag = 2;
    [faqButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    faqButton.CusImageView.image = [UIImage imageNamed:@"常见问题"];

    refreshButton = [[TabBarButton alloc] initWithFrame:CGRectZero];;
    refreshButton.tag = 3;
    [refreshButton addTarget:self action:@selector(clickRefreshBtn:) forControlEvents:UIControlEventTouchUpInside];
    refreshButton.CusImageView.image = [UIImage imageNamed:@"同步"];

    setButton = [[TabBarButton alloc] initWithFrame:CGRectZero];;
    setButton.tag = 4;
    [setButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    setButton.CusImageView.image = [UIImage imageNamed:@"设置"];

    lastButton = [[UIButton alloc] initWithFrame:CGRectZero];;
    lastButton.tag = 5;
    [lastButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    eventButton = [[TabBarButton alloc] initWithFrame:CGRectZero];;
    eventButton.tag = 6;
    [eventButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    eventButton.CusImageView.image = [UIImage imageNamed:@"活动优化器"];

    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:ccr(TabBar_WIDTH/2-35, 0*myTabView.frame.size.height/9+20, 60, 60)];
    iconImageView.image = [UIImage imageNamed:@"0拜助理-0_03"];

    [myTabView addSubview:iconImageView];
    [myTabView addSubview:appButton];
    [myTabView addSubview:messageButton];
    [myTabView addSubview:faqButton];
    [myTabView addSubview:refreshButton];
    [myTabView addSubview:setButton];
    [myTabView addSubview:lastButton];
    [myTabView addSubview:eventButton];
    for (int i = 0; i<6; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:ccr(-2, (i+1)*myTabView.frame.size.height/9+20+25, TabBar_WIDTH, 69)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text =titleArray[i];
        label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
        label.tag = i+100;
        label.font = [UIFont systemFontOfSize:15];
        label.adjustsFontSizeToFitWidth = YES;
        [myTabView addSubview:label];
    }
    
//    appButton.layer.borderWidth = 2;
//    appButton.layer.borderColor = [UIColor whiteColor].CGColor;
//    messageButton.layer.borderWidth = 2;
//    messageButton.layer.borderColor = [UIColor whiteColor].CGColor;
//    faqButton.layer.borderWidth = 2;
//    faqButton.layer.borderColor = [UIColor whiteColor].CGColor;
//    refreshButton.layer.borderWidth = 2;
//    refreshButton.layer.borderColor = [UIColor whiteColor].CGColor;
//    setButton.layer.borderWidth = 2;
//    setButton.layer.borderColor = [UIColor whiteColor].CGColor;
//    lastButton.layer.borderWidth = 2;
//    lastButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
}

-(void)changeScreenToHen:(NSNotification*)sender
{
    [self henOfTabar];

}

-(void)changeScreenToShu:(NSNotification*)sender
{
    [self shuOfTabar];

}

-(void)clickRefreshBtn:(id)sender
{
    NSString *str;//NSString*stw;NSString *stf;
    //NSString *std;
    //NSString*stm;
//    if ([UItool isChinese]==YES) {
//        str = @"提示";
//        std = @"点击刷新功能";
//        stw = @"确定";
//        stm = @"取消";
//        stf = @"无网络状态或者VPN未打开";
//    }
//    else{
//        str = @"Alert";
//        std = @"Click on the refresh function";
//        stw = @"YES";
//        stm = @"NO";
//        stf = @ "no state or VPN network is not open.";
//    }
    
    
    if ([UItool isConnectionAvailable]==YES) {
            [BYloadView loadState:YES];
            __block NSString *std;
            __block int k;
            __block int p = 0;
            [IpaRequestManger refreshContents:^(int n,NSString *str) {
                if (![str isEqualToString:@"no"]) {
                    std=str;
                }
                if (n!=0) {
                    k=n;
                }
                if ((k%3==0)||(k%3==0&&[std isEqualToString:@"noImage"])) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refershMessage" object:self];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAll" object:self];
                    [BYloadView loadState:NO];
                    
                }
//                else if (k%3==0)
//                {
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refershMessage" object:self];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAll" object:self];
//                    [BYloadView loadState:NO];
//                }
                
                else if ([std isEqualToString:@"failed"]&&p!=1){
                    [BYloadView loadState:NO];
                    NSString *stk;
                    NSString *stf;
                    if ([UItool isChinese]==YES) {
                        stf = @"加载失败，请确保网络处于连接状态且VPN已打开。";
                        str = @"提示";
                    }
                    else{
                        stf = @"Loading failed, please ensure the internet and VPN are connected.";
                        stk = @"Alert";
                    }
                    p=1;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:stk message:stf delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];

                }
                    NSLog(@"%@==",std);
                
            }];
        
        }
    else{
        NSString *stk;
        NSString *stf;
        if ([UItool isChinese]==YES) {
            stf = @"加载失败，请确保网络处于连接状态且VPN已打开。";
            str = @"提示";
        }
        else{
            stf = @"Loading failed, please ensure the internet and VPN are connected.";
            stk = @"Alert";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:stk message:stf delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];


    }
   
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==888&&buttonIndex==0) {
        if ([self.tabDelegate respondsToSelector:@selector(refreshCurrentViewController)]) {
            [self.tabDelegate refreshCurrentViewController];
        }
        if ([UItool isConnectionAvailable]) {
            [BYloadView loadState:YES];
            __block NSString *std;
            __block int k;
            __block int p;
            [IpaRequestManger refreshContents:^(int n,NSString *str) {
                NSLog(@"====%d",n);
                if (![str isEqualToString:@"no"]) {
                    std=str;
                }
                if (n!=0) {
                    k=n;
                }
//                if (k%3==0&&[std isEqualToString:@"yes"]) {
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refershMessage" object:self];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAll" object:self];
//                    [BYloadView loadState:NO];
//                    
//                }
                else if (k%3==0||(k%3==0&&[std isEqualToString:@"noImage"]))
                {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refershMessage" object:self];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAll" object:self];
                    [BYloadView loadState:NO];
                }
                
                else if ([std isEqualToString:@"failed"]&&p!=1){
                    [BYloadView loadState:NO];
                    NSString *str;
                    NSString *std;
                    if ([UItool isChinese]==YES) {
                        std = @"刷新失败,请确保VPN以打开";
                        str = @"提示";
                    }
                    else{
                        std = @"Refresh the failure,Please ensure VPN is connected";
                        str = @"prompt";
                    }
                    p=1;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:std delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];

                }
                    NSLog(@"====%d====std===%@",k,std);
                
                
            }];
        }


    }
}

- (void)menuAnimation{
//    if (self.open) {
//        if (self.timer) {
//            [NSObject cancelPreviousPerformRequestsWithTarget:self];
//            [self.timer invalidate];
//        }
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(closeButton:) userInfo:nil repeats:NO];
//    }
}

-(void)clickBtn:(UIButton *)sender
{
   // [self menuAnimation];
    
   
    
    if (sender.tag == 6) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"eventOptimizer://"]];
        return;
    }
    
    if (self.selectBtn == sender) {
        
        id obj = self.viewControllers[sender.tag];
        if ([obj isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)obj;
            if (nav.viewControllers.count>1) {
                [nav popToRootViewControllerAnimated:NO];
            }
        }
        return;
    }
    self.selectBtn.selected = NO;
    sender.selected = YES;
    self.selectBtn = sender;
    self.selectedIndex = sender.tag;
       
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([touch.view isKindOfClass:[UIScrollView class]])
//    {
//        return NO;
//    }
//    return YES;
//}
-(void)hiddenTab:(id)sender
{
   
    if (self.open==NO) {
        self.open=YES;
     
      [UIView animateWithDuration:0.3 animations:^{
            myTabView.frame = ccr(0, Nav_HEIGHT, TabBar_WIDTH, myTabView.frame.size.height);
            hiddenBT.frame = ccr(TabBar_WIDTH, hiddenBT.frame.origin.y, 20, 160);
            
        } completion:^(BOOL finished) {
            [self menuAnimation];
        }];
    }
    else{
        self.open = NO;
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [UIView animateWithDuration:0.3 animations:^{
            myTabView.frame = ccr(-112, Nav_HEIGHT, TabBar_WIDTH, myTabView.frame.size.height);
             hiddenBT.frame = ccr(0, hiddenBT.frame.origin.y, 20, 160);
        } completion:^(BOOL finished) {
        }];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)nsTimeAction
//{
//   myTimer= [NSTimer scheduledTimerWithTimeInterval:10.f target:self selector:@selector(refershMessageWithTime) userInfo:nil repeats:YES];
//    [myTimer setFireDate:[NSDate distantFuture]];
//
// [[NSRunLoop currentRunLoop]addTimer:myTimer forMode:NSDefaultRunLoopMode];
//
//}



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
