//
//  UItool.h
//  BayerProtal
//
//  Created by admin on 14-10-16.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"loadView.h"

@interface UItool : NSObject

@property (nonatomic,strong)loadView *ldView;

+ (UIImageView *)imageView;

+(CGSize)getTheLabelSize:(UILabel *)label ;


+(CGSize)getTheLabelSize:(UILabel *)label  andSize:(CGSize)size;

+(BOOL) isConnectionAvailable;
/*
  *  判断app是否安装在本地
 */
+(BOOL)APCheckIfAppInstalled2:(NSString *)urlSchemes;
/*
  *  图片变灰色
 */
+(UIImage*)getGrayImage:(UIImage*)sourceImage;

+(void)alertShow;

+(loadView *)starteLoadingView;

+(void)stopLoad;

/*
 *  计算时间差
 */
+(BOOL)calculateTime:(NSString*)dateString;

+(BOOL)isChinese;
/*
 *  判断自动同步
 */
+(BOOL)AutomaticSynchronization;
/*
 *  获取版本号
 */
+ (NSString *) getAppVersion;
/*
 *能否连接内网的服务器
 */
+(BOOL)canOpenIntranetServer;


/*
 *html去除标签
 */
+(NSString *)flattenHTML:(NSString *)originHtmlStr;

/*
 *定时刷新
 */
+(void)refershMessageWithTime;

/*
 *存取当前时间
 */
+(void)saveCurrentTime;

@end
