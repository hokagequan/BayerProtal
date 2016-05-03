//
//  SqliteDictionary.m
//  BayerProtal
//
//  Created by admin on 14-10-13.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "SqliteDictionary.h"

@implementation SqliteDictionary

+(NSDictionary *)getTheKeys:(NSArray *)keyArry AndValues:(NSArray *)valueArray
{
    int m = [keyArry count];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if ([keyArry count]==[valueArray count]) {
        for (int i =0;i<m;i++ ) {
            [dic setValue:[keyArry objectAtIndex:i] forKey:[valueArray objectAtIndex:i]];
        }
    }
    return dic;
}

@end
