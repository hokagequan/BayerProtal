//
//  AppImageList.h
//  BayerProtal
//
//  Created by admin on 14-10-23.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AppImageList : NSManagedObject

@property (nonatomic, retain) NSString * appId;
@property (nonatomic, retain) NSString * imgPath;

@end
