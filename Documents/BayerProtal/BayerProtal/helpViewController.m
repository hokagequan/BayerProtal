//
//  helpViewController.m
//  BayerProtal
//
//  Created by admin on 14-10-24.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "helpViewController.h"

@interface helpViewController ()

@end

@implementation helpViewController

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
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changelanguage:) name:@"changeLanguage" object:nil];
    [self createScrollView];
    [self loadData];
}

-(void)createScrollView
{
    self.imagScrollView = [[UIScrollView alloc] initWithFrame:ccr(TabBar_WIDTH, Nav_HEIGHT, 1024-TabBar_WIDTH, 768-Nav_HEIGHT)];
    //self.imagScrollView.backgroundColor = [UIColor redColor];
    self.imagScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.imagScrollView];
    
}



-(void)changelanguage:(NSNotification *)noti
{
    [self loadData];
}

-(void)loadData
{
    NSArray *array =[NSArray array];//[NSArray arrayWithObjects:@"tishi1.jpg",@"tishi2.jpg",@"tishi3.jpg", nil];
    
    if ([UItool isChinese]==YES) {
        self.titleLabel.text = @"帮助";
        array = @[@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",@"6.png",@"7.png",@"8.png",@"9.png",@"10.png",@"11.png",@"12.png",@"13.png"];
    }
    else{
        self.titleLabel.text = @"Help";
        array = @[@"e1.png",@"e2.png",@"e3.png",@"e4.png",@"e5.png",@"e6.png",@"e7.png",@"e8.png",@"e9.png",@"e10.png",@"e11.png",@"e12.png",@"e13.png"];
    }
    
    for (int n =0; n<[array count]; n++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:ccr(0, (self.view.frame.size.height-Nav_HEIGHT)*n , 1024-TabBar_WIDTH, 768-Nav_HEIGHT)];
        imageView.image = [UIImage imageNamed:[array objectAtIndex:n]];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.imagScrollView addSubview:imageView];
        //imageView.backgroundColor = [UIColor orangeColor];
    }
    [self.imagScrollView setContentSize:CGSizeMake(1024-TabBar_WIDTH, (768-Nav_HEIGHT)*[array count])];
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

-(void)henOfView
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
}
-(void)shuOfView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
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
