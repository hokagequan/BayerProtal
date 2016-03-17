//
//  faqInfor.h
//  BayerProtal
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface faqInfor : NSObject

@property (nonatomic, assign, getter = isOpened) BOOL opened;

@property (nonatomic, retain) NSString * title;

@property (nonatomic, retain) NSString * faqId;

@property (nonatomic, retain) NSString * content;

@end
