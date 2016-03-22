//
//  AppDelegate.m
//  BayerProtal
//
//  Created by admin on 14-9-24.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import <CoreFoundation/CoreFoundation.h>

#import "AppDelegate.h"
#import "BYViewController.h"
#import "BYTabBarController.h"
#import "MessageViewController.h"
#import "FAQViewController.h"
#import "RefreshViewController.h"
#import "SettingViewController.h"
#import "LastViewController.h"
#import "BYTabBarController.h"

#import "AFHTTPRequestOperationManager.h"


#import "BYHomeViewController.h"

#import "SqlProperty.h"

#import <objc/message.h>

#import "LocalSqlManger.h"

#import "RequestClient.h"

#import "BPush.h"
#import "IpaRequestManger.h"

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#import "CustomAlert.h"
#import "RequestClient.h"

#import "BayerProtal-Swift.h"

//#import "AppDetailViewController.h"

@implementation AppDelegate
{
    BYTabBarController *byTab;
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"BayerProtal.sqlite"];
    [self.window makeKeyAndVisible];
    
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    if (![[ [NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]isEqual:@"BCS"]&&![[ [NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]isEqual:@"BHC"]) {
        BYHomeViewController *homeView = [[BYHomeViewController alloc] init];
        self.window.rootViewController = homeView;
    }
    
    else if ([[ [NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]isEqual:@"BCS"]||[[ [NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]isEqual:@"BHC"])
    {
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
        byTab = [[BYTabBarController alloc]init];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageNotifation:)  name:@"messgaeNotifation" object:nil];
        [byTab setViewControllers:@[byNav,byNavMessage,byNavFAQ,refreshNav,setNav,laseNav]];
        self.window.rootViewController = byTab;
        
    }
    
    
    [self registBaiduPush:application Options:launchOptions];
       // Override point for customization after application launch.
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];

    //[self registReachability];
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if ([[ [NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]isEqual:@"BHC"]) {
        if ([[remoteNotification objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
            NSString*string =[[remoteNotification objectForKey:@"aps"] objectForKey:@"alert"];
            
            NSArray *StringArray = [string componentsSeparatedByString:@"/"]; //从字符A中分隔成2个元素的数组
            
            NSString *messageID = [remoteNotification objectForKey:@"send_message_id"];
            NSManagedObjectContext *context = [[CoreDataManager defalutManager] childContext];
            [[MessageManager defaultManager] readMessage:context messageId:messageID completion:nil];
            if (StringArray.count==2) {
                CustomAlert *alert = [[CustomAlert alloc] initWithTitle:StringArray[0] contentText:StringArray[1]];
                alert.tag = 9;
                [alert show];
            }else{
                
                CustomAlert *alert = [[CustomAlert alloc] initWithTitle:nil contentText:StringArray[0]];
                alert.tag = 9;
                [alert show];
            }
            if (![user objectForKey:@"messageArray"]) {
                NSMutableArray *messageArray = [NSMutableArray array];
                [user setObject:messageArray forKey:@"messageArray"];
                [user synchronize];
                
            }
            
            // [ByServerURL sendMessageRecord:string];//发送已读消息记录
            
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:[user objectForKey:@"messageArray"]];
            [array addObject:string];
            [user setObject:array forKey:@"messageArray"];
            [user synchronize];
            
        }

    }
    
    
    //是否启动app了
    if (application.applicationState==UIApplicationStateInactive) {
        NSDictionary * localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (localNotif) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"nstificationGo" object:nil userInfo:nil];

        }
    }
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    
//    CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"解放几点刷卡是否刷卡?" contentText:@"收到了高考历史官方考数据的管理科室的解放感觉是挂靠价格收到了高收到了高考历史官方考数据的管理科室的解放感觉是格收到了高考历史官方考数据的管理科室的解放感觉是挂靠价格收到了高收到了高考历史官方考数据的管理科室的解放感觉是格"];
//    alert.tag = 9;
//    [alert show];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
        if ([[[UIApplication sharedApplication] currentUserNotificationSettings] types] == UIRemoteNotificationTypeNone) {
        }
    } else {
        // Apple Push Notification Service
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] == UIRemoteNotificationTypeNone) {
        }
    }
    
    return YES;
}


