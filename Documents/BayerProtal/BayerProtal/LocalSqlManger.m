//
//  LocalSqlManger.m
//  BayerProtal
//
//  Created by admin on 14-10-15.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "LocalSqlManger.h"
#import "AppDelegate.h"
#import "SqlProperty.h"

#import <objc/message.h>
#import "SSKeychain.h"

@implementation LocalSqlManger



+(void)saveTheAppToLocalSqlite:(NSArray *)appArray
{
    for(NSDictionary *appDic in appArray) {
        BYapp *app = [BYapp MR_createEntity];
        app.appId = [appDic objectForKey:@"appId"];
        app.appCname = [appDic objectForKey:@"appName"];
        app.appEname = [appDic objectForKey:@"appNameEn"];
        app.chineseFirstLetter = [[appDic objectForKey:@"theFirstLetter"]uppercaseString];
        app.englishFirstLetter = [[appDic objectForKey:@"theFirstLetterEn"]uppercaseString];
        app.appCategoryId =[appDic objectForKey:@"categoryId"];
        app.appCDescription = [appDic objectForKey:@"description"];
        app.appEDescription = [appDic objectForKey:@"descriptionEn"];
        app.appUrl = [appDic objectForKey:@"appUrl"];
        app.appIma = [appDic objectForKey:@"appIcon"];
       
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
           }
}


+(void)saveTheAppImaListToTable:(NSDictionary *)imaDic
{
    NSString * appId = [imaDic objectForKey:@"appId"];
    NSArray * imaList = [imaDic objectForKey:@"appImgUrlList"];
    
    for (NSDictionary *dic in imaList) {
        
        AppImageList *image = [AppImageList MR_createEntity];
        image.appId = appId;
        image.imgPath = [dic objectForKey:@"imgPath"];
    }
    
        
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    
}

//catch ima
+(void)ima:(NSInteger)m and:(NSArray *)list and:(void(^)(int n ,NSString*str))get 
{
    [[UItool imageView] sd_setImageWithURL:[NSURL URLWithString:[list objectAtIndex:m] ] placeholderImage:[UIImage imageNamed:@"faq.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //NSLog(@"========3========");
        if (m<[list count]-1) {
            [self doAgain:m+1 and:list and:get];
        }
        else{
            //over
            get(0,@"yes");
        }
        
        
    }];

}

+(void)doAgain:(NSInteger)m and:(NSArray *)list and:(void(^)(int n ,NSString*str))get {
   [[UItool imageView] sd_setImageWithURL:[NSURL URLWithString:[list objectAtIndex:m] ] placeholderImage:[UIImage imageNamed:@"faq.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (m<[list count]-1) {
            [self ima:m+1 and:list and:get];
            
            
        }
        else{
            //over
            get(0,@"yes");
        }
    }];
}

