//
//  RequestClient.m
//  Ipa
//
//  Created by admin on 14-9-9.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "RequestClient.h"
#import "AFHTTPRequestOperationManager.h"


@implementation RequestClient
@synthesize resultDic;

//http://www.raywenderlich.com/downloads/weather_sample/weather.php?format=json

-(NSDictionary *)postURL:(NSString *)strURL parms:(NSDictionary*)parm
{
      resultDic = [[NSDictionary alloc] init];
      AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]init];
     // 设置请求格式
      manager.requestSerializer = [AFJSONRequestSerializer serializer];
     // 设置返回格式
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     //设置请求头
     [manager.requestSerializer setValue:@"aidValue" forHTTPHeaderField:@"aid"];
     [manager.requestSerializer setValue:@"aidVdasdaalue" forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"ver"];
    [manager.requestSerializer setValue:@"bayer_portal_ap" forHTTPHeaderField:@"appid"];
     [manager POST:strURL parameters:parm success:^(AFHTTPRequestOperation *operation, id responseObject) {
         resultDic  = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
         NSLog(@"===sd%@",[[resultDic objectForKey:@"head"] objectForKey:@"msg"]);
        
         
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        
    }];
    return resultDic;
}



+ (void)POST:(NSString *)strURL
                      parameters:(id)parm
                         success:(void (^)(NSDictionary *dict))success
                         failure:(void (^)(NSError *error))failure{
//    NSLog(@"________________________________________");
//    
//    NSLog(@"\nRequest URL:%@",strURL);
//    
//    NSLog(@"\nRequest value:%@",parm);
//    
//    NSLog(@"________________________________________");
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]init];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置请求头
    [manager.requestSerializer setValue:@"aidValue" forHTTPHeaderField:@"aid"];
    [manager.requestSerializer setValue:@"aidVdasdaalue" forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"ver"];
    [manager.requestSerializer setValue:@"bayer_portal_ap" forHTTPHeaderField:@"appid"];
    [manager POST:strURL parameters:parm success:^(AFHTTPRequestOperation *operation, id responseObject) {
      NSDictionary *dic  = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
//        if (dic) {
            if ([String(@"%@",[[dic objectForKey:@"head"] objectForKey:@"st"]) isEqualToString:@"0"]) {
                if ([[dic objectForKey:@"body"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *bodyDict = [dic objectForKey:@"body"];
                    if (bodyDict.allKeys.count) {
                        success(dic);
                    }else{
                        failure(nil);
                    }
                }
                else{
                    failure(nil);
                }
                
            }
            else{
                failure(nil);
            }
       // }
//        else{
//            failure(nil);
//        }
  NSLog(@"Response:%@",operation.responseString);
        
  NSLog(@"________________________________________");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"Error:%@",error.userInfo);
    }];
    
    
}
@end
