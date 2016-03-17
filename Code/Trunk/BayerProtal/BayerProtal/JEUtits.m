//
//  JEUtits.m
//  BayerProtal
//
//  Created by 尹现伟 on 14/10/24.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "JEUtits.h"
#import <CommonCrypto/CommonDigest.h>

@implementation JEUtits
+ (BOOL)openAppWithURL:(NSString *)url{
    NSURL *urlS = URL(@"%@",url);
    if (![APPD canOpenURL:urlS]) {
        return NO;
    }
    return [APPD openURL:urlS];
}
+ (NSString *)pathWithFileName:(NSString *)name{
    NSArray *ary = [name componentsSeparatedByString:@"."];
    if (ary.count == 2) {
        return [[NSBundle mainBundle] pathForResource:ary[0] ofType:ary[1]];
    }
    else if(name.length){
        return [[NSBundle mainBundle] pathForResource:name ofType:@""];
    }
    return @"";
}
+ (NSString *)stringWithPath:(NSString *)path{
    NSString *textFileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error: nil];
    return textFileContents;
}
+ (NSArray *)get5CommonApps{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[AppClickEntity MR_findAllSortedBy:@"clickCount" ascending:NO]];
    NSArray *enAry = array;
    if (array.count>5) {
        enAry = [array subarrayWithRange:NSMakeRange(0, 5)];
    }
    NSArray *apps = [BYapp MR_findAll];
    NSMutableArray *byApps = [NSMutableArray array];
    for (AppClickEntity *cEn in enAry) {
        for (BYapp *aEn in apps) {
            if ([cEn.idStr isEqualToString:aEn.appId]) {
                [byApps addObject:aEn];
                if (byApps.count == 5) {
                    break;
                }
            }
        }
    }
    return byApps;
}

+ (void)addOneClickWithAppEntity:(BYapp *)entity{
    NSArray *array = [AppClickEntity MR_findAll];
    if (array.count) {
        BOOL isHaveEntity = NO;
        for (AppClickEntity *clickEntity in array) {
            if ([clickEntity.idStr isEqualToString:entity.appId]) {
                isHaveEntity = YES;
                clickEntity.clickCount = String(@"%d",[clickEntity.clickCount intValue] + 1);
                [self save];
                return;
            }
        }
    }
    AppClickEntity *en = [AppClickEntity MR_createEntity];
    en.idStr = entity.appId;
    en.clickCount = @"1";
    [self save];
}



+ (NSString *)sha1:(NSString *)str {
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

+ (NSString *)md5Hash:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    NSString *md5Result = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return md5Result;
}

@end

@implementation JEUtits (CoreData)


+ (void)save{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
