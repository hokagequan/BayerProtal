//
//  FMDBManager.m
//  myFMDB
//
//  Created by admin on 14-8-11.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "FMDBManager.h"

@interface FMDBManager ()


@end

@implementation FMDBManager
@synthesize dataBase;

@synthesize path;

static FMDBManager *sharedManager;


+(instancetype)defaultDBManager
{
    if (!sharedManager) {
       
        sharedManager = [[FMDBManager alloc] init];
        
    }
    return sharedManager;
}

-(id)init
{
    self = [super init];
    if (self) {
        int state = [self initializeDBWithName:@"mysqlite.sqlite"];
        if (state!=-1) {
            NSLog(@"数据库初始化success");
        }
        else{
            NSLog(@"数据库初始化failed");
        }
    }
    return self;
}


-(void)closeDataBase
{
    [dataBase close];
    sharedManager = nil;
    
}

/**
 * @brief 初始化数据库操作
 * @param name 数据库名称
 * @return 返回数据库初始化状态， 0 为 已经存在，1 为创建成功，-1 为创建失败
 */
- (int) initializeDBWithName : (NSString *) name {
    if (!name) {
		return -1;  // 返回数据库创建失败
	}
    // 沙盒Docu目录
    NSString * docp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
	path = [docp stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
	NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:path];
    [self connect];
    if (!exist) {
        return 0;
    } else {
        return 1;          // 返回 数据库已经存在
        NSLog(@"数据库已存在");
        
	}
    
    
    
}

// 连接数据库
- (void) connect {
	if (!dataBase) {
		dataBase = [[FMDatabase alloc] initWithPath:path];
	}
	if (![dataBase open]) {
		NSLog(@"不能打开数据库");
	}
    else{
        NSLog(@"数据库打开success");
    }
}




@end
