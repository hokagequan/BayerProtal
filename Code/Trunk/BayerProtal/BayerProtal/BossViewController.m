//
//  BossViewController.m
//  BayerProtal
//
//  Created by admin on 14-9-28.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "BossViewController.h"

@interface BossViewController ()


@end

@implementation BossViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationController.navigationBar.hidden = YES;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    [self CreateNavgationView];
    
    
}

-(void)CreateNavgationView{
    
    self.navgationView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navgationView.frame = ccr(0, 0, 1024, Nav_HEIGHT);
    self.navgationView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
    self.navgationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    self.navgationView.backgroundColor = [UIColor colorWithRed:4/255.0 green:126/255.0 blue:163/255.0 alpha:1.0];
    [self.view addSubview:self.navgationView];
    self.BackBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.BackBt.frame = ccr(110,(Nav_HEIGHT-31)/2 -10, 50, 50);

    self.BackBt.titleLabel.font = [UIFont systemFontOfSize:28];
    //[button setTitle:@"back" forState:UIControlStateNormal];
    [self.BackBt setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [self.BackBt setTitleColor:[UIColor colorWithRed:95/255.0 green:158/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
    [self.BackBt addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navgationView addSubview:self.BackBt];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:ccr(VIEW_W(self.view)/2-125, self.navgationView.frame.size.height/2-35, 250, 100)];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
     self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.navgationView addSubview:self.titleLabel];
    
    self.lognBT = [[UIImageView  alloc] initWithFrame:ccr(SCREEN_WIDTH-80, (Nav_HEIGHT-45)/2, 53, 53)];
    self.lognBT.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.navgationView addSubview:self.lognBT];
    self.lognBT.image = [UIImage imageNamed:@"logo.png"];
  //  [self.lognBT setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    self.lognBT.hidden = YES;
    
    
}

-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
    
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
