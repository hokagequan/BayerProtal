//
//  JEFAQContentModel.m
//  BayerProtal
//
//  Created by 尹现伟 on 14/10/27.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "JEFAQContentModel.h"

@implementation JEFAQContentModel

- (id)initWithContent:(NSString *)content height:(NSString *)height{
    self = [super init];
    if (self) {
        self.content = content;
        self.height =  height;
    }
    return self;
}
+ (id)initWithContent:(NSString *)content height:(NSString *)height{
    return [[[self class]alloc]initWithContent:content height:height];
}
@end