+(void)saveTheInformationToTable:(NSArray *)infoArray
{
    for(NSDictionary *appDic in infoArray) {
        BYinformation *info = [BYinformation MR_createEntity];
        info.isRead = 0;
        info.createTime = [appDic objectForKey:@"createTime"];
        info.information = [appDic objectForKey:@"messageContent"];
        info.informationId = [appDic objectForKey:@"messageId"];
        info.isRead = [NSNumber numberWithInt:0];
        info.userGroup = [[NSUserDefaults standardUserDefaults]objectForKey:@"userGroup"];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    [self selectMessageMaxId];
}

+(void)saveTheCatagery:(NSArray *)catageryArray
{
    for (NSDictionary *catageryDic in catageryArray) {
        if (![[catageryDic objectForKey:@"categoryId"]isEqual:@""]) {
            AppCatagery *appCatagery = [AppCatagery MR_createEntity];
            appCatagery.catageryId = [catageryDic objectForKey:@"categoryId"];
            appCatagery.englishName = [catageryDic objectForKey:@"categoryNameEn"];
            appCatagery.chineseName = [catageryDic objectForKey:@"categoryName"];
            appCatagery.imagUrl = [catageryDic objectForKey:@"img"];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

        }
            }
}


+(void)saveTheFirstLetterToTable:(NSArray *)infoArray
{
    for(int i=0;i<[infoArray count]; i++ ) {
        
        NSArray *array = [LocalSqlManger selectClass:@"FirstLetter" ThroughTheKey:@"firstLetter" and:[[infoArray objectAtIndex:i] uppercaseString]];
        if ([array count]==0) {
            FirstLetter *info = [FirstLetter MR_createEntity];
            info.firstLetter = [[infoArray objectAtIndex:i] uppercaseString];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        
        
    }
}

+(void)saveTheFAQ:(NSArray *)faqArray
{
    for(NSDictionary *appDic in faqArray) {
        FAQinformation *info = [FAQinformation MR_createEntity];
        info.title = [appDic objectForKey:@"title"];
        info.faqId = [appDic objectForKey:@"faqId"];
        info.content = [appDic objectForKey:@"content"];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }

}
+(NSArray *)selectAllFaq
{
    NSArray * fetchResult = [FAQinformation MR_findAll];
    NSArray *array2 = [fetchResult sortedArrayUsingComparator:
                       ^NSComparisonResult(FAQinformation *obj1, FAQinformation *obj2) {
                           // 先按照姓排序
                           NSComparisonResult result = (obj1.faqId.intValue < obj2.faqId.intValue) ? NSOrderedAscending : NSOrderedDescending;
                           
                           return result;
                       }];
    return array2;
    //return array2;
}

+(NSArray *)selectClass:(NSString *)calss ThroughTheKey:(NSString *)key and:(NSString *)value
{
    NSArray *fetchResult;
    if ([calss isEqual:@"BYapp"]) {
        fetchResult = [BYapp MR_findByAttribute:key withValue:value];
    }
    else if ([calss isEqual:@"BYinformation"]) {
        fetchResult = [BYinformation MR_findByAttribute:key withValue:value];
        
    }
    else if ([calss isEqual:@"AppImageList"]) {
        fetchResult = [AppImageList MR_findByAttribute:key withValue:value];
    }
    else if ([calss isEqual:@"FirstLetter"]) {
        fetchResult = [FirstLetter MR_findByAttribute:key withValue:value];
    }
    else if ([calss isEqualToString:@"AppCatagery"] )
    {
//        [AppCatagery MR_findAllWithPredicate:<#(NSPredicate *)#>];
        fetchResult = [AppCatagery MR_findByAttribute:key withValue:value];
        
    }
        return fetchResult;
}

+(NSArray *)selectAllFirstLetter
{
    NSArray * all = [FirstLetter MR_findAll];
    NSMutableArray * all2 = [[NSMutableArray alloc] init];;
    for (FirstLetter * fir in all) {
        [all2 addObject:fir.firstLetter];
        NSLog(@"%@",fir.firstLetter);
    }
    
    return [all2 sortedArrayUsingSelector:@selector(compare:)];
}

+(NSArray *)selectAll
{
    NSArray *all = [BYapp MR_findAll];
//       NSMutableArray * all2 = [[NSMutableArray alloc] init];
//    for (BYapp * fir in all) {
//        [all2 addObject:fir.appCname];
//    }
    return all;

}

+(NSArray *)selectAllApp
{
    NSArray *all = [BYapp MR_findAll];
    
    return all;
    
}


+(NSArray *)selectAllMessage
{
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"userGroup"];
    NSArray *all;
    if (str.length) {
        all = [BYinformation MR_findByAttribute:@"userGroup" withValue:str];
    }
    else{
        all = [BYinformation MR_findAll];
    }
   
    NSArray *array2 = [all sortedArrayUsingComparator:
                       ^NSComparisonResult(BYinformation *obj1, BYinformation *obj2) {
                           // 先按照姓排序
                           NSComparisonResult result = (obj1.informationId.intValue > obj2.informationId.intValue) ? NSOrderedAscending : NSOrderedDescending;
                           
                           return result;
                       }];
        return array2;

}

#define JE_MAXID   @"JE_MAX_ID"
#define JE_ACCOUNT [[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]

+ (NSString *)selectMessageMaxId{
//  NSLog(@"account = %@",JE_ACCOUNT);
    NSError *err;
    NSString *megid = [SSKeychain passwordForService:SERVER_IP account:JE_ACCOUNT error:&err];
    
    NSArray *ary = [self selectAllMessage];
    NSString *msgId = @"0";
    BYinformation *info;
    if (ary.count) {
        info = ary[0];
        msgId = info.informationId;
    }

    megid = String(@"%d",MAX(megid.intValue, msgId.intValue));
    NSError *error;
    [SSKeychain setPassword:megid forService:SERVER_IP account:JE_ACCOUNT error:&error];
    
    return megid;
}


+(NSArray *)selectAllCatagery
{
    // NSArray *all = [AppCatagery MR_findAll];
    NSArray *all = [AppCatagery MR_findAllSortedBy:@"catageryId" ascending:YES];
    NSArray *array2 = [all sortedArrayUsingComparator:
                       ^NSComparisonResult(AppCatagery *obj1, AppCatagery *obj2) {
                           // 先按照姓排序
                           NSComparisonResult result = (obj1.catageryId.intValue < obj2.catageryId.intValue) ? NSOrderedAscending : NSOrderedDescending;
                             
                           return result;
                       }];  

    return array2;
}



+(void)deletateAllInformation:(NSString *)objClass
{
    if ([objClass isEqual:@"BYapp"]) {
        NSArray * all = [BYapp MR_findAll];
        for (BYapp * app in all) {
            [app MR_deleteEntity];
             [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
    }
    else if ([objClass isEqual:@"FirstLetter"])
    {
    NSArray * all2 = [FirstLetter MR_findAll];
    for (FirstLetter * app in all2) {
        [app MR_deleteEntity];
         [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    }
    else if ([objClass isEqual:@"AppImageList"])
    {
    NSArray * all3 = [AppImageList MR_findAll];
    for (AppImageList * app in all3) {
        [app MR_deleteEntity];
         [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    }
    else if ( [objClass isEqual:@"BYinformation"])
    {
    NSArray * all4 = [BYinformation MR_findAll];
    for (BYinformation * app in all4) {
        [app MR_deleteEntity];
         [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    }
    else if ( [objClass isEqual:@"FAQinformation"])
    {
        NSArray * all4 = [FAQinformation MR_findAll];
        for (BYinformation * app in all4) {
            [app MR_deleteEntity];
             [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
    }
    else if ([objClass isEqual:@"AppCatagery"])
    {
        NSArray * all4 = [AppCatagery MR_findAll];
        for (AppCatagery * app in all4) {
            [app MR_deleteEntity];
             [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
    }
    
    
}

+(void)deleteMessageThroughKey:(NSString *)key andValue:(NSString*)vuale
{
    
    NSArray *result = [BYinformation MR_findByAttribute:key withValue:vuale];
    if ([result count]!=0) {
        BYinformation * info = [result objectAtIndex:0];
        [info MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else{
        NSLog(@"=====delegateFAIl");
        
    }
    
}

+(void)updateTheMessageWithId:(NSString *)messageId
{
    NSArray *array = [LocalSqlManger selectClass:@"BYinformation" ThroughTheKey:@"informationId" and:messageId];
    BYinformation *info = [array objectAtIndex:0];
    info.isRead = [NSNumber numberWithInt:1];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
