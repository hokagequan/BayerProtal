//
//  JEFAQContentModel.h
//  BayerProtal
//
//  Created by 尹现伟 on 14/10/27.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEFAQContentModel : NSObject

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *height;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

@property (nonatomic, retain) NSString * title;

@property (nonatomic, retain) NSString * faqId;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (id)initWithContent:(NSString *)content height:(NSString *)height;

@end
