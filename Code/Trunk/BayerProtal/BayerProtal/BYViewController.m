//
//  BYViewController.m
//  BayerProtal
//
//  Created by admin on 14-9-24.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "BYViewController.h"

#import "AllapplicationsViewController.h"


#import "UIButton+BYbuttonTitle.h"
#import "tabButton.h"
#import "MenuButton.h"
#import "TypeViewController.h"
#import "AppTableViewCell.h"
#import "AppDetailViewController.h"
#import "DXAlertView.h"
#import "buttonTableViewCell.h"

#import "IpaRequestManger.h"
#import "CustomAlert.h"


//按钮间距

#define SPACE_X VIEW_WIDTH_HEN/15
#define SPACE_Y VIEW_HEIGHT_HEN/18
#define SPACE_X_SHU VIEW_WIDTH_SHU/12
#define SPACE_Y_SHU VIEW_HEIGHT_HEN*4/80

#define BT_WIDTH SCREEN_WIDTH*0.24
#define BT_SPACE_Y   SCREEN_HEIGHT*0.02
#define  btWidth  SCREEN_WIDTH*0.176;

@interface BYViewController ()<UITableViewDelegate,UITableViewDataSource,catageryDelegate,BYTabBardelegate>

@end


@implementation BYViewController
{
    UIView *navView;
    MenuButton *FaBut;
    MenuButton *communicationBut;
    MenuButton *favourateBut;
    MenuButton *msBut;
    MenuButton *HRBut;
    MenuButton *otherBut;
    MenuButton *allAppBut;
    
    UILabel *titleLabel;
    
    UIImageView *lognBT;
    
    UISearchBar *appSearchBar;
    UITableView *listTableView;
    NSMutableArray * tempArray;
    
    UIView *viewHen;
    UIView *viewShu;
    
    NSArray * catageryList;
    BOOL isHen;
    
    NSArray * letterList;
    NSString *firstLetterKey;
    NSMutableArray *tempLetterList;
    
    UIView *aphaView;

    
    
    
}

@synthesize tabView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    // Custom initialization categories
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreButtonDoSomething:) name:@"moreButtonAction" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"moreButtonAction" object:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheLuange:) name:@"changeLanguage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BYviewRefreshAll:) name:@"refreshAll" object:nil];
   
    if ([UItool isConnectionAvailable]) {
        [BYloadView loadState:YES];//////////////////////////
        __block NSString *std;
        __block int k=0;
         __block int p =0;
        [IpaRequestManger refreshContents:^(int n,NSString *str) {
           // NSLog(@"====%d==%@",n,str);
            if (![str isEqualToString:@"no"]) {
                std=str;
            }
            if (n!=0) {
                k=n;
            }
//            if (k%3==0) {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAll" object:self userInfo:nil];
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"refershMessage" object:self];
//                //[self relo];
//                [BYloadView loadState:NO];
//            }
            
            if ((k%3==0&&![std isEqualToString:@"failed"])||(k%3==0&&[std isEqualToString:@"noImage"])) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAll" object:self userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refershMessage" object:self];
                [BYloadView loadState:NO];
            }
            
            else if (k%3 ==0 && [std isEqualToString:@"failed"]&&p!=1){
                p=1;
                if ([UItool isChinese]==YES) {
                    std = @"加载失败，请确保网络处于连接状态且VPN已打开。";
                    str = @"提示";
                }
                else{
                    std = @"Loading failed, please ensure the internet and VPN are connected.";
                    str = @"Alert";
                }
                [BYloadView loadState:NO];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:std delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];

            }
             NSLog(@"====%d====std===%@",k,std);
        }];
            }
    [self navView];
    [self lodaCatagoryDate];
    self.view.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    [self makeTableView];
    
    aphaView = [[UIView alloc] initWithFrame:ccr(0, Nav_HEIGHT, VIEW_W(self.view), VIEW_H(self.view)-Nav_HEIGHT)];
    aphaView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    aphaView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    aphaView.hidden = YES;
    [self.view addSubview:aphaView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outDoSomethings:)];
    [aphaView addGestureRecognizer:tap];
    
    
}




