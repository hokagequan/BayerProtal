
//
//  JEUtits.h
//  BayerProtal
//
//  Created by 尹现伟 on 14/10/24.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppClickEntity.h"
@interface JEUtits : NSObject

+ (NSString *)pathWithFileName:(NSString *)name;

+ (NSString *)stringWithPath:(NSString *)path;

/*!
 打开应用
 
 @param url URL
 
 @return 是否成功
 */
+ (BOOL)openAppWithURL:(NSString *)url;
/*!
 查找最常用的前5的app
 
 @return BYapp array
 */
+ (NSArray *)get5CommonApps;

/*!
 打开一次app调用一次该方法，会在app的clickCount(NSString)上+1
 
 @param entity 点击的BYapp实体
 */
+ (void)addOneClickWithAppEntity:(BYapp *)entity;

+ (NSString *)sha1:(NSString *)str;
+ (NSString *)md5Hash:(NSString *)str;

@end


@interface  JEUtits (CoreData)

+ (void)save;

@end