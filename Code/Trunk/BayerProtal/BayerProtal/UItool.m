//
//  UItool.m
//  BayerProtal
//
//  Created by admin on 14-10-16.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "UItool.h"
#import "Reachability.h"
#import "DXAlertView.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

//#define IP_PORT             @"10.50.37.87"
//#define SERVER_PORT         @"8080"
//#define SERVER_DOMAIN       @"bayerportal"
//#define SERVER_URL          @"http://10.50.37.87:8080/bayerportal/"
@implementation UItool
static UIImageView *imageView_ = nil;
+ (UIImageView *)imageView{
    if (!imageView_) {
        imageView_ = [[UIImageView alloc]init];
    }
    return imageView_;
}
+(CGSize)getTheLabelSize:(UILabel *)label
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    NSDictionary *attributes = @{NSFontAttributeName:label.font};
    CGSize desLabelSize = [label.text boundingRectWithSize:CGSizeMake(2, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
   
    return desLabelSize;
}

+(CGSize)getTheLabelSize:(UILabel *)label  andSize:(CGSize)size
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    NSDictionary *attributes = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize desLabelSize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return desLabelSize;

}

+(BOOL) isConnectionAvailable
{
    //10.50.37.87:8080
    BOOL isExistenceNetwork = YES;
    struct sockaddr_in address;
    memset(&address, 0, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
    address.sin_port = ntohs([SERVER_PORT intValue]);
    const char* p = [SERVER_IP cStringUsingEncoding:NSASCIIStringEncoding];
    address.sin_addr.s_addr = htons(inet_addr(p));
    Reachability * reach = [Reachability reachabilityWithAddress:&address];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
            
            
            
    }
    
   
//        NSString *addressString = SERVER_URL;
//        if (!addressString) {
//            return NO;
//        }
//        
//        SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [addressString UTF8String]);
//        SCNetworkReachabilityFlags flags;
//        
//        BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
//        CFRelease(defaultRouteReachability);
//        
//        if (!didRetrieveFlags)
//        {
//            return NO;
//        }
//        
//        BOOL isReachable = flags & kSCNetworkFlagsReachable;
//        BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
//        return (isReachable && !needsConnection) ? YES : NO;
    
    
//    if (isExistenceNetwork==YES) {
//        Reachability *reach = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
//        switch ([reach currentReachabilityStatus]) {
//            case NotReachable:
//                isExistenceNetwork = NO;
//                //NSLog(@"notReachable");
//                break;
//            case ReachableViaWiFi:
//                isExistenceNetwork = YES;
//                //NSLog(@"WIFI");
//                break;
//            case ReachableViaWWAN:
//                isExistenceNetwork = YES;
//                //NSLog(@"3G");
//                break;
//        }
//    }
    
    return isExistenceNetwork;
}


+(BOOL) APCheckIfAppInstalled2:(NSString *)urlSchemes;
{
    NSRange range = [urlSchemes rangeOfString:@"http"];
    if (range.location==NSNotFound) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",urlSchemes]]])
        {
            NSLog(@" installed");
            return  YES;
        }
        else
        {
            return  NO;
        }
    }
    
    else if(range.location!=NSNotFound){
        return YES;
    }
    else{
        return NO;
    }
   
}


+(UIImage*)getGrayImage:(UIImage*)sourceImage;
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGBitmapByteOrderDefault);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
    return grayImage;
}

+(void)alertShow
{
//    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"不能打开"];
//    [alert show];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能打开" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];

    
}

