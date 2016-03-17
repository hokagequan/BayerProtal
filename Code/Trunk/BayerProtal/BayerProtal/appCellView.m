//
//  appCellView.m
//  BayerProtal
//
//  Created by admin on 14-10-16.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "appCellView.h"
#import "DXAlertView.h"

@implementation appCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
      
        self.imaButton = [[UIButton alloc] initWithFrame:CGRectZero];
        self.imaButton.backgroundColor = [UIColor clearColor];
//        self.imaButton.layer.cornerRadius = 15;
//        self.imaButton.clipsToBounds = YES;
        //    self.imaButton.layer.masksToBounds = YES;
        self.desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.moreButton = [[UIButton alloc] initWithFrame:CGRectZero];
        
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.desLabel.textAlignment = NSTextAlignmentCenter;
        self.desLabel.numberOfLines = 0;
        [self addSubview:self.imaButton];
        [self addSubview:self.desLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.moreButton];
        
        
        
        }
    return self;
}

-(void)makeTheNewUI
{
    self.imaButton.frame = ccr(0, 0, self.frame.size.width/2-10, self.frame.size.width-25-100);
    self.desLabel.frame = ccr(self.imaButton.frame.size.width+10, 0, self.frame.size.width/2, self.frame.size.height/2);
    
    self.nameLabel.frame = ccr(0, self.frame.size.height-20, self.imaButton.frame.size.width, 20);
    
    self.moreButton.frame = ccr(self.desLabel.frame.origin.x-10, self.desLabel.frame.size.height+5, self.frame.size.width/2+10, self.frame.size.height/4);
    [self.moreButton addTarget:self action:@selector(moreButtonDo:) forControlEvents:UIControlEventTouchUpInside];
    [self.imaButton addTarget:self action:@selector(imaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)makeTheNewUI:(BYapp *)app
{
    self.byApp = app;
    self.imaButton.frame = ccr(0, 0, 80, 80);
//    self.imaButton.layer.cornerRadius = 15;
//    self.imaButton.clipsToBounds = YES;
//    self.imaButton.layer.masksToBounds = YES;
    self.desLabel.frame = ccr(self.imaButton.frame.size.width+10, 0, self.frame.size.width/2, self.frame.size.height/2);
    
    self.nameLabel.frame = ccr(-45, self.frame.size.height-20, self.imaButton.frame.size.width+90, 20);
    
    self.moreButton.frame = ccr(self.desLabel.frame.origin.x-8, self.desLabel.frame.size.height+3, self.frame.size.width/2+10, self.frame.size.height/4);
    [self.moreButton addTarget:self action:@selector(moreButtonDo:) forControlEvents:UIControlEventTouchUpInside];
    [self.imaButton addTarget:self action:@selector(imaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([UItool isChinese]==YES) {
        self.nameLabel.text = app.appCname;
        self.desLabel.text = app.appCDescription;
    }
    else{
        self.nameLabel.text = app.appEname;
        self.desLabel.text = app.appEDescription;
    }
    //faq.png
    
    self.moreButton.tag = [app.appId intValue];
    UIImage *image = [UIImage imageNamed:@"faq.png"];;
//    if (![UItool APCheckIfAppInstalled2:app.appUrl]) {
//        image= [UItool getGrayImage:image];
//        self.imaButton.layer.cornerRadius = 15;
//        //self.imaButton.clipsToBounds = YES;
//        self.imaButton.layer.masksToBounds = YES;
//
//        [self.imaButton setBackgroundImage:image forState:UIControlStateNormal];
//    }

    [self.imaButton sd_setBackgroundImageWithURL:[NSURL URLWithString:app.appIma] forState:UIControlStateNormal placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (![UItool APCheckIfAppInstalled2:app.appUrl]) {
            UIImage *image= [UItool getGrayImage:self.imaButton.currentBackgroundImage];
            [self.imaButton setBackgroundImage:image forState:UIControlStateNormal];
        }
        
    }];
    if ([UItool isChinese]==YES) {
        [self.moreButton setBackgroundImage:[UIImage imageNamed:@"more_btn_cn.png"] forState:UIControlStateNormal];
    }
    else{
        [self.moreButton setBackgroundImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    }

    
    
}

+(id)makeTheNewViewWithFrame:(CGRect)frame
{
    appCellView * view = [[self alloc]initWithFrame:frame];
    if (view) {
        
        [view.nameLabel removeFromSuperview];
        view.desLabel.frame = ccr(view.imaButton.frame.size.width+10, 0, frame.size.width/2, frame.size.height/2);
        
        view.nameLabel.frame = ccr(0, view.frame.size.height-20, view.imaButton.frame.size.width, 20);
        
        view.moreButton.frame = ccr(view.desLabel.frame.origin.x-10, view.desLabel.frame.size.height+5, frame.size.width/2+10, frame.size.height/4);
        
        [view.moreButton addTarget:self action:@selector(detailMoreButtonDo:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:view.desLabel];
        [view addSubview:view.imaButton];
        [view addSubview:view.moreButton];
    }
    return view;
}

-(void)detailMoreButtonDo:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(moreButtonAction:)]) {
        [self.delegate moreButtonAction:sender];
    }
    
    }

-(void)imaButtonAction:(id)sender
{
    NSString *str;NSString *std;NSString *stf;
    if ([UItool isChinese]==YES) {
        str = @"提示";
        std = @"请从拜耳企业应用商店（App Catalog）下载安装";
        stf = @"请从iPad端直接打开已下载的应用 ";
    }
    else{
        str = @"Alert";
        std = @ "Please download the application from App Catalog.";
        stf = @ "Please open the application directly from your iPad.";
    }
    
    NSRange range = [self.byApp.appUrl rangeOfString:@"http"];
    if (range.location==NSNotFound) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",self.byApp.appUrl]]])
        {
            [JEUtits addOneClickWithAppEntity:self.byApp];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",self.byApp.appUrl]]];
            }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:std delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];

        }
    }
    
    else if(range.location!=NSNotFound){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.byApp.appUrl]];
        [JEUtits addOneClickWithAppEntity:self.byApp];

    }
    else{
        
    }

    
    ///
//    if (![self.byApp.appUrl isEqualToString:@""]) {
//        if (![UItool APCheckIfAppInstalled2:self.byApp.appUrl]) {
//            NSRange range = [self.byApp.appUrl rangeOfString:@"http"];
//            if (range.location!=NSNotFound) {
//                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.byApp.appUrl]];
//                [JEUtits addOneClickWithAppEntity:self.byApp];
//            }
//            else{
//            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:str contentText:std];
//            [alert show];
//            }
//        }
//        else
//        {
//            [JEUtits addOneClickWithAppEntity:self.byApp];
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",self.byApp.appUrl]]];
//            
//            }
//    }
//    else{
//        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:str contentText:stf];
//        [alert show];
//    }
    
}
-(void)moreButtonDo:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moreButtonAction" object:sender];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
