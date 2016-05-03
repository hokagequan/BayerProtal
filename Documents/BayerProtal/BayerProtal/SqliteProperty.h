//
//  SqliteProperty.h
//  BayerProtal
//
//  Created by admin on 14-10-13.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteProperty : NSObject

@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString * type;
@property (nonatomic , strong) NSString *appURL;
@property (nonatomic ,strong) NSString *simpleDes;


+(NSArray *)getProperty;

@end
