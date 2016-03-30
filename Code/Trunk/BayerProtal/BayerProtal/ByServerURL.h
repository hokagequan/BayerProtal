//
//  ByServerURL.h
//  BayerProtal
//
//  Created by admin on 14-10-13.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <Foundation/Foundation.h>

//test   改这里的时候不要忘记修改网络判断里的ip和端口号。
//#define SERVER_IP           @"10.50.37.87"
//#define SERVER_PORT         @"8080"
//#define SERVER_DOMAIN       @"bayerportal"
//#define SERVER_URL          @"http://10.50.37.87:8080/bayerportal/"

//正式
#define SERVER_IP           @"10.50.37.197"
#define SERVER_PORT         @"8098"
#define SERVER_DOMAIN       @"BayAssistant"
//#define SERVER_URL          @"http://BSGSGPS0297.AP.BAYER.CNB:8080/BayAssistant/"
#define SERVER_URL          @"http://bsgsgps0361.ap.bayer.cnb/bayerportal/"
//BSGSGPS0297.AP.BAYER.CNB:8080 新服务器位置
//bsgsgps0361.ap.bayer.cnb/bayerportal 测试服务器位置
//bsgsgps0377.ap.bayer.cnb/bayerportal:8098 老的正式服务器位置

//#define SERVER_IP           @"192.168.96.110"
//#define SERVER_PORT         @"8280"
//#define SERVER_DOMAIN       @"BayerPortal"
//#define SERVER_URL          @"http://192.168.96.110:8280/BayerPortal/"


//liu nian
//#define SERVER_IP           @"192.168.96.102"
//#define SERVER_PORT         @"8080"
//#define SERVER_DOMAIN       @"BayerPortal"
//#define SERVER_URL          @"http://192.168.96.102:8080/BayerPortal/"

//wangkong
//#define SERVER_IP           @"192.168.96.120"
//#define SERVER_PORT         @"8080"
//#define SERVER_DOMAIN       @"BayerPortal"
//#define SERVER_URL          @"http://192.168.96.120:8080/BayerPortal/"

@interface ByServerURL : NSObject


+(NSString *)getLoginUrl;

+(NSString *)getAllAppUrl;

+(NSString *)getInformationUrl;

+(NSString *)getFAQ;
/*
 *  部门接口
 */
+(NSString *)getMuserGroup;

+ (void)sendMessageRecord :(NSString *)message;

@end
