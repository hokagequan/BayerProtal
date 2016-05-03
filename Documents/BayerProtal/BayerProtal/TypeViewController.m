//
//  TypeViewController.m
//  BayerProtal
//
//  Created by admin on 14-10-20.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "TypeViewController.h"
#import "TypeHenView.h"
#import "TypeShuView.h"
#import "AppDetailViewController.h"
#import "AppTableViewCell.h"

@interface TypeViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *searchTableView;
    UISearchBar *searchBar;
    NSMutableArray *tempArray;
    NSArray * appList;
    BOOL isHen;
   // UIButton *lognBT;
    NSString *firstLetterKey;
    UIView *aphaView;
  
    
}

@end

@implementation TypeViewController

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
    NSLog(@"%@",self.AppCategoryId);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTheLanguage:) name:@"changeLanguage" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(typeViewRefersh:) name:@"refreshAll" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(typeRefershAppOrOpen:) name:@"refershAppOrOpen" object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(<#selector#>) name:<#(NSString *)#> object:<#(id)#>];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreButtonDoSomething:) name:@"moreButtonAction" object:nil];
    appList = [[NSArray alloc] init];
    
     [self loadDataTypeView];
    
     [self createView];
    // Do any additional setup after loading the view.
    
    aphaView = [[UIView alloc] initWithFrame:ccr(0, Nav_HEIGHT, VIEW_W(self.view), VIEW_H(self.view)-Nav_HEIGHT)];
    aphaView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    aphaView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    aphaView.hidden = YES;
    [self.view addSubview:aphaView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outDoSomethings:)];
    [aphaView addGestureRecognizer:tap];

    
    
}
-(void)typeRefershAppOrOpen:(id)sender
{
    [searchTableView reloadData];
}

-(void)outDoSomethings:(id)sender
{
    aphaView.hidden = YES;
    searchBar.text = @"";
    [self searchBar:searchBar textDidChange:@""];
    [searchBar resignFirstResponder];
    
    // [aphaView removeFromSuperview];
}

-(void)loadDataTypeView
{
    
    NSArray *arr = [LocalSqlManger selectClass:@"AppCatagery" ThroughTheKey:@"catageryId" and:_AppCategoryId];
    if (!arr.count) {
        return;
    }
    AppCatagery *appCatagory = [arr objectAtIndex:0];
    if ([_AppCategoryId isEqualToString:@"2"]) {
        appList = [JEUtits get5CommonApps];
        
        if ([UItool isChinese]==YES) {
            
            self.titleLabel.text = appCatagory.chineseName;
        }
        else{
           self.titleLabel.text = appCatagory.englishName;
        }
    }
    
    else{
        appList = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:@"appCategoryId" and:_AppCategoryId];
        if ([UItool isChinese]==YES) {
             self.titleLabel.text = appCatagory.chineseName;
            firstLetterKey= @"chineseFirstLetter";
            
        }
        else{
            self.titleLabel.text = appCatagory.englishName;
            firstLetterKey =@"englishFirstLetter";
        }
       
    }
    tempArray = [NSMutableArray arrayWithArray:appList];
    

}

-(void)typeViewRefersh:(NSNotification *)noti
{
    [self loadDataTypeView];
    [searchTableView reloadData];

}

-(void)changeTheLanguage:(NSNotification *)noti
{
    if ([UItool isChinese]==YES) {
        searchBar.placeholder = @"搜索应用";
    }
    else{
        searchBar.placeholder = @"Search App";
    }
    [self loadDataTypeView];
    [searchTableView reloadData];
}

-(void)createView
{
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    searchBar.backgroundColor = [UIColor clearColor];
    for (UIView *view in searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }    searchBar.tintColor = [UIColor lightGrayColor];
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //appSearchBar.keyboardType = UIKeyboardTypeDefault;
    searchBar.showsScopeBar = NO;
    searchBar.showsCancelButton = NO;
    searchBar.delegate = self;
    if ([UItool isChinese]==YES) {
        searchBar.placeholder = @"搜索应用";
    }
    else{
        searchBar.placeholder = @"Search App";
    }
    [searchBar sizeToFit];
    [self.navgationView addSubview:searchBar];
    
    
    searchTableView = [[UITableView alloc]initWithFrame:ccr(TabBar_WIDTH, Nav_HEIGHT, 1024-TabBar_WIDTH, 768-Nav_HEIGHT) style:UITableViewStylePlain];
    searchTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    searchTableView.delegate = self;
    searchTableView.dataSource = self;
    [self.view addSubview:searchTableView];
    
    
//    lognBT = [[UIButton alloc] initWithFrame:CGRectZero];
//    [self.navgationView addSubview:lognBT];
//    [lognBT setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
}

