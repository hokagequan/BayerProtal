//
//  IpaRequestManger.h
//  Ipa
//
//  Created by admin on 14-9-9.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IpaRequestManger : NSObject


 //获取数据、
+(NSDictionary *)getInformationOfUrl:(NSString *)strUrl parms:(NSDictionary *)dic;

+(void)refreshContents:(void(^)(int n,NSString*str))getN;

/**
 *  向服务器提交百度推送id
 *
 *  @param baiduUserId    百度userid
 *  @param baiduChannelId 百度ChannelId
 *  @param userGroup      所属分组
 */
+(void)updataMybaiduUserId:(NSString *)baiduUserId
            baiduChannelId:(NSString *)baiduChannelId
                 userGroup:(NSString *)userGroup
                    success:(void (^)(NSDictionary *dict))success
                    failure:(void (^)(NSError *error))failure;


+(void)insertMessage;

@end