-(void)refershMessageWithTime
{
    NSLog(@"刷新了哦");
    NSMutableDictionary * parms = [[NSMutableDictionary alloc] init];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"];
    //[parms setObject:str forKey:@"userGroup"];
    [parms setObject:str forKey:@"userGroup"];
    [parms setObject:[LocalSqlManger selectMessageMaxId] forKey:@"messageId"];
//    [UIAlertView showMessage:String(@"1 max id :%@",[LocalSqlManger selectMessageMaxId])];
    //获取消息列表
    [RequestClient POST:[ByServerURL getInformationUrl] parameters:parms success:^(NSDictionary *dict) {
       // NSLog(@"message===%@",dict);
        NSArray *informationArr = [[dict objectForKey:@"body"] objectForKey:@"messageList"];
        [LocalSqlManger saveTheInformationToTable:informationArr];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refershMessage" object:nil];
        
    } failure:^(NSError *error) {
       // NSLog(@"messageerror:;%@",error);
        
        
    }];
}

-(void)messageNotifation:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"sa" message:@"sas" delegate:self cancelButtonTitle:@"sf" otherButtonTitles: nil];
    [alert show];
}

- (void)registReachability{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
// NSString *remoteHostName = @"www.baidu.com";
// self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
// [self.hostReachability startNotifier];
    
    
    struct sockaddr_in address;
    memset(&address, 0, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
    address.sin_port = ntohs([SERVER_PORT intValue]);
    const char* p = [SERVER_IP cStringUsingEncoding:NSASCIIStringEncoding];
    address.sin_addr.s_addr = htons(inet_addr(p));
    self.hostReachability = [Reachability reachabilityWithAddress:&address];
    [self.hostReachability startNotifier];
}


- (void) reachabilityChanged:(NSNotification *)note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    if ([curReach currentReachabilityStatus] == ReachableViaWiFi ||[curReach currentReachabilityStatus] == ReachableViaWWAN) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:Reachability_WIFI] isEqualToString:@"18"]) {
            if ([UItool isConnectionAvailable]) {
                __block NSString *std;
                __block int k;
                [IpaRequestManger refreshContents:^(int n,NSString *str) {
                    NSLog(@"====%d",n);
                    if (![str isEqualToString:@"no"]) {
                        std=str;
                    }
                    if (n!=0) {
                        k=n;
                    }
                    if (k%3==0) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"refershMessage" object:self];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAll" object:self];
                    }
                }];
            }
            
            [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:Reachability_WIFI];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
    }
    else if ([curReach currentReachabilityStatus] == NotReachable){
        [[NSUserDefaults standardUserDefaults]setValue:@"18" forKey:Reachability_WIFI];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}


- (void)registBaiduPush:(UIApplication *)application Options:(NSDictionary *)launchOptions{
    
//    [BPush setupChannel:launchOptions];
//    [BPush setDelegate:self];
    
    //    [application setApplicationIconBadgeNumber:0];
        // Override point for customization after application launch.
    
    
    
   
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
}

#if SUPPORT_IOS8
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"test:%@",deviceToken);
    
    NSString *deviceStr = [deviceToken description];
    deviceStr = [deviceStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    deviceStr = [deviceStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceStr = [deviceStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSLog(@"deviceStr = %@",deviceStr);
    
    //判断是否已经提交过deviceID
//    if (![USERDEFSULT objectForKey:DEVICEID]) {
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"userGroup"] isEqualToString:@"BHC"]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

        manager.requestSerializer.timeoutInterval = 30;
        // 设置返回格式
        [manager GET:[NSString stringWithFormat:@"http://%@/mobile/muserlogin.action?deviceID=%@",LocalHost,deviceStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"http://%@/mobile/muserlogin.action?deviceID=%@",LocalHost,deviceStr] message:@"deviceID" delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil, nil];
//            [alert show];
            
            [USERDEFSULT setObject:deviceStr forKey:DEVICEID];
            [USERDEFSULT synchronize];
                        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%d",error.code] message:@"deviceID" delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil, nil];
//            [alert show];
        }];
 
   }
//
//    [BPush registerDeviceToken: deviceToken];
//    [BPush bindChannel];
    
    //    self.viewController.textView.text = [self.viewController.textView.text stringByAppendingFormat: @"Register device token: %@\n openudid: %@", deviceToken, [OpenUDID value]];
}

