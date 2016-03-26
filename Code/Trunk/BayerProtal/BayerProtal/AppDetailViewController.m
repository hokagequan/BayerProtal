//
//  AppDetailViewController.m
//  BayerProtal
//
//  Created by admin on 14-10-17.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "AppDetailViewController.h"
#import "appCellView.h"
#import "LocalSqlManger.h"
#import "BYloadView.h"
#import "DXAlertView.h"
#import "JEShowImageView.h"


@interface AppDetailViewController ()
{
    UIButton *imaButton;
    UIButton *openButton;
    UILabel * desLabel;
    UIScrollView * imaScrollView;
    UILabel *detaiLabel;
    BYapp * myApp;
    UILabel *nameLabel;
}
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIView *navgationView;
@property (nonatomic,strong)UIImageView *lognBT;
@end

@implementation AppDetailViewController

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTheLanguage:) name:@"changeLanguage" object:nil];
     [self createNavView];
     [self createAppView];
    
    [self createScrollView];
    [self loadData];
    
}
-(void)changeTheLanguage:(NSNotification *)noti
{
    [self loadData];
}

-(void)createNavView
{
    self.navgationView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navgationView.frame = ccr(0, 0, 1024, Nav_HEIGHT);
    self.navgationView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
    self.navgationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    self.navgationView.backgroundColor = [UIColor colorWithRed:4/255.0 green:126/255.0 blue:163/255.0 alpha:1.0];
    [self.view addSubview:self.navgationView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = ccr(110,(Nav_HEIGHT-31)/2 -10, 50, 50);
    button.titleLabel.font = [UIFont systemFontOfSize:28];
    //[button setTitle:@"back" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:95/255.0 green:158/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(appDetailBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.navgationView addSubview:button];

    self.titleLabel = [[UILabel alloc] initWithFrame:ccr(self.navgationView.frame.size.width/2-100, self.navgationView.frame.size.height/2-50, 200, 100)];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.navgationView addSubview:self.titleLabel];

    self.lognBT = [[UIImageView  alloc] initWithFrame:ccr(1024-80, (Nav_HEIGHT-45)/2, 53, 53)];
    self.lognBT.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.navgationView addSubview:self.lognBT];
    self.lognBT.image = [UIImage imageNamed:@"logo.png"];
    self.lognBT.hidden = YES;

}


-(void)loadData
{
    
    if ([UItool isChinese]==YES) {
        self.titleLabel.text = @"应用详情";
        nameLabel.text = @"应用描述:";
    }
    else{
        self.titleLabel.text = @"Applications Detail";
        nameLabel.text = @"Decription:";
    }
    
    //通过appId获取详情数据
    NSArray * array = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:@"appId" and:self.appId];
    NSArray *imaList = [LocalSqlManger selectClass:@"AppImageList" ThroughTheKey:@"appId" and:self.appId];
    if ([array count]!=0) {
        myApp =[array objectAtIndex:0];
        if ([UItool isChinese]==YES) {
            desLabel.text = myApp.appCname;
            detaiLabel.text = myApp.appCDescription;
            [openButton setBackgroundImage:[UIImage imageNamed:@"open_btn_cn.png"] forState:UIControlStateNormal];
            
        }
        else{
            desLabel.text = myApp.appEname;
            detaiLabel.text = myApp.appEDescription;
            [openButton setBackgroundImage:[UIImage imageNamed:@"open_btn.png"] forState:UIControlStateNormal];
            
        }
        if (desLabel.text.length<=8) {
            desLabel.textAlignment = NSTextAlignmentCenter;
            desLabel.frame = ccr(VIEW_X+5+imaButton.frame.size.width+3, VIEW_Y+15, 150, 40);
        }
//        [imaButton sd_setBackgroundImageWithURL:[NSURL URLWithString:myApp.appIma] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"faq.png"]];
        [imaButton sd_setBackgroundImageWithURL:[NSURL URLWithString:myApp.appIma] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"faq.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (![UItool APCheckIfAppInstalled2:myApp.appUrl]) {
                UIImage *image= [UItool getGrayImage:imaButton.currentBackgroundImage];
                [imaButton setBackgroundImage:image forState:UIControlStateNormal];
            }
        }];
        
        
    }
    
    // NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    //detaiLabel.textAlignment = NSTextAlignmentCenter;
    detaiLabel.numberOfLines = 0;
    detaiLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    CGFloat h = [detaiLabel.text stringSizeWithFont:detaiLabel.font size:ccs(1024-VIEW_X-10, 10000) breakmode: NSLineBreakByWordWrapping].height;
    // NSDictionary *attributes = @{NSFontAttributeName:detaiLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    //CGSize size = [detaiLabel.text boundingRectWithSize:CGSizeMake(VIEW_WIDTH_HEN-10, VIEW_HEIGHT_HEN-detaiLabel.frame.origin.y) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    
    if ([imaList count]!=0) {
        for (int i=0; i<[imaList count]; i++) {
            AppImageList *appImaList = [imaList objectAtIndex:i];
            UIImageView *imaView = [[UIImageView alloc] initWithFrame:ccr((imaScrollView.frame.size.width/2-10)*i,5,(imaScrollView.frame.size.width/2-15), imaScrollView.frame.size.height-10)];
            [imaView sd_setImageWithURL:[NSURL URLWithString:appImaList.imgPath] placeholderImage:[UIImage imageNamed:@"faq.png"]];
            [imaScrollView addSubview:imaView];
            imaView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
            [imaView addGestureRecognizer:tapGesture];
        }
        [imaScrollView setContentSize:CGSizeMake(imaScrollView.frame.size.width/2*[imaList count], 200)];
        [self.view addSubview:imaScrollView];
        detaiLabel.frame = ccr(VIEW_X+10, nameLabel.frame.size.height+nameLabel.frame.origin.y+10,1024-VIEW_X-10, h);
    }
    else{
        nameLabel.frame = ccr(VIEW_X, imaButton.frame.size.height+VIEW_Y+25,100, 30);
        detaiLabel.frame = ccr(VIEW_X+10, nameLabel.frame.size.height+nameLabel.frame.origin.y+20,1024-VIEW_X-10, h);
    }
}

