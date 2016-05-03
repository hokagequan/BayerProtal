//
//  languageViewController.m
//  BayerProtal
//
//  Created by admin on 14-10-24.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "languageViewController.h"

@interface languageViewController ()
{
    UIView *view;
    UIButton *chineseBT;
    UIButton *imaBT;
    UIButton *englishBT;
    UIView *lineView;
    UILabel *chinese;
    UILabel *english;
   
    
}

@end

@implementation languageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.：rbg（238,238,238）
   //self.view.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:0.9];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLanguage:) name:@"changeLanguage" object:nil];
    [self makeView];
    [self loadData];
}

-(void)changeLanguage:(NSNotification *)noti
{
    [self loadData];
}

-(void)loadData
{
    if ([UItool isChinese]==YES) {
        self.titleLabel.text = @"语言设置";
    }
    else{
        self.titleLabel.text = @"Language Settings";
    }
    
}
-(void)henOfView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
    view.frame = ccr((1024-TabBar_WIDTH)/2-200, Nav_HEIGHT+30,500, 200);
    lineView.frame = ccr(20, view.frame.size.height/2, view.frame.size.width-40, 1);
    chineseBT.frame = ccr(0, 0, view.frame.size.width, view.frame.size.height/2);
    englishBT.frame = ccr(0, view.frame.size.height/2, view.frame.size.width, view.frame.size.height/2);
    chinese.frame = ccr(10, view.frame.size.height/6, 100, view.frame.size.height/6);
    english.frame = ccr(10, 4*view.frame.size.height/6, 100, view.frame.size.height/6);
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageTag"]isEqualToString:@"chinese"]) {
        imaBT.frame = ccr(view.frame.size.width-60, view.frame.size.height/6, 43, 43);
    }
    else{
        imaBT.frame = ccr(view.frame.size.width-60, 4*view.frame.size.height/6, 43, 43);
    }
    
   //self.titleLabel.frame = ccr(SCREEN_HEIGHT/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
    
    //self.lognBT.frame = ccr(SCREEN_HEIGHT-73, (Nav_HEIGHT-63)/2, 63, 63);
}

-(void)shuOfView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
    view.frame = ccr(SCREEN_WIDTH/6, Nav_HEIGHT+30, 2*SCREEN_WIDTH/3, 200);
    lineView.frame = ccr(20, view.frame.size.height/2, view.frame.size.width-40, 1);
    chineseBT.frame = ccr(0, 0, view.frame.size.width, view.frame.size.height/2);
    englishBT.frame = ccr(0, view.frame.size.height/2, view.frame.size.width, view.frame.size.height/2);
    chinese.frame = ccr(10, view.frame.size.height/6, 100, view.frame.size.height/6);
    english.frame = ccr(10, 4*view.frame.size.height/6, 100, view.frame.size.height/6);
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageTag"]isEqualToString:@"chinese"]) {
        imaBT.frame = ccr(view.frame.size.width-60, view.frame.size.height/6, 43, 43);
        chinese.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:0.8];
        english.textColor = [UIColor blackColor];
    }
    else{
       imaBT.frame = ccr(view.frame.size.width-60, 4*view.frame.size.height/6, 43, 43);
        english.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:0.8];
        chinese.textColor = [UIColor blackColor];
    }
    
   // self.titleLabel.frame = ccr(SCREEN_WIDTH/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
    //self.titleLabel.frame = ccr(0, 0, 100, 100);
   // self.titleLabel.text = @"Language Settings";
  //  self.lognBT.frame = ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-63)/2, 63, 63);

}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [self henOfView];
    }
    else{
        [self shuOfView];
    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            [self shuOfView];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            [self shuOfView];
            break;
        case UIInterfaceOrientationLandscapeLeft:
            [self henOfView];
            break;
        case UIInterfaceOrientationLandscapeRight:
            [self henOfView];
            break;
            
        default:
            break;
    }
}

-(void)makeView
{
    view = [[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor whiteColor];
    //view.layer.borderColor = CFBridgingRetain([UIColor whiteColor]);
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    
    
    [self.view addSubview:view];
    chineseBT = [[UIButton alloc] initWithFrame:CGRectZero];
    chineseBT.tag = 1;
    [chineseBT addTarget:self action:@selector(choseLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:chineseBT];
    englishBT = [[UIButton alloc] initWithFrame:CGRectZero];
    englishBT.tag = 2;
    [englishBT addTarget:self action:@selector(choseLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:englishBT];
    imaBT = [[UIButton alloc] initWithFrame:CGRectZero];
    [imaBT setImage:[UIImage imageNamed:@"selected.jpg"] forState:UIControlStateNormal];
    lineView = [[UIView alloc]initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor blackColor];
    [view addSubview:lineView];
    [view addSubview:imaBT];
    
    chinese = [[UILabel alloc]initWithFrame:CGRectZero];
    english = [[UILabel alloc] initWithFrame:CGRectZero];
    chinese.text = @"简体中文";
    english.text = @"English";
    [view addSubview:chinese];
    [view addSubview:english];
    
    //self.titleLabel.text = @"Language Settings";
    
}


-(void)choseLanguage:(id)sender
{
    UIButton * but = sender;
    switch (but.tag) {
        case 1:
            if ([UItool isChinese]==NO) {
                [[NSUserDefaults standardUserDefaults] setObject:@"chinese" forKey:@"languageTag"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                imaBT.frame = ccr(view.frame.size.width-60, view.frame.size.height/6, 43, 43);
                chinese.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:0.8];
                english.textColor = [UIColor blackColor];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"changeLanguage" object:self userInfo:nil];
            }
            
           

            break;
        case 2:
            if ([UItool isChinese]==YES) {
                [[NSUserDefaults standardUserDefaults] setObject:@"english" forKey:@"languageTag"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                imaBT.frame = ccr(view.frame.size.width-60, 4*view.frame.size.height/6, 43, 43);
                english.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:0.8];
                chinese.textColor = [UIColor blackColor];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"changeLanguage" object:self userInfo:nil];
            }
            
            break;
            
        default:
            break;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