-(void)outDoSomethings:(id)sender
{
    aphaView.hidden = YES;
    appSearchBar.text = @"";
    [self searchBar:appSearchBar textDidChange:@""];
    listTableView.hidden = YES;
    [appSearchBar resignFirstResponder];
    
   // [aphaView removeFromSuperview];
}
-(void)lodaCatagoryDate
{
    if ([UItool isChinese]==YES) {
        titleLabel.text = @"应用";
    }
    else{
    titleLabel.text = @"Application";
    }
    catageryList = [LocalSqlManger selectAllCatagery];
    
    
    tempLetterList = [NSMutableArray array];
    if ([UItool isChinese]==YES) {
        
        firstLetterKey= @"chineseFirstLetter";
    }
    else{
        
        firstLetterKey =@"englishFirstLetter";
    }
    
    letterList = [LocalSqlManger selectAllFirstLetter];
    for (int i=0; i<[letterList count]; i++) {
        NSArray *arr = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:firstLetterKey and:[letterList objectAtIndex:i]];
        if ([arr count]!=0) {
            [tempLetterList addObject:[letterList objectAtIndex:i]];
        }
    }
    
    

}

-(void)changeTheLuange:(NSNotification *)noti
{
    if ([UItool isChinese]==YES) {
        appSearchBar.placeholder = @"搜索应用";
            }
    else{
        appSearchBar.placeholder = @"Search App";
            }
    [self lodaCatagoryDate];
    [self.contentTableView reloadData];
    
}

-(void)BYviewRefreshAll:(NSNotification *)noti
{
    [self lodaCatagoryDate];
    [self.contentTableView reloadData];
}

-(void)makeTableView
{
    self.contentTableView = [[UITableView alloc] initWithFrame:ccr(TabBar_WIDTH, Nav_HEIGHT, 1024-TabBar_WIDTH, 768-Nav_HEIGHT) style:UITableViewStylePlain];
    self.contentTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.view addSubview:self.contentTableView];
    
    
    listTableView = [[UITableView alloc]initWithFrame:ccr(TabBar_WIDTH, Nav_HEIGHT, 1024-TabBar_WIDTH, 768-Nav_HEIGHT) style:UITableViewStylePlain];
    listTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    listTableView.delegate = self;
    listTableView.dataSource = self;
    listTableView.hidden = YES;
    [self.view addSubview:listTableView];
    
    
    
    
}
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    aphaView.hidden = NO;
//}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [appSearchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if (searchBar.text.length) {
        aphaView.hidden = YES;
    }else{
        aphaView.hidden = NO;
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    //    searchBar.text = @"";
    //    [self searchBar:searchBar textDidChange:@""];
    aphaView.hidden = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    aphaView.hidden = YES;
    NSString *name = searchText;
    tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    if (![searchText length]) {
        aphaView.hidden = NO;
        listTableView.hidden = YES;
    }
    
//    else if ([searchText length]==1&&[self isValidateLetter:searchText])
//    {
//        NSArray *arr = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:firstLetterKey and:[searchText uppercaseString]];
//        tempArray = [NSMutableArray arrayWithArray:arr];
//       
//        listTableView.hidden = NO;
//        [listTableView reloadData];
//
//        
//    }
    
    else {
        NSRange range;
        NSArray * array = [LocalSqlManger selectAll];
        for (BYapp *str  in array){
            range = [str.appCname  rangeOfString:name];
            if (range.location != NSNotFound){
                [tempArray addObject:str];
                
            }
            else{
                range = [[str.appEname uppercaseString]  rangeOfString:[name uppercaseString]];
                if (range.location != NSNotFound){
                    [tempArray addObject:str];
                    
                }
            }
        }
        listTableView.hidden = NO;
        [listTableView reloadData];
        
        
    }
    if (!tempArray.count) {
        aphaView.hidden = NO;
    }else{
        aphaView.hidden = YES;
    }
    
}

- (BOOL)isValidateLetter:(NSString *)letter
{
    NSString *emailCheck =@"[A-Za-z]{1}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:letter];
}


-(void)viewOfHen
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
    
    
    
}
-(void)viewOfShu
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //横竖屏处理
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        isHen = YES;
        [self viewOfHen];
        [_contentTableView reloadData];
        [listTableView reloadData];
        
        
    }else
    {
        isHen = NO;
        [self viewOfShu];
        [_contentTableView reloadData];
        [listTableView reloadData];
        
        
        
    }
    
}


