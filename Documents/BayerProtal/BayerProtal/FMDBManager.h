//
//  FMDBManager.h
//  myFMDB
//
//  Created by admin on 14-8-11.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDB.h"
/**
 * @brief 对数据链接进行管理，包括链接，关闭连接
 * 可以建立长连接 长连接
 */
@interface FMDBManager : NSObject

@property(nonatomic,strong)NSString * DBName;

@property(nonatomic,strong)NSString * path;

//数据库对象
@property (nonatomic,readonly)FMDatabase *dataBase;

+(instancetype)defaultDBManager;

//关闭数据库
-(void)closeDataBase;

@end
