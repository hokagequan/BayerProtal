//
//  ByServerURL.m
//  BayerProtal
//
//  Created by admin on 14-10-13.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "ByServerURL.h"
#import "AFNetworking.h"
@implementation ByServerURL

static NSString *g_LoginURL = @"mobile/muserlogin.action";
static NSString *g_AllAppURL = @"mobile/mAppAppList.action";
static NSString *g_InformationURL = @"mobile/mMessagerlist.action";
static NSString *g_FAQURL = @"mobile/mFaqlist.action";
static NSString *g_MuserGroup = @"mobile/muserGroupList.action";


+(NSString *)getLoginUrl
{
    return [NSString stringWithFormat:@"%@%@", SERVER_URL, g_LoginURL];
}


/*
 * need key : userGroup
 */

+(NSString *)getAllAppUrl{
    return [NSString stringWithFormat:@"%@%@", SERVER_URL, g_AllAppURL];
}

+(NSString *)getInformationUrl
{
    return [NSString stringWithFormat:@"%@%@", SERVER_URL, g_InformationURL];
}

+(NSString *)getFAQ
{
     return [NSString stringWithFormat:@"%@%@", SERVER_URL, g_FAQURL];
}

+(NSString *)getMuserGroup
{
    return [NSString stringWithFormat:@"%@%@", SERVER_URL, g_MuserGroup];
}
+ (void)sendMessageRecord :(NSString *)message{
   
    NSString *deviceStr = [USERDEFSULT objectForKey:DEVICEID];
    
    if (deviceStr) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:[NSString stringWithFormat:@"http://%@/mobile/muser!OpenMessage.action?DeviceId=%@&MessageContent=%@",LocalHost,deviceStr,message] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
        }];
    }

}
@end
