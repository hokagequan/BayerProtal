//
//  BYapp.h
//  BayerProtal
//
//  Created by admin on 14-11-6.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BYapp : NSManagedObject

@property (nonatomic, retain) NSString * appCategoryId;
@property (nonatomic, retain) NSString * appCDescription;
@property (nonatomic, retain) NSString * appId;
@property (nonatomic, retain) NSString * appIma;
@property (nonatomic, retain) NSString * appCname;
@property (nonatomic, retain) NSString * appUrl;
@property (nonatomic, retain) NSString * clickCount;
@property (nonatomic, retain) NSString * chineseFirstLetter;
@property (nonatomic, retain) NSString * appEname;
@property (nonatomic, retain) NSString * appEDescription;
@property (nonatomic, retain) NSString * englishFirstLetter;

@end
