//
//  AppCatagery.h
//  BayerProtal
//
//  Created by admin on 14-11-12.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AppCatagery : NSManagedObject

@property (nonatomic, retain) NSString * catageryId;
@property (nonatomic, retain) NSString * chineseName;
@property (nonatomic, retain) NSString * englishName;
@property (nonatomic, retain) NSString * imagUrl;

@end