-(void)navView{
    
    navView = [[UIView alloc] initWithFrame:CGRectZero];
    navView.frame = ccr(0, 0, self.view.frame.size.width, Nav_HEIGHT);
    navView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    navView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    navView.backgroundColor = [UIColor colorWithRed:4/255.0 green:126/255.0 blue:163/255.0 alpha:1.0];
    [self.view addSubview:navView];
//    lognBT = [[UIImageView alloc] initWithFrame:ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-53)/2, 53, 53)];
//    lognBT.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
//    [navView addSubview:lognBT];
//    lognBT.image = [UIImage imageNamed:@"logo.png"];
    //[lognBT setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    
    appSearchBar = [[UISearchBar alloc] initWithFrame:ccr(3*SCREEN_WIDTH/5+90,Nav_HEIGHT/2-35, SCREEN_WIDTH*0.3, 100)];
    appSearchBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
    appSearchBar.backgroundColor = [UIColor clearColor];
    if ([UItool isChinese]==YES) {
        appSearchBar.placeholder = @"搜索应用";
    }
    else{
        appSearchBar.placeholder = @"Search App";
    }
    for (UIView *view in appSearchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    appSearchBar.tintColor = [UIColor lightGrayColor];
	appSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	appSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    appSearchBar.showsScopeBar = NO;
    appSearchBar.showsCancelButton = NO;
    appSearchBar.delegate = self;
    [navView addSubview:appSearchBar];
    
    titleLabel = [[UILabel alloc] initWithFrame:ccr(SCREEN_WIDTH/2-100, navView.frame.size.height/2-35, 200, 100)];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:25];
    [navView addSubview:titleLabel];
    [self.view addSubview:navView];
    
    
}



