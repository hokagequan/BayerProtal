//
//  UserDB.h
//  myFMDB
//
//  Created by admin on 14-8-11.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBManager.h"
@interface UserDB : NSObject
{
    FMDatabase *_db;
    
}

@property (nonatomic)BOOL existTable;


/**
 * @brief 判断是否数据库表
 */
-(BOOL)exitBaseTable:(NSString *)baseTableName;

/**
 * @brief 创建数据库表
 */
-(void)createDataBaseTable:(NSMutableDictionary *)info;

/**
 * @brief 查询数据库
 */
-(NSMutableDictionary*)selectInformation:(NSDictionary *)info;

/**
 * @brief 保存一条用户记录
 *
 * @param info 需要保存的用户数据
 */

-(void)saveInformation:(NSMutableDictionary *)info;

/**
 * @brief 删除数据库表或者清除缓存
 */

-(void)deleteInfoemation:(NSDictionary *)info;

/**
 * @brief 关闭数据库
 */
-(BOOL)close;

/**
 * @brief 打开数据库
 */

-(BOOL)open;


/**
 * @brief 更新数据库
 */

-(BOOL)updateInformation:(NSDictionary *)info;

@end
