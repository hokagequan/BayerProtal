//
//  SqlProperty.m
//  BayerProtal
//
//  Created by admin on 14-10-15.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "SqlProperty.h"
#import <objc/message.h>

@implementation SqlProperty


+(NSMutableArray *)getPropertyOfTheClass:(char *)myClass

{
    //获取类的属性列表
   // NSString *str = [NSString stringWithFormat:@""%@"",myClass];
    id peopleClass = objc_getClass(myClass);
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(peopleClass, &outCount);
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
        
        [array addObject:propName];
    }
    
    return  array;

}

@end
