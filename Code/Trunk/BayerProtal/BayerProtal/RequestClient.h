//
//  RequestClient.h
//  Ipa
//
//  Created by admin on 14-9-9.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"AFHTTPRequestOperation.h"



@interface RequestClient : NSObject

@property (nonatomic,strong) NSDictionary * resultDic;

-(NSDictionary *)postURL:(NSString *)strURL parms:(NSDictionary*)parm;

+ (void)POST:(NSString *)strURL
   parameters:(id)parm
      success:(void (^)(NSDictionary *dict))success
      failure:(void (^)(NSError *error))failure;
@end
