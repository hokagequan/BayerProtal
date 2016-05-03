//
//  AppClickEntity.h
//  BayerProtal
//
//  Created by 尹现伟 on 14/10/27.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AppClickEntity : NSManagedObject

@property (nonatomic, retain) NSString * idStr;
@property (nonatomic, retain) NSString * clickCount;

@end
