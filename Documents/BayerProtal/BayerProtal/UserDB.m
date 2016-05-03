//
//  UserDB.m
//  myFMDB
//
//  Created by admin on 14-8-11.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "UserDB.h"
#import "FMDBManager.h"

@implementation UserDB
@synthesize existTable;


-(id)init
{
    self = [super self];
    if (self) {
        _db = [FMDBManager defaultDBManager].dataBase;
    }
    return self;
}

-(BOOL)close
{
   return  [_db close];
}

/**
 * @brief 判断是否存在表
 */

-(BOOL)exitBaseTable:(NSString *)baseTableName
{
    FMResultSet *set = [_db executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",baseTableName]];
    [set next];
    NSInteger count = [set intForColumnIndex:0];
     existTable = !!count;
    return existTable;
    
}

/**
 * @brief 调用exitBaseTable方法后获取bool值判断，在调用创建数据库表方法
 */

-(void)createDataBaseTable:(NSMutableDictionary *)info
{
    NSMutableString * sql = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (uid INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL",[info objectForKey:@"tableName"]];
    NSArray * array;
    array = [info objectForKey:@"array"];
    int i =0;
    for (NSString * std in array) {
        NSLog(@"%@",std);
        [sql appendString:[NSString stringWithFormat:@",%@",std]];
        i++;
    }
    [sql appendString:@")"];
    NSLog(@"创建表：%@",sql);
    BOOL res = [_db executeUpdate:sql];
    if (!res) {
        NSLog(@"创建表失败");
    } else {
        NSLog(@"创建表success");
    }
}


-(BOOL)doBaseTable:(NSString *)ssql
{
    BOOL res = [_db executeUpdate:ssql];
    return res;
}

-(void)saveInformation:(NSMutableDictionary *)info{
    
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO SUser (name,description)VALUES ('cc3', 'hello3')"];
    [_db executeUpdate:sql];
    
}

/**
 * @brief 查询数据库
 */
-(NSMutableDictionary*)selectInformation:(NSDictionary *)info
{
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM SUser WHERE name=cc2"];
    FMResultSet * rs = [_db executeQuery:sql];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[rs stringForColumn:@"uid"] forKey:@"uid"];
    [dic setValue:[rs stringForColumn:@"name"] forKey:@"name"];
    [dic setValue:[rs stringForColumn:@"description"] forKey:@"description"];
    return dic;
}

/**
 * @brief 删除数据库表或者清除缓存
 */

-(void)deleteInfoemation:(NSDictionary *)info
{
    NSString * query = [NSString stringWithFormat:@"DELETE FROM SUser"];
    [_db executeUpdate:query];
}

/**
 * @brief 打开数据库
 */

-(BOOL)open
{
    return [_db open];
}


/**
 * @brief 更新数据库
 */

-(BOOL)updateInformation:(NSDictionary *)info
{
    NSString * query = [NSString stringWithFormat:@"UPDATE 表名称 SET 列名称=新值  WHERE   "];
    if ([_db executeUpdate:query]) {
        return YES;
        }
    else
    return NO;
}




@end
