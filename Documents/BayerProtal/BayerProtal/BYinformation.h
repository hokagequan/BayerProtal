//
//  BYinformation.h
//  BayerProtal
//
//  Created by admin on 14-11-21.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BYinformation : NSManagedObject

@property (nonatomic, retain) NSString * createTime;
@property (nonatomic, retain) NSString * sendMessageContent;
@property (nonatomic, retain) NSString * informationId;
@property (nonatomic, retain) NSNumber * isRead;
@property (nonatomic, retain) NSString * userGroup;
@property (nonatomic, retain) NSString * information;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
