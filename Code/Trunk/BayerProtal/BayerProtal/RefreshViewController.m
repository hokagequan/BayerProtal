//
//  RefreshViewController.m
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "RefreshViewController.h"

@interface RefreshViewController ()

@end

@implementation RefreshViewController
@synthesize NavView;

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
    [self createNavView];
}

-(void)createNavView
{
    NavView = [[UIView alloc] initWithFrame:ccr(0, 0, self.view.frame.size.height, Nav_HEIGHT)];
    NavView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    NavView.backgroundColor = [UIColor colorWithRed:4/255.0 green:126/255.0 blue:163/255.0 alpha:1.0];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:ccr(NavView.frame.size.width/2-100, NavView.frame.size.height/2-50, 200, 100)];
    titleLabel.text = @"Refresh";
    [NavView addSubview:titleLabel];
    [self.view addSubview:NavView];
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
