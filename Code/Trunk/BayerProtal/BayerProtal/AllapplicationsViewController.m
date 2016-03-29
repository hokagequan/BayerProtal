//
//  AllapplicationsViewController.m
//  BayerProtal
//
//  Created by admin on 14-10-10.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "AllapplicationsViewController.h"
#import "AppTableViewCell.h"
#import "appCellView.h"
#import "AppDetailViewController.h"


#import "LocalSqlManger.h"
#import "IpaRequestManger.h"
#import "AppDelegate.h"

#import "HenView.h"
#import "ShuView.h"

#define HEIGHT_SPACE 10;
#define HEIGHT_BUTTON 100;

@interface AllapplicationsViewController ()
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIView *navgationView;
@property (nonatomic,strong)UIImageView *lognBT;

@end

@implementation AllapplicationsViewController
{
    NSDictionary * allAppDic;
    NSArray * letterList;
    BOOL isHen;
    NSString *appKey;
    NSString *firstLetterKey;
    NSMutableArray *tempLetterList;
    UIView *aphaView;
}


@synthesize BYlistTableview;
@synthesize BYsearchDisplayCon;
@synthesize appSearchBar;
@synthesize alertTableView;
@synthesize alphaView;
@synthesize tempArray;


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
    
    
    [self createNavView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTheLanguage:) name:@"changeLanguage" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allApprefreshAll:) name:@"refreshAll" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refershAppOrOpen:) name:@"refershAppOrOpen" object:nil];
    
    [self loadData];
    
    //moreButtonAction
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreButtonDoSomething:) name:@"moreButtonAction" object:nil];

    appSearchBar = [[UISearchBar alloc] initWithFrame:ccr(3*VIEW_W(self.view)/5,Nav_HEIGHT/2-35, VIEW_W(self.view)*0.3, 100)];
    appSearchBar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    appSearchBar.backgroundColor = [UIColor clearColor];
    for (UIView *view in appSearchBar.subviews) {
        
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }    appSearchBar.tintColor = [UIColor lightGrayColor];
	appSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	appSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    // appSearchBar.keyboardType = UIKeyboardTypeDefault;
    appSearchBar.showsScopeBar = NO;
    appSearchBar.showsCancelButton = NO;
    appSearchBar.delegate = self;
    if ([UItool isChinese]==YES) {
        appSearchBar.placeholder = @"搜索应用";
    }
    else{
        appSearchBar.placeholder = @"Search App";
    }
    //[appSearchBar sizeToFit];
    [self.navgationView addSubview:appSearchBar];
    //[self.view addSubview:appSearchBar];
    
    
    
    //BYlistTableview.backgroundColor = [UIColor redColor];
    
    
    
    BYlistTableview = [[UITableView alloc]initWithFrame:ccr(TabBar_WIDTH, Nav_HEIGHT, SCREEN_WIDTH-TabBar_WIDTH, SCREEN_HEIGHT-Nav_HEIGHT) style:UITableViewStylePlain];
    // BYlistTableview.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    BYlistTableview.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    BYlistTableview.delegate = self;
    BYlistTableview.dataSource = self;
    BYlistTableview.hidden = YES;
    [self.view addSubview:BYlistTableview];
    
    alertTableView = [[UITableView alloc]initWithFrame:ccr(TabBar_WIDTH, Nav_HEIGHT, 1024-TabBar_WIDTH, 768-Nav_HEIGHT) style:UITableViewStylePlain];
    // BYlistTableview.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    alertTableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    alertTableView.delegate = self;
    alertTableView.dataSource = self;
    
    [self.view addSubview:alertTableView];
    
    aphaView = [[UIView alloc] initWithFrame:ccr(0, Nav_HEIGHT, VIEW_W(self.view), VIEW_H(self.view)-Nav_HEIGHT)];
    aphaView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    aphaView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    aphaView.hidden = YES;
    [self.view addSubview:aphaView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outDoSomethings:)];
    [aphaView addGestureRecognizer:tap];
    
    
    [alertTableView clearLine];
    [BYlistTableview clearLine];
}
-(void)refershAppOrOpen:(id)sender
{
    [alertTableView reloadData];
}

-(void)outDoSomethings:(id)sender
{
    aphaView.hidden = YES;
    appSearchBar.text = @"";
     [self searchBar:appSearchBar textDidChange:@""];
    [appSearchBar resignFirstResponder];
    
    // [aphaView removeFromSuperview];
}