-(void)goToTheCategery:(id )sender
{
    UIButton *button = sender;
    NSLog(@"%d",button.tag);

    TypeViewController *typeView = [[TypeViewController alloc] init];
    AllapplicationsViewController *allAppView = [[AllapplicationsViewController alloc] init];
    if (button.tag==10000) {
          [self.navigationController pushViewController:allAppView animated:NO];
    }
    else{
        typeView.AppCategoryId = [NSString stringWithFormat:@"%d",button.tag];
        [self.navigationController pushViewController:typeView animated:NO];
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tempArray count]!=0&&tableView==listTableView) {
        int k = [tempArray count];
        for (int i =0; i<k; i++) {
            
            if (isHen==YES) {
                int m = ([tempArray count]%2 !=0)?1:0;
                CGFloat h = ((([tempArray count]+m)*100/2+(([tempArray count]+m)/2+1))>(SCREEN_WIDTH-Nav_HEIGHT))?([tempArray count]+m)*100/2+(([tempArray count]+m)/2+1)*20:SCREEN_WIDTH-Nav_HEIGHT;
                return h;
            }
            
            else {
                int m = 0 ;
                if ([tempArray count]%3==0) {
                    m=[tempArray count];
                }
                else if ([tempArray count]%3==1) {
                    m=[tempArray count]+2;
                }
                else if ([tempArray count]%3==2) {
                    m=[tempArray count]+1;
                }
                CGFloat h = ((([tempArray count]+m)*100/3+(([tempArray count]+m)/3+1)*20)>(SCREEN_HEIGHT-Nav_HEIGHT))?([tempArray count]+m)*100/3+(([tempArray count]+m)/3+1)*20:SCREEN_HEIGHT-Nav_HEIGHT;
                return h;
            }
            
            
            
            
        }
        
        
    }
    if (tableView==_contentTableView) {
        int n = [self getNum:[catageryList count]];
        CGFloat h;
        if (isHen==YES) {
            h =SCREEN_WIDTH-Nav_HEIGHT+(BT_WIDTH+BT_SPACE_Y)*n;
        }
        else{
            h=(n>3)?(SCREEN_HEIGHT-Nav_HEIGHT+(SCREEN_WIDTH*0.176+BT_SPACE_Y)*n):(SCREEN_HEIGHT-Nav_HEIGHT);
            
        }
    
        return h;
    }
    return 0;
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   if([tempArray count]!=0&&tableView==listTableView){
    static NSString * inderfiter = @"appCellInder";
    AppTableViewCell * cell = (AppTableViewCell *)[tableView dequeueReusableCellWithIdentifier:inderfiter];
    
    if (cell == nil) {
        cell = [[AppTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inderfiter];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
        
    }
    
    [cell initWithArray:tempArray andIshen:isHen];
    return cell;
}
    if (tableView==_contentTableView) {
        static NSString * btIndertifer=@"btIndentifer";
        buttonTableViewCell *btCell = (buttonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:btIndertifer];
        if (btCell==nil) {
            btCell = [[buttonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:btIndertifer]
            ;
            //btCell.backgroundColor = [UIColor redColor];
            btCell.selectionStyle = UITableViewCellSelectionStyleNone;
            btCell.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
        }
        btCell.delegate = self;
    
        [btCell initWithBtArray:catageryList andIsHen:isHen];
        return btCell;
    }
    
    else {
        UITableViewCell * cell = [[UITableViewCell alloc] init];
        return cell;
    }
    
}

-(int)getNum:(int)num
{
    if ((num-6)%4!=0&&num>6) {
        while ((num-2)%4!=0) {
            num++;
        }
        return (num-6)/4;
    }
    else if (num<6)
    {
        return 0;
    }
    else if((num-6)%4==0&&num>6){
        return (num-6)/4;
    }
    
    return (num-6)/4;
    
}


-(void)moreButtonDoSomething:(NSNotification *)noti
{
    //点击more按钮执行事件
    AppDetailViewController *appDetail = [[AppDetailViewController alloc] init];
    UIButton *button = noti.object;
    appDetail.appId = [NSString stringWithFormat:@"%ld", (long)button.tag];
    [self.navigationController pushViewController:appDetail animated:NO];
    
    
}

- (UIWindow *)systemWindow {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    
    return window;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationPortrait:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
            isHen = NO;
            
            
            [_contentTableView reloadData];
            [listTableView reloadData];
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            //home健在上
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
            
            
            isHen = NO;
            [_contentTableView reloadData];
            [listTableView reloadData];
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            //home健在左
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
            isHen = YES;
            [_contentTableView reloadData];
            [listTableView reloadData];
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
            
            
            isHen = YES;
            
            [_contentTableView reloadData];
            [listTableView reloadData];
            //home健在右
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
// *///FaBut = [self createButtonFrame:ccr(VIEW_X, VIEW_Y+SPACE_Y, 2*VIEW_WIDTH_HEN/5, VIEW_HEIGHT_HEN/4) andTitle:@"Communication" andDescrption:@"Bayer global informations exchange apps" andimageName:@"u46.png" andTag:1];
//communicationBut = [self createButtonFrame:ccr(VIEW_X+VIEW_WIDTH_HEN*2/5+SPACE_X, VIEW_Y+SPACE_Y, VIEW_WIDTH_HEN/4, VIEW_HEIGHT_HEN/4) andTitle:@"Communication" andDescrption:@"Bayer global informations exchange apps" andimageName:@"u46.png" andTag:2];
//favourateBut=[self createButtonFrame:ccr(VIEW_X+VIEW_WIDTH_HEN*2/5+ 2*SPACE_X +VIEW_WIDTH_HEN/4, VIEW_Y+SPACE_Y, VIEW_WIDTH_HEN/4, VIEW_HEIGHT_HEN/4) andTitle:@"Communication" andDescrption:@"Bayer global informations exchange apps" andimageName:@"u46.png" andTag:3];
//msBut=[self createButtonFrame:ccr(VIEW_X, VIEW_Y+2*SPACE_Y+VIEW_HEIGHT_HEN/4, 2*VIEW_WIDTH_HEN/5, VIEW_HEIGHT_HEN/2+SPACE_Y) andTitle:@"Communication" andDescrption:@"Bayer global informations exchange apps" andimageName:@"u46.png" andTag:4];
//HRBut=[self createButtonFrame:ccr(VIEW_X+VIEW_WIDTH_HEN*2/5+SPACE_X, VIEW_Y+2*SPACE_Y+VIEW_HEIGHT_HEN/4, 3*VIEW_WIDTH_HEN/5-20, VIEW_HEIGHT_HEN/4) andTitle:@"Communication" andDescrption:@"Bayer global informations exchange apps" andimageName:@"u46.png" andTag:5];
//otherBut=[self createButtonFrame:ccr(VIEW_X+VIEW_WIDTH_HEN*2/5+SPACE_X, VIEW_Y+3*SPACE_Y+VIEW_HEIGHT_HEN/2, VIEW_WIDTH_HEN/4, VIEW_HEIGHT_HEN/4) andTitle:@"Communication" andDescrption:@"Bayer global informations exchange apps" andimageName:@"u46.png" andTag:6];
//allAppBut=[self createButtonFrame:ccr(VIEW_X+VIEW_WIDTH_HEN*2/5+2*SPACE_X+ VIEW_WIDTH_HEN/4, VIEW_Y+3*SPACE_Y+VIEW_HEIGHT_HEN/2, VIEW_WIDTH_HEN/4, VIEW_HEIGHT_HEN/4) andTitle:@"Communication" andDescrption:@"Bayer global informations exchange apps" andimageName:@"u46.png" andTag:7];

@end