//百度推送回调
- (void) onMethod:(NSString*)method response:(NSDictionary*)data {
    
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    if ([BPushRequestMethod_Bind isEqualToString:method]) {
        //        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:userid message:channelid delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        //[alert show];
        //NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
            NSString *group = [ [NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"];
            if (group.length  && userid.length) {
                //获取到id提交
                [IpaRequestManger updataMybaiduUserId:userid baiduChannelId:channelid userGroup:group success:^(NSDictionary *dict) {
                    
                } failure:^(NSError *error) {
                    
                }];
            }
        }
    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
            //            self.viewController.appidText.text = nil;
            //            self.viewController.useridText.text = nil;
            //            self.viewController.channelidText.text = nil;
        }
    }
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
//    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",error] message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    [alert show];

    NSLog(@"注册失败，无法获取设备ID, 具体错误: %@", error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
   // NSString *alertMessage = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
   // [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    if (application.applicationState == UIApplicationStateActive) {
//        [IpaRequestManger insertMessage];
        [[MessageManager defaultManager] synthronizeMessages:nil];
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isVoiceOn"]isEqualToString:@"on"]) {
            AudioServicesPlaySystemSound(1152);
        }
        NSString *str;NSString *std;NSString *stm;
        if ([UItool isChinese]==YES) {
            str = @"通知";
            std = @"确定";
            stm = @"你有新的消息";
        }
        else{
            str = @"Notification";
            std = @"OK";
            stm = @"You have a new message";
        }
    }
    
    if ([[ [NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]isEqual:@"BHC"]) {

    
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
        
        NSString*string =[[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        
        NSArray *StringArray = [string componentsSeparatedByString:@"/"]; //从字符A中分隔成2个元素的数组
        if (StringArray.count==2) {
            CustomAlert *alert = [[CustomAlert alloc] initWithTitle:StringArray[0] contentText:StringArray[1]];
            alert.tag = 9;
            [alert show];
            
        }else{
        
            CustomAlert *alert = [[CustomAlert alloc] initWithTitle:nil contentText:StringArray[0]];
            alert.tag = 9;
            [alert show];
        }
//        [ByServerURL sendMessageRecord:string];//发送已读消息记录
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

        if (![user objectForKey:@"messageArray"]) {
            
            NSMutableArray *messageArray = [NSMutableArray array];
            [user setObject:messageArray forKey:@"messageArray"];
            [user synchronize];
            
        }
        NSMutableArray *array = [NSMutableArray arrayWithArray:[user objectForKey:@"messageArray"]];
        [array addObject:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
        [user setObject:array forKey:@"messageArray"];
        [user synchronize];
        
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"refershMessage" object:self userInfo:nil];
    //[BPush handleNotification:userInfo];
    
    if (application.applicationState != UIApplicationStateActive) {
        
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nstificationGo" object:nil userInfo:nil];
        
    }
 }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==9) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"nstificationGo" object:nil userInfo:nil];
    }
    
}
//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    return  UIInterfaceOrientationMaskPortraitUpsideDown;
//    //UIInterfaceOrientationMaskLandscapeLeft ;
//}


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag==9) {
//        
//    }
//    
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    
    NSArray *arr = [LocalSqlManger selectClass:@"BYinformation" ThroughTheKey:@"isRead" and:@"0"];
    int i =0;
    for (BYinformation *inforMation in arr) {
        if ([inforMation.userGroup isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]]) {
            i++;
        }
    }
    
   [UIApplication sharedApplication].applicationIconBadgeNumber=i;

    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"outTime"] isEqualToString:@""]) {
        [UItool saveCurrentTime];
    }
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //BOOL heoolo = [UItool calculateTime:[[NSUserDefaults standardUserDefaults]objectForKey:@"outTime"]];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refershAppOrOpen" object:nil];
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"outTime"];
    if (!str.length) {
        [UItool saveCurrentTime];
    }
    else{
    if ([UItool calculateTime:str]) {
        NSLog(@"时差刷新");
        [UItool saveCurrentTime];
        [UItool refershMessageWithTime];
    }
    }

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[MessageManager defaultManager] synthronizeMessages:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refershMessage" object:nil];
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