-(void)createNavView
{
    self.navgationView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navgationView.frame = ccr(0, 0, 1024, Nav_HEIGHT);
    self.navgationView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
    self.navgationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    self.navgationView.backgroundColor = [UIColor colorWithRed:4/255.0 green:126/255.0 blue:163/255.0 alpha:1.0];
    [self.view addSubview:self.navgationView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = ccr(110,(Nav_HEIGHT-31)/2 -10, 50, 50);
    button.titleLabel.font = [UIFont systemFontOfSize:28];
    //[button setTitle:@"back" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:95/255.0 green:158/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navgationView addSubview:button];

    self.titleLabel = [[UILabel alloc] initWithFrame:ccr(SCREEN_WIDTH/2-100, self.navgationView.frame.size.height/2-50, 200, 100)];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.navgationView addSubview:self.titleLabel];

    self.lognBT = [[UIImageView  alloc] initWithFrame:ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-53)/2, 53, 53)];
    self.lognBT.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    [self.navgationView addSubview:self.lognBT];
    self.lognBT.image = [UIImage imageNamed:@"logo.png"];
    self.titleLabel.frame = ccr(SCREEN_WIDTH/2-100, self.navgationView.frame.size.height/2-35, 200, 100);
   self. lognBT.frame = ccr(1024-80, (Nav_HEIGHT-45)/2, 53, 53);
    self.lognBT.hidden = YES;


}
-(void)loadData
{
    if ([UItool isChinese]==YES) {
        self.titleLabel.text = @"所有应用";
        appSearchBar.placeholder = @"搜索应用";
    }
    else{
        self.titleLabel.text = @"All Applications";
         appSearchBar.placeholder = @"Search App";
    }
    tempLetterList = [NSMutableArray array];
    if ([UItool isChinese]==YES) {
        appKey = @"appCname";
        firstLetterKey= @"chineseFirstLetter";
    }
    else{
        appKey = @"appEname";
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


-(void)changeTheLanguage:(NSNotification *)noti
{
    [self loadData];
    [alertTableView reloadData];
    [BYlistTableview reloadData];
}

-(void)allApprefreshAll:(NSNotification *)noti
{
    [self loadData];
    
    [alertTableView reloadData];
    [BYlistTableview reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
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
        alertTableView.hidden = NO;
        BYlistTableview.hidden = YES;
        [alertTableView reloadData];
    }
//    else if ([searchText length]==1 &&[self isValidateLetter:searchText])
//    {
//        NSArray *arr = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:firstLetterKey and:[searchText uppercaseString]];
//        tempArray = [NSMutableArray arrayWithArray:arr];
//        alertTableView.hidden = YES;
//        BYlistTableview.hidden = NO;
//        [BYlistTableview reloadData];
//    }
    else {
        alertTableView.hidden = YES;
        BYlistTableview.hidden = NO;
        NSRange range;
        alphaView.hidden = YES;
        NSArray * array = [LocalSqlManger selectAllApp];
        for (BYapp *str  in array){
            NSArray *arr = [str.appCname componentsSeparatedByString:@"("];
            NSString *nowCname = arr[0];
            range = [ nowCname rangeOfString:name];
            if (range.location != NSNotFound){
                [tempArray addObject:str];
                
            }
            else{
                NSArray *arrw = [str.appEname componentsSeparatedByString:@"("];
                NSString *nowEname = arrw[0];
                range = [[nowEname uppercaseString]  rangeOfString:[name uppercaseString]];
                if (range.location != NSNotFound){
                    [tempArray addObject:str];
                    
                }
            }
        }
        alertTableView.hidden = YES;
        BYlistTableview.hidden = NO;
        [BYlistTableview reloadData];
        
        
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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //横竖屏处理
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
        
        // appSearchBar.frame = ccr(3*SCREEN_HEIGHT/5,Nav_HEIGHT/2-50, 0.3*SCREEN_HEIGHT, 100);
        isHen = YES;
        
        //self.lognBT.frame = ccr(SCREEN_HEIGHT-73, (Nav_HEIGHT-63)/2, 53, 53);
       // self.titleLabel.frame = ccr(SCREEN_HEIGHT/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
        
        //[BYlistTableview reloadData];
        [alertTableView reloadData];
        
        
    }else
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
        // appSearchBar.frame = ccr(3*SCREEN_WIDTH/5,Nav_HEIGHT/2-50, 0.3*SCREEN_WIDTH, 100);
        
        isHen = NO;
        
       // self.lognBT.frame = ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-63)/2, 63, 63);
       // self.titleLabel.frame = ccr(SCREEN_WIDTH/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
        
        //[BYlistTableview reloadData];
        [alertTableView reloadData];
        
    }
    
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationPortrait:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
//            self.lognBT.frame = ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-63)/2, 63, 63);
//            self.titleLabel.frame = ccr(SCREEN_WIDTH/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
            isHen = NO;
            [BYlistTableview reloadData];
            [alertTableView reloadData];
            
            
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            //home健在上
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
//            self.lognBT.frame = ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-63)/2, 63, 63);
//            self.titleLabel.frame = ccr(SCREEN_WIDTH/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
            
            isHen = NO;
            [BYlistTableview reloadData];
            [alertTableView reloadData];
            
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            //home健在左
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
//            self.lognBT.frame = ccr(SCREEN_HEIGHT-73, (Nav_HEIGHT-63)/2, 63, 63);
//            self.titleLabel.frame = ccr(SCREEN_HEIGHT/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
            
            isHen = YES;
            [BYlistTableview reloadData];
            [alertTableView reloadData];
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
//            self.lognBT.frame = ccr(SCREEN_HEIGHT-73, (Nav_HEIGHT-63)/2, 63, 63);
//            self.titleLabel.frame = ccr(SCREEN_HEIGHT/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
            
            
            isHen = YES;
            [BYlistTableview reloadData];
            [alertTableView reloadData];
            
            //home健在右
            break;
        default:
            break;
            
            
    }
}

