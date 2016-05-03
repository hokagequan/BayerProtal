//
//  IpaRequestManger.m
//  Ipa
//
//  Created by admin on 14-9-9.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "IpaRequestManger.h"
#import "RequestClient.h"
#import "AFHTTPRequestOperation.h"
#import "BYloadView.h"

@implementation IpaRequestManger



+(NSDictionary *)getInformationOfUrl:(NSString *)strUrl parms:(NSDictionary *)dic
{
    RequestClient * client = [[RequestClient alloc] init];
    
    return  [client postURL:strUrl parms:dic];
    
}

+(void)updataMybaiduUserId:(NSString *)baiduUserId
            baiduChannelId:(NSString *)baiduChannelId
                 userGroup:(NSString *)userGroup
                   success:(void (^)(NSDictionary *dict))success
                   failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc] init];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"];
    [parms setObject:str forKey:@"userGroup"];
    [parms setObject:baiduChannelId forKey:@"baiduChannelId"];
    [parms setObject:baiduUserId forKey:@"baiduUserId"];

    [RequestClient POST:[ByServerURL getLoginUrl] parameters:parms success:^(NSDictionary *dict) {
        success(dict);
    } failure:^(NSError *error) {
        failure(nil);
    }];
}


+(void)refreshContents:(void(^)(int n,NSString*str))getN ;
{
    //[BYloadView loadState:YES];
    static int m = 0;
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc] init];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"];
    //[parms setObject:str forKey:@"userGroup"];
    [parms setObject:str forKey:@"userGroup"];
    [RequestClient POST:[ByServerURL getAllAppUrl] parameters:parms success:^(NSDictionary *dict) {
        
        
        
        NSLog(@"提示====%@",[[dict objectForKey:@"head"] objectForKey:@"msg"]);
        NSDictionary * dic = [dict objectForKey:@"body"];
        NSLog(@"Appdic==%@",dict);
        
        //先删除数据
        [LocalSqlManger deletateAllInformation:@"BYapp"];
        [LocalSqlManger deletateAllInformation:@"FirstLetter"];
        [LocalSqlManger deletateAllInformation:@"AppImageList"];
        [LocalSqlManger deletateAllInformation:@"AppCatagery"];
        
        //写入本地数据库
        NSArray * List = [dic objectForKey:@"appList"];
        if ([List count]==0) {
            getN(0,@"failed");
        }
        
        [LocalSqlManger saveTheAppToLocalSqlite:List];
        NSArray * firstLetterList = [dic objectForKey:@"theFirstLetterList"];
        [LocalSqlManger saveTheFirstLetterToTable:firstLetterList];
        NSArray *catagoryList = [dic objectForKey:@"categoryList"];
        [LocalSqlManger saveTheCatagery:catagoryList];
        
        //图片存入
        NSMutableDictionary * imaDic = [[NSMutableDictionary alloc] init];
        NSMutableArray * imagList = [NSMutableArray array];
        for (NSDictionary *nsDic in List) {
            NSArray *imaList = [nsDic objectForKey:@"appImgUrlList"];
            NSString * appId = [nsDic objectForKey:@"appId"];
            [imaDic setValue:appId forKey:@"appId"];
            [imaDic setValue:imaList forKey:@"appImgUrlList"];
            [LocalSqlManger saveTheAppImaListToTable:imaDic];
            [imagList addObject:[nsDic objectForKey:@"appIcon"]];
            
            for (int i=0; i<[imaList count]; i++) {
                [imagList addObject:[[imaList objectAtIndex:i]objectForKey:@"imgPath"]];
            }
            
            //缓存图片
            if ([imagList count]!=0) {
                [LocalSqlManger ima:0 and:imagList and:^(int n, NSString *str) {
                    getN(0,str);
                }];
                
                
                
            }
             else{
                getN(0,@"noImage");
             }
                    }
        m++;
        getN(m,@"no");

    } failure:^(NSError *error) {
        NSLog(@"APPerror::%@",error);
       // if (error) {
            m++;
            getN(m,@"failed");
            
        //}
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%d",error.code] message:@"getAllAppUrl" delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil, nil];
//        [alert show];
    }];
        
    [parms setObject:[LocalSqlManger selectMessageMaxId] forKey:@"messageId"];
//    [UIAlertView showMessage:String(@"3 max id :%@",[LocalSqlManger selectMessageMaxId])];

    //获取消息列表
    [RequestClient POST:[ByServerURL getInformationUrl] parameters:parms success:^(NSDictionary *dict) {
        NSLog(@"message===%@",dict);
        NSArray *informationArr = [[dict objectForKey:@"body"] objectForKey:@"messageList"];
        //[LocalSqlManger deletateAllInformation:@"BYinformation"];
        [LocalSqlManger saveTheInformationToTable:informationArr];
        m++;
        getN(m,@"no");
    } failure:^(NSError *error) {
        NSLog(@"messageerror:;%@",error);
       // if (error) {
            m++;
            getN(m,@"failed");
            
       // }
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%d",error.code] message:@"getInformationUrl" delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil, nil];
//        [alert show];

    }];
    
    //获取FAq
    [RequestClient POST:[ByServerURL getFAQ] parameters:parms success:^(NSDictionary *dict) {
        NSLog(@"faq===%@",dict);
        [LocalSqlManger deletateAllInformation:@"FAQinformation"];
        NSArray *informationArr = [[dict objectForKey:@"body"] objectForKey:@"faqList"];
        [LocalSqlManger saveTheFAQ:informationArr];
        m++;
        getN(m,@"no");
        
    } failure:^(NSError *error) {
        NSLog(@"error:;%@",error);
        //if (error) {
            m++;
            getN(m,@"failed");

       // }
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%d",error.code] message:@"getFAQ" delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil, nil];
//        [alert show];
        
    }];
    
    
    
//    [RequestClient POST:[ByServerURL getMuserGroup] parameters:nil success:^(NSDictionary *dict) {
//        NSLog(@"muser===%@",dict);
//        m++;
//        getN(m,@"no");
//        
//    } failure:^(NSError *error) {
//        NSLog(@"error:;%@",error);
//       // if (error) {
//            m++;
//            getN(m,@"failed");
//            
//       // }
//    }];
    
    // [queue waitUntilAllOperationsAreFinished];
    
   
    

}
    

+(void)insertMessage
{

    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc] init];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"];
    //[parms setObject:str forKey:@"userGroup"];
    [parms setObject:str forKey:@"userGroup"];
    
    [parms setObject:[LocalSqlManger selectMessageMaxId] forKey:@"messageId"];
//    [UIAlertView showMessage:String(@"4 max id :%@",[LocalSqlManger selectMessageMaxId])];

    //获取消息列表
    [RequestClient POST:[ByServerURL getInformationUrl] parameters:parms success:^(NSDictionary *dict) {
        NSLog(@"message===>>>>>%@",dict);
        NSArray *informationArr = [[dict objectForKey:@"body"] objectForKey:@"messageList"];

        [LocalSqlManger saveTheInformationToTable:informationArr];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refershMessage" object:self];
    } failure:^(NSError *error) {
        NSLog(@"error:;%@",error);
        
    }];

}

@end
