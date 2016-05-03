//
//  FAQinformation.h
//  BayerProtal
//
//  Created by admin on 14-10-29.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FAQinformation : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * faqId;
@property (nonatomic, retain) NSString * title;

@end
