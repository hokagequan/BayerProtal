//
//  AppDelegate.h
//  BayerProtal
//
//  Created by admin on 14-9-24.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong ,nonatomic) NSUserDefaults *appDefaults;


@property (nonatomic,strong) Reachability *hostReachability;

@end

/*
*  刷新所有数据通知：refreshAll
   刷新消息通知名称：refershMessage
   切换语言的通知名字：changeLanguage
   删除本地应用时候及时刷新：refershAppOrOpen
 
 NSUserDefaults:
     消息声音key：isVoiceOn   === on off
     数据同步key：DataSynchronization == on off
     控制语言key： languageTag  chinese english
     控制自动刷新时间key: outTime;
    
*/
