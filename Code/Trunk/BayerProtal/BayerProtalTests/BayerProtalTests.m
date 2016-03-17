//
//  BayerProtalTests.m
//  BayerProtalTests
//
//  Created by admin on 14-9-24.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JEUtits.h"

@interface BayerProtalTests : XCTestCase

@end

@implementation BayerProtalTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testScrollV{
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:ccr(0, 0, 100, 100)];
    for (int i = 0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:ccr(i*100, 0, 100, 100)];
        imageView.tag = i;
        [scrollV addSubview:imageView];
    }
    
    UIImageView *imgV = (UIImageView *)[scrollV viewWithTag:4];
    
    if (imgV.superview == scrollV) {
        UIScrollView *scrV = imgV.superview;
        for (UIImageView *imgView in scrV) {
            NSLog(@"-------%d",imgView.tag);
        }
    }
}


- (void)testInsterData{
    AppClickEntity *e = [AppClickEntity MR_createEntity];
    e.idStr = @"10032";
    e.clickCount = @"23";
    [JEUtits save];
    for (int i = 10000; i<10050; i++) {
        BYapp *app = [BYapp MR_createEntity];
        app.appId = [NSString stringWithFormat:@"%d",i];
        app.englishFirstLetter = @"A";
        app.appCname = [NSString stringWithFormat:@"第%d个应用",i];
        [JEUtits save];
        
        [JEUtits addOneClickWithAppEntity:app];
    }
    NSArray *array = [JEUtits get5CommonApps];
    for (BYapp *en in array) {
        if ([en.appId isEqualToString:@"10032"]) {
            break;
        }
        XCTFail(@"判断不对");
    }
}


@end
