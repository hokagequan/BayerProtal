//
//  LocalSqlManger.h
//  BayerProtal
//
//  Created by admin on 14-10-15.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <Foundation/Foundation.h>

#import"BYapp.h"
#import "BYinformation.h"
#import "AppImageList.h"
#import "FirstLetter.h"
#import"FAQinformation.h"
#import"AppCatagery.h"
#import"EnglishFirstLetter.h"

@interface LocalSqlManger : NSObject

//======================================保存=======================
//通用保存方法UIAlertView* alertView = [[NSClassFromString(@"UIAlertView") alloc] init];

//+(void)saveTheInformationThroughClass:(char *)calss Nsarray:(NSArray*)array;

/**
 *  保存app信息到app表
 */

+(void)saveTheAppToLocalSqlite:(NSArray *)appArray ;
/**
 *  保存app图片到app图片表
 */


+(void)saveTheAppImaListToTable:(NSDictionary *)imaDic ;
/**
 *  保存消息到消息表
 */
+(void)saveTheInformationToTable:(NSArray *)infoArray;

/**
 *  保存首字母到首字母表
 */
+(void)saveTheFirstLetterToTable:(NSArray *)infoArray;

/**
 *  保存FAQ
 */
+(void)saveTheFAQ:(NSArray *)faqArray;

/**
 *  保存catagery
 */
+(void)saveTheCatagery:(NSArray *)catageryArray;


///=======================================查询========================================================
/**
 *  通过键值来查询
 */

+(NSArray *)selectClass:(NSString *)calss ThroughTheKey:(NSString *)key and:(NSString *)value;

/**
 *  查询所以首字母
 */
+(NSArray *)selectAllFirstLetter;
/**
 *  查询all
 */
+(NSArray *)selectAll;

/**
 *  查询allApp
 */
+(NSArray *)selectAllApp;

/**
 *  查询allmessage
 */
+(NSArray *)selectAllMessage;
/**
 *  查询最大消息id
 *
 */
+ (NSString *)selectMessageMaxId;
/**
 *  查询allFAQ
 */
+(NSArray *)selectAllFaq;
/**
 *  查询allCatagery
 */
+(NSArray *)selectAllCatagery;


//======================================删除===========================================================
+(void)deletateAllInformation:(NSString *)objClass;
+(void)ima:(NSInteger)m and:(NSArray *)list and:(void(^)(int n ,NSString*str))get  ;
+(void)doAgain:(NSInteger)m and:(NSArray *)list and:(void(^)(int n ,NSString*str))get ;

@end
