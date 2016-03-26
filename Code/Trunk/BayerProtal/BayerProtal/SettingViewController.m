//
//  SettingViewController.m
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "SettingViewController.h"
#import "SetTableViewCell.h"
#import "helpViewController.h"
#import "languageViewController.h"
#import "aboutViewController.h"
#import "BYHomeViewController.h"
#import "BPush.h"

@interface SettingViewController ()
{
    UILabel * titleLabel;
    UIImageView *lognBT;
}

@end

@implementation SettingViewController

@synthesize NavView;
@synthesize firstView;
@synthesize secondView;
@synthesize exitButton;

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLanguage:) name:@"changeLanguage" object:nil];
     self.view.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:0.9];
    // Do any additional setup after loading the view.
    [self createNavView];
    [self createView];
    [self loadData];
    
    
   
}
-(void)loadData
{
    if ([UItool isChinese]==YES) {
        titleLabel.text = @"设置";
        [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    }
    else{
        titleLabel.text = @"Settings";
        [exitButton setTitle:@"Sign Out" forState:UIControlStateNormal];

    }
    
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitButton.backgroundColor = [UIColor colorWithRed:250 / 255. green:43 / 255. blue:52 / 255. alpha:1.0  ];
    exitButton.layer.cornerRadius = 5.0;
    exitButton.layer.masksToBounds = YES;
    
}
-(void)changeLanguage:(NSNotification *)noti
{
    [self loadData];
    [firstView reloadData];
    [secondView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        
        [self henOfSetView];
    }
    else{
        [self shuOfSetView];
        
    }

    
}
-(void)henOfSetView
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];

    firstView.frame = ccr(VIEW_X+80, VIEW_Y+20, VIEW_WIDTH_HEN-20, 250);
    secondView.frame = ccr(VIEW_X+80, firstView.frame.origin.y+firstView.frame.size.height+60, VIEW_WIDTH_HEN-20, 250*2/3);
    exitButton.frame = ccr(VIEW_X+80, secondView.frame.origin.y+secondView.frame.size.height+20, VIEW_WIDTH_HEN-20, 50);
    titleLabel.frame = ccr(SCREEN_WIDTH/2-100, NavView.frame.size.height/2-35, 200, 100);
    lognBT.frame = ccr(1024-80, (Nav_HEIGHT-45)/2, 53, 53);

}

-(void)shuOfSetView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];

    firstView.frame = ccr(VIEW_X+10, VIEW_Y+20, VIEW_WIDTH_SHU-80, 250);
    secondView.frame = ccr(VIEW_X+10, firstView.frame.origin.y+firstView.frame.size.height+60, VIEW_WIDTH_SHU-80, 250*2/3);
    exitButton.frame = ccr(VIEW_X+10, secondView.frame.origin.y+secondView.frame.size.height+20, VIEW_WIDTH_SHU-80, 50);
    titleLabel.frame = ccr(SCREEN_WIDTH/2-100, NavView.frame.size.height/2-50, 200, 100);
    lognBT.frame = ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-53)/2, 53, 53);

}

-(void)createView
{
    firstView = [[UITableView alloc] initWithFrame:CGRectZero];
    firstView.scrollEnabled = NO;
    firstView.layer.borderWidth = 0.1;
    firstView.layer.cornerRadius = 15;
    firstView.layer.masksToBounds = YES;
    firstView.dataSource = self;
    firstView.delegate = self;
    [self.view addSubview:firstView];
    
    secondView = [[UITableView alloc] initWithFrame:CGRectZero];
    secondView.scrollEnabled = NO;
    secondView.layer.borderWidth = 0.1;
    secondView.layer.cornerRadius = 15;
    secondView.layer.masksToBounds = YES;
    secondView.dataSource = self;
    secondView.delegate = self;
    [self.view addSubview:secondView];
    //ccr(VIEW_X+10, 700, VIEW_WIDTH_HEN-20, 50)
    exitButton = [[UIButton alloc] initWithFrame:CGRectZero];
    //exitButton.backgroundColor = [UIColor redColor];
    exitButton.layer.cornerRadius = 10;
    exitButton.layer.masksToBounds = NO;
    //[exitButton setTitle:@"退出" forState:UIControlStateNormal];
    
    [exitButton addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitButton];
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //NSString *str = [appDelegate.appDefaults setObject:@"" forKey:@"userGroup"];
    if (![[appDelegate.appDefaults objectForKey:@"userGroup"] isEqual:@"out"]) {
        exitButton.hidden = NO;
    }
    else{
        exitButton.hidden = YES;
    }
    
    lognBT = [[UIImageView alloc] initWithFrame:CGRectZero];
    [NavView addSubview:lognBT];
    lognBT.image = [UIImage imageNamed:@"logo.png"];
    lognBT.hidden = YES;
   // [lognBT setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    
}