- (void)event:(UITapGestureRecognizer *)gesture
{
    [self.view ShowView:gesture.view];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
    
    //横竖屏处理
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [self henOfView];
        
    }
    else
    {
        [self shuOfView];
        
    }
    
    
    
    // NSArray *imaArray = [LocalSqlManger selectClass:@"AppImageList" ThroughTheKey:@"appId" and:self.appId];
    // AppImageList *imagelist = [imaArray objectAtIndex:0];
    
    
    
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationPortrait:
            [self shuOfView];
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            //home健在上
            [self shuOfView];
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            //home健在左
            [self henOfView];
            
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            [self henOfView];
            
            //home健在右
            break;
        default:
            break;
            
            
    }
}

-(void)henOfView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
    //imaScrollView.frame = ccr(VIEW_X, imaButton.frame.size.height+VIEW_Y+5,VIEW_WIDTH_HEN, 200);
    self.lognBT.frame = ccr(1024-80, (Nav_HEIGHT-45)/2, 53, 53);
    self.titleLabel.frame = ccr(self.navgationView.frame.size.width/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
    
    
}

-(void)shuOfView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
    //imaScrollView.frame = ccr(VIEW_X, imaButton.frame.size.height+VIEW_Y+5,VIEW_WIDTH_SHU, 200);
    self.lognBT.frame = ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-63)/2, 63, 63);
    self.titleLabel.frame = ccr(SCREEN_WIDTH/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
    
}



-(void)createAppView
{
    imaButton = [[UIButton alloc] initWithFrame:ccr(VIEW_X+5, VIEW_Y+15, 80, 80)];
       imaButton.layer.cornerRadius = 15;
    //    self.imaButton.clipsToBounds = YES;
       imaButton.layer.masksToBounds = YES;
    [imaButton addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
    desLabel = [[UILabel alloc] initWithFrame:ccr(VIEW_X+10+imaButton.frame.size.width+3, VIEW_Y+15, 260, 40)];
    //desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.numberOfLines = 0;
    openButton = [[UIButton alloc] initWithFrame:ccr(VIEW_X+5+imaButton.frame.size.width+3, VIEW_Y+15+50, 150, 30)];
    [openButton addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imaButton];
    [self.view addSubview:desLabel];
    [self.view addSubview:openButton];
    
}

-(void)createScrollView
{
    //[self.BackBt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    imaScrollView = [[UIScrollView alloc] initWithFrame:ccr(VIEW_X, imaButton.frame.size.height+VIEW_Y+32,SCREEN_WIDTH-2*VIEW_X, 200)];
    imaScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //imaScrollView.backgroundColor = [UIColor redColor];
    imaScrollView.scrollEnabled = YES;
    //imaScrollView.delaysContentTouches=YES;
    
    
    nameLabel = [[UILabel alloc] initWithFrame:ccr(VIEW_X+20, imaButton.frame.size.height+VIEW_Y+235,VIEW_WIDTH_HEN-10, 50)];
    [self.view addSubview:nameLabel];
    
    detaiLabel = [[UILabel alloc] initWithFrame:ccr(VIEW_X+10, nameLabel.frame.size.height+nameLabel.frame.origin.y+10,VIEW_WIDTH_HEN-10, 200)];
    [self.view addSubview:detaiLabel];
    
    
}


-(void)openAction:(id)sender
{
    
    NSString *str;NSString *std;NSString *stf;//NSString *stm;
    
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
    
    NSRange range = [myApp.appUrl rangeOfString:@"http"];
    if (range.location==NSNotFound) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",myApp.appUrl]]])
        {
            [JEUtits addOneClickWithAppEntity:myApp];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",myApp.appUrl]]];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:std delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }
    }
    
    else if(range.location!=NSNotFound){
       
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:myApp.appUrl]];
            [JEUtits addOneClickWithAppEntity:myApp];
        
    }
    
}

-(void)appDetailBack:(id)sender
{
    //[self dismissViewControllerAnimated:YES completion:nil];
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
