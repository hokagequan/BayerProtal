//
//  SqliteProperty.m
//  BayerProtal
//
//  Created by admin on 14-10-13.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "SqliteProperty.h"
#import <objc/message.h>

@implementation SqliteProperty

+(NSArray *)getProperty
{
    //获取类的属性列表
    id peopleClass = objc_getClass("SqliteProperty");
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(peopleClass, &outCount);
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        //id value = [people <span style="font-family: Arial, Helvetica, sans-serif;"> </span>valueForKey:propName];
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
       
        [array addObject:propName];
    }
     NSArray * array2 = array;
    return  array2;
}

@end