-(void)exitAction:(id)sender
{
    [BPush delTag:[[NSUserDefaults standardUserDefaults] objectForKey:@"userGroup"]];
    
    [ [NSUserDefaults standardUserDefaults] setObject:@"out" forKey:@"userGroup"];
   
    [[NSUserDefaults standardUserDefaults] synchronize];
    AppDelegate * app =  [UIApplication sharedApplication].delegate;
    BYHomeViewController *byHomeView = [[BYHomeViewController alloc] init];
      app.window.rootViewController =  byHomeView;
    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            [self shuOfSetView];
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            //home健在上
            [self shuOfSetView];
            
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            //home健在左
            [self henOfSetView];
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            
            [self henOfSetView];            //home健在右
            break;
        default:
            break;
            
            
    }
}



-(void)createNavView
{
    NavView = [[UIView alloc] initWithFrame:ccr(0, 0, 1024, Nav_HEIGHT)];
    NavView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    titleLabel = [[UILabel alloc] initWithFrame:ccr(NavView.frame.size.width/2-100, NavView.frame.size.height/2-50, 200, 100)];
    titleLabel.textAlignment =NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:25];
    [NavView addSubview:titleLabel];
    [self.view addSubview:NavView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    CGFloat h = (tableView=firstView)?firstView.frame.size.height/3:secondView.frame.size.height/2;
    
    return 250/3.f;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSInteger m = (tableView = firstView)?3:2;
    return m;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indertifer = @"cellIndertifer";
    SetTableViewCell * cell = (SetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:indertifer];
    
    if (cell == nil) {
        cell = [[SetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indertifer];
        
//        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//        cell.selectedBackgroundView.backgroundColor = [UIColor blueColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        if ([indexPath row]==0&&tableView == firstView)
        {
              cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            NSArray *arr1 = @[@"应用语言",@"Language"];
            [cell initFirstTypeWith:arr1];//Application of language
        }
           else if (([indexPath row]==1&&tableView == firstView))
           {    NSArray *arr2 = @[@"新消息提示音",@"Sounds"];
              [cell initSecondTypeWith:arr2 andKey:@"isVoiceOn"];//The new message prompt
           }
             else if (([indexPath row]==2&&tableView == firstView))
             {
                 NSArray *arr3 = @[@"数据自动同步",@"Synchronization"];

                 [cell initSecondTypeWith:arr3 andKey:@"DataSynchronization"];//Data automatic synchronization
             }
        
             else if (([indexPath row]==0&&tableView == secondView))
             {
                 cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                 NSArray *arr4 = @[@"关于",@"About"];

                 [cell initFirstTypeWith:arr4];//About
             }
             else if (([indexPath row]==1&&tableView == secondView))
             {
                   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                 NSArray *arr5 = @[@"使用帮助",@"Help"];
                 [cell initFirstTypeWith:arr5];//Use the help
             }
    
    
          return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == firstView&&[indexPath row]==0) {
        languageViewController *languageView = [[languageViewController alloc]init];
        [self.navigationController pushViewController:languageView animated:NO];
    }
    else if (tableView==secondView)
    {
        if ([indexPath row]==0) {
            aboutViewController *aboutView = [[aboutViewController alloc]init];
            [self.navigationController pushViewController:aboutView animated:NO];
        }
        else{
            helpViewController *helpView = [[helpViewController alloc] init];
            [self.navigationController pushViewController:helpView animated:NO];
        }
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