-(void)moreButtonDoSomething:(NSNotification *)noti
{
    //点击more按钮执行事件
    AppDetailViewController *appDetail = [[AppDetailViewController alloc] init];
    UIButton *button = noti.object;
    appDetail.appId = [NSString stringWithFormat:@"%ld", (long)button.tag];
    //[self presentViewController:appDetail animated:NO completion:nil];
    [self.navigationController pushViewController:appDetail animated:NO];
    
    
}
-(void)changeTheLuange:(NSNotification *)noti
{
    if ([UItool isChinese]==YES) {
        appSearchBar.placeholder = @"搜索APP";
    }
    else{
        appSearchBar.placeholder = @"Search App";
    }
    [alertTableView reloadData];
    [BYlistTableview reloadData];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSInteger m = (tableView==alertTableView)?[tempLetterList count]:1;
    return m;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView==alertTableView) {
        return [tempLetterList objectAtIndex:section];
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return tempLetterList;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tempArray count]!=0&&(tableView = BYlistTableview)) {
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
    
    
    
    else if (tableView == alertTableView&&isHen==YES) {
        
        int k = [tempLetterList count];
        for (int i =0; i<k; i++) {
            NSArray * array = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:firstLetterKey and:[tempLetterList objectAtIndex:i]];
            
            if ([indexPath section]==i) {
                
                int m = 0 ;
                if ([array count]%3==0) {
                    m=[array count] ;
                }
                else if ([array count]%3==1) {
                    m=[array count]+2;
                }
                else if ([array count]%3==2) {
                    m=[array count]+1;
                }
                else if ([array count]==0){
                    return 0;
                }
                //CGFloat h = m*100/3+(m/3+1)*20;
                CGFloat h = m/3*160;
                return h;
                
                
                
            }
            
        }
    }
    else if (tableView == alertTableView&&isHen==NO){
        int k = [tempLetterList count];
        for (int i =0; i<k; i++) {
            NSArray * array = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:firstLetterKey and:[tempLetterList objectAtIndex:i]];
            
            if ([indexPath section]==i) {
                int m = ([array count]%2 !=0)?1:0;
                CGFloat h = ([array count]+m)*100/2+(([array count]+m)/2+1)*20;
                return h;
            }
            
        }
    }
    return 0;
    
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * inderfiter = @"appCellInder";
    AppTableViewCell * cell = (AppTableViewCell *)[tableView dequeueReusableCellWithIdentifier:inderfiter];
    if (cell == nil) {
        cell = [[AppTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inderfiter];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
        
    }
    
    if([tempArray count]!=0&&tableView==BYlistTableview){
        [cell initWithArray:tempArray andIshen:isHen];
        return cell;
    }
    
    else if([tempArray count]==0&&tableView == BYlistTableview){
        
        UITableViewCell * cell = [[UITableViewCell alloc] init];
        return cell;
        
    }
    
    
    else if (tableView==alertTableView)
    {
        
        NSArray* arry2 = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:firstLetterKey and:[tempLetterList objectAtIndex:[indexPath section]]];
        
        [cell initWithArray:arry2 andIshen:isHen];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    alphaView.hidden = YES;
}


- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    alphaView.hidden = YES;
    appSearchBar.text = @"";
    BYlistTableview.hidden = YES;
}

- (UIWindow *)systemWindow {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    
    return window;
}

-(void)backAction:(id)sender
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