+(loadView *)starteLoadingView
{
    loadView *loading = [[loadView alloc] init];
    [loading starte];
    return loading;
    
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

+(void)stopLoad
{
    [[UItool starteLoadingView] stop];
}


+(BOOL)calculateTime:(NSString*)dateString
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * d = [inputFormatter dateFromString:dateString];
    
    NSTimeInterval late = [d timeIntervalSince1970]*1;
    
//    NSString * timeString = nil;
//    CGFloat time;cha/60>60
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSTimeInterval cha = now - late;
    
    if (cha/60>60) {
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        [[NSUserDefaults standardUserDefaults] setObject:locationString forKey:@"outTime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        return YES;
        
    }
    else
    {
       return NO;
    }
    
//    if (cha/3600 < 1) {
//        
//        timeString = [NSString stringWithFormat:@"%f", cha/60];
//        
//        timeString = [timeString substringToIndex:timeString.length-7];
//        
//        int num= [timeString intValue];
//        
//        if (num <= 1) {
//            
//            timeString = [NSString stringWithFormat:@"刚刚..."];
//            
//        }else{
//            
//            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
//            
//        }
//        
//    }
    

    
//    if (cha/3600 > 1 && cha/86400 < 1) {
//        
//        timeString = [NSString stringWithFormat:@"%f", cha/3600];
//        
//        timeString = [timeString substringToIndex:timeString.length-7];
//        
//        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
//        
//    }
//    
//    timeString = [NSString stringWithFormat:@"%f", cha/86400];
//    
//    if (cha/86400 > 1)
//        
//    {
//        time = cha/86400;
//        timeString = [NSString stringWithFormat:@"%f", cha/86400];
//        
//        timeString = [timeString substringToIndex:timeString.length-7];
//        
//        int num = [timeString intValue];
//        
//        if (num < 2) {
//            
//            timeString = [NSString stringWithFormat:@"昨天"];
//            
//        }else if(num == 2){
//            
//            timeString = [NSString stringWithFormat:@"前天"];
//            
//        }else if (num > 2){
//            
//            timeString = [NSString stringWithFormat:@"%@天前", timeString];
//            
//        }
//        
//        NSLog(@"=========%@",timeString);
//        if (time>=15.0) {
//            return YES;
//        }
//        
//    }
    
    
    
}

+(BOOL)isChinese
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"languageTag"]isEqualToString:@"chinese"]) {
        return YES;
    }
    return NO;
}

+(BOOL)AutomaticSynchronization
{
    if ([UItool isConnectionAvailable]==YES) {
        NSString *time =[[NSUserDefaults standardUserDefaults]objectForKey:@"synchronizaTime"];
        return  [UItool calculateTime:time];
    }
    return NO;
}

+ (NSString *) getAppVersion
{
	NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
	NSString *version = [dic objectForKey:@"CFBundleShortVersionString"];
//    NSString *version = [dic objectForKey:@"CFBundleVersion"];
	
	return version;
}

+(BOOL)canOpenIntranetServer
{
    NSString *addressString = SERVER_URL;
   if (!addressString) {
       return NO;
    }

    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [addressString UTF8String]);
    SCNetworkReachabilityFlags flags;

    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);

    if (!didRetrieveFlags)
    {
        return NO;
    }

    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;

}

+(NSString *)flattenHTML:(NSString *)originHtmlStr{
    NSString *result = nil;
    NSRange arrowTagStartRange = [originHtmlStr rangeOfString:@"<"];
    if (arrowTagStartRange.location != NSNotFound) { //如果找到
        NSRange arrowTagEndRange = [originHtmlStr rangeOfString:@">"];
        //        NSLog(@"start-> %d   end-> %d", arrowTagStartRange.location, arrowTagEndRange.location);
        //        NSString *arrowSubString = [originHtmlStr substringWithRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location)];
        result = [originHtmlStr stringByReplacingCharactersInRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location + 1) withString:@""];
        
        //         NSRange range =[str rangeOfString:result];
        //        [originHtmlStr deleteCharactersInRange:range];
        // NSLog(@"Result--->%@", result);
        return [self flattenHTML:result];    //递归，过滤下一个标签
    }else{
        result = [originHtmlStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];  // 过滤&nbsp等标签
        result = [originHtmlStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //result = [originHtmlStr stringByReplacingOccurrencesOf  ........
    }
    return result;
}
static BOOL __isRefersh = NO;

+(void)refershMessageWithTime
{
//    if (__isRefersh) {
//        return;
//    }
//    __isRefersh = YES;
//    NSLog(@"刷新");
//    NSMutableDictionary * parms = [[NSMutableDictionary alloc] init];
//    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"];
//    //[parms setObject:str forKey:@"userGroup"];
//    [parms setObject:str forKey:@"userGroup"];
//    [parms setObject:[LocalSqlManger selectMessageMaxId] forKey:@"messageId"];
////    [UIAlertView showMessage:String(@"5 max id :%@",[LocalSqlManger selectMessageMaxId])];
//    //获取消息列表
//    [RequestClient POST:[ByServerURL getInformationUrl] parameters:parms success:^(NSDictionary *dict) {
//        NSArray *informationArr = [[dict objectForKey:@"body"] objectForKey:@"messageList"];
//        [LocalSqlManger saveTheInformationToTable:informationArr];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"refershMessage" object:nil];
//        __isRefersh = NO;
//    } failure:^(NSError *error) {
//        __isRefersh = NO;
//    }];
}


+(void)saveCurrentTime
{
   
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        [[NSUserDefaults standardUserDefaults] setObject:locationString forKey:@"outTime"];
        [[NSUserDefaults standardUserDefaults]synchronize];

    NSLog(@"tuichu -====%@",locationString);
    
}

@end