-(void)moreButtonDoSomething:(NSNotification *)noti
{
    //点击more按钮执行事件
    AppDetailViewController *appDetail = [[AppDetailViewController alloc] init];
    UIButton *button = noti.object;
    appDetail.appId = [NSString stringWithFormat:@"%ld", (long)button.tag];
    [self.navigationController pushViewController:appDetail animated:NO];
    
    
}

-(void)henOfTypeView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
     searchBar.frame = ccr(3*SCREEN_WIDTH/5,Nav_HEIGHT/2-35, SCREEN_WIDTH*0.3, 100);     //lognBT.frame = ccr(SCREEN_HEIGHT-73, (Nav_HEIGHT-63)/2, 63, 63);
   // self.titleLabel.frame = ccr(SCREEN_HEIGHT/2-100, self.navgationView.frame.size.height/2-50, 200, 100);
     isHen = YES;
    
     [searchTableView reloadData];
   
}

-(void)shuOfTypeView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
    searchBar.frame = ccr(3*SCREEN_WIDTH/5+20,Nav_HEIGHT/2-50, 0.3*SCREEN_WIDTH-20, 100);
    // lognBT.frame = ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-63)/2, 63, 63);
    //self.titleLabel.frame = ccr(SCREEN_WIDTH/2-100, self.navgationView.frame.size.width/2-50, 200, 100);
     isHen = NO;
    [searchTableView reloadData];
  
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
        
        //横竖屏处理
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
            
           [self henOfTypeView];
            
            }else
        {
            [self shuOfTypeView];
            
        }
        
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
    [tempArray removeAllObjects];
    tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    if (![searchText length]) {
        aphaView.hidden = NO;
        tempArray = [NSMutableArray arrayWithArray:appList];
    }
    
//    else if ([searchText length]==1 &&[self isValidateLetter:searchText])
//    {
//        //NSArray *arr = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:firstLetterKey and:[searchText uppercaseString]];
//        for (BYapp *app in appList) {
//            if ([UItool isChinese]==YES&&[app.chineseFirstLetter isEqualToString:[searchText uppercaseString]]) {
//                
//                [tempArray addObject:app];
//            }
//            else if([UItool isChinese]==NO&&[app.englishFirstLetter isEqualToString:[searchText uppercaseString]]){
//                
//                [tempArray addObject:app];
//            }
//            
//        }
//        //tempArray = [NSMutableArray arrayWithArray:arr];
//    }
    else {
        NSRange range;
        // NSArray * array = [LocalSqlManger selectAll];
        for (BYapp *str  in appList){
            range = [str.appCname  rangeOfString:name];
            //range = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound){
                [tempArray addObject:str];
                
            }
            else{
                range = [[str.appEname uppercaseString]  rangeOfString:[name uppercaseString]];
                if (range.location != NSNotFound){
                    [tempArray addObject:str];
                    
                }
                if (!tempArray.count) {
                    aphaView.hidden = NO;
                }else{
                    aphaView.hidden = YES;
                }
            }
        }
        
        }
    
     [searchTableView reloadData];
    
}

- (BOOL)isValidateLetter:(NSString *)letter
{
    NSString *emailCheck =@"[A-Za-z]{1}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:letter];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationPortrait:
            
            [self shuOfTypeView];
            
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            //home健在上
            [self shuOfTypeView];
            
            
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            //home健在左
            [self henOfTypeView];


                
            
            
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            
           [self henOfTypeView];

            
            //home健在右
            break;
        default:
            break;
            
            
    }
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        if (isHen==YES) {
            int m = ([tempArray count]%2 !=0)?1:0;
            CGFloat h = ((([tempArray count]+m)*100/2+(([tempArray count]+m)/2+1))>(SCREEN_WIDTH-Nav_HEIGHT))?([tempArray count]+m)*100/2+(([tempArray count]+m)/2+1)*20:SCREEN_WIDTH-Nav_HEIGHT;
            NSLog(@"hen%f/n",h);
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
            NSLog(@"s222hushushushsushu%f/n",h);
            return h;
        }

    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tempArray count]!=0){
        static NSString * inderfiter = @"appCellInder";
        AppTableViewCell * cell = (AppTableViewCell *)[tableView dequeueReusableCellWithIdentifier:inderfiter];
        if (cell == nil) {
            cell = [[AppTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inderfiter];
            cell.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        [cell initWithArray:tempArray andIshen:isHen];
        return cell;
    }
    
    else{
        static NSString * inderfiter2 = @"cellid";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:inderfiter2];

        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inderfiter2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
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
