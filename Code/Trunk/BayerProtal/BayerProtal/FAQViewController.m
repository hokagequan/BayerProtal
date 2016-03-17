//
//  FAQViewController.m
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "FAQViewController.h"
#import "HeadView.h"
#import "faqInfor.h"
#import "JEFAQTableViewCell.h"
#import "JEFAQContentModel.h"

#import "UIWebView+SearchWebView.h"

#import "SVProgressHUD.h"
#import "CustomURLCache.h"


@interface FAQViewController ()<headViewDelegate,UIWebViewDelegate>
{
    NSArray * listArray;
    UILabel *titleLabel;
    UIImageView *lognBT;
    NSMutableArray * tempArray;
    NSMutableArray * faqArray;
    NSString *keyWord;
    UIView *aphaView;
}
//@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FAQViewController

@synthesize NavView;
@synthesize faqSearchBar;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                     diskCapacity:200 * 1024 * 1024
                                                                         diskPath:nil
                                                                        cacheTime:0];
        [CustomURLCache setSharedURLCache:urlCache];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(faqRrefresh:) name:@"refreshAll" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLanguageFaq:) name:@"changeLanguage" object:nil];

   
    [self createNavView];
    [self loadData];
    [self initTableView];
    [self createAphaView];
    
 
 
}

-(void)faqRrefresh:(NSNotification*)noti
{
    [self loadData];
}

- (void)loadData{
    listArray = [LocalSqlManger selectAllFaq];
    
    tempArray = [NSMutableArray array];
    faqArray = [NSMutableArray array];
    FAQinformation * infor ;
    for (int i = 0; i<listArray.count; i++) {
        
        JEFAQContentModel *info = [[JEFAQContentModel alloc] init];
        infor = [listArray objectAtIndex:i];
        info.opened = NO;
        info.height=@"0";
        info.faqId = infor.faqId;
        info.title = infor.title;
        info.content = infor.content;
        [faqArray addObject:info];
    }
    
    if ([UItool isChinese]) {
        titleLabel.text = @"常见问题";
    }
    else{
        titleLabel.text = @"FAQ";
    }

    tempArray = faqArray;
  
    [self.faqTableView reloadData];
}

-(void)changeLanguageFaq:(NSNotification *)noti
{
    if ([UItool isChinese]) {
        titleLabel.text = @"常见问题";
        faqSearchBar.placeholder = @"搜索问题";
    }
    else{
        titleLabel.text = @"FAQ";
        faqSearchBar.placeholder = @"Search FAQ";
    }
    
}
-(void)createAphaView
{
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
    faqSearchBar.text = @"";
    [self searchBar:faqSearchBar textDidChange:@""];
    [faqSearchBar resignFirstResponder];
    
    // [aphaView removeFromSuperview];
}


- (void)initTableView{
    self.faqTableView = [[UITableView alloc]initWithFrame:CGRectMake(TabBar_WIDTH, Nav_HEIGHT, SCREEN_WIDTH-TabBar_WIDTH, SCREEN_HEIGHT - Nav_HEIGHT)];
    self.faqTableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.faqTableView.delegate = self;
    self.faqTableView.dataSource = self;
    [self.faqTableView clearLine];
    [self.view addSubview:self.faqTableView];
}

-(void)viewOfHen
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
    
    
}
-(void)viewOfShu
{   [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
     
}


-(void)createNavView
{
    NavView = [[UIView alloc] initWithFrame:ccr(0, 0, 1024, Nav_HEIGHT)];
    NavView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    NavView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    titleLabel = [[UILabel alloc] initWithFrame:ccr(SCREEN_WIDTH/2-100, NavView.frame.size.height/2-50, 200, 100)];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:25];
    titleLabel.textColor = [UIColor whiteColor];
    [NavView addSubview:titleLabel];
    [self.view addSubview:NavView];
    
    
    faqSearchBar = [[UISearchBar alloc] initWithFrame:ccr(3*VIEW_W(self.view)/5,Nav_HEIGHT/2-35, VIEW_W(self.view)*0.3, 100)];
    faqSearchBar.backgroundColor = [UIColor clearColor];
    faqSearchBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
    for (UIView *view in faqSearchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    faqSearchBar.tintColor = [UIColor lightGrayColor];
	faqSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	faqSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    // appSearchBar.keyboardType = UIKeyboardTypeDefault;
    faqSearchBar.showsScopeBar = NO;
    faqSearchBar.showsCancelButton = NO;
    faqSearchBar.delegate = self;
    if ([UItool isChinese]==YES) {
        faqSearchBar.placeholder = @"搜索问题";
    }
    else{
        faqSearchBar.placeholder = @"Search FAQ";
    }
    [NavView addSubview:faqSearchBar];
    
    lognBT = [[UIImageView alloc] initWithFrame:ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-53)/2, 53, 53)];
    lognBT.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    [NavView addSubview:lognBT];
    lognBT.image = [UIImage imageNamed:@"logo.png"];
   // [lognBT setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    titleLabel.frame = ccr(SCREEN_WIDTH/2-100, NavView.frame.size.height/2-35, 200, 100);
    lognBT.frame = ccr(1024-80, (Nav_HEIGHT-45)/2, 53, 53);

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ){
        [self viewOfHen];
        
    }
    else
    {
        [self viewOfShu];
        
    }
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            [self viewOfShu];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            [self viewOfShu];
            break;
        case UIInterfaceOrientationLandscapeLeft:
            [self viewOfHen];
            break;
        case UIInterfaceOrientationLandscapeRight:
            [self viewOfHen];
            break;
            
        default:
            break;
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//    if (searchBar.text.length) {
//        aphaView.hidden = YES;
//    }else{
        aphaView.hidden = NO;
    //}
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    //    searchBar.text = @"";
    //    [self searchBar:searchBar textDidChange:@""];
       aphaView.hidden = YES;
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    keyWord = searchText;
    aphaView.hidden = YES;
    NSString *name = searchText;
    //[tempArray removeAllObjects];
    tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    if (![searchText length]) {
        aphaView.hidden = NO;
        tempArray = [NSMutableArray arrayWithArray:faqArray];
        [self.faqTableView reloadData];
        
    }
    else {
        NSRange range;
        
        //NSArray * array = [LocalSqlManger selectAllFaq];
        for (JEFAQContentModel *str in faqArray){
            range = [[str.title uppercaseString]  rangeOfString:[name uppercaseString]];
            //range = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound){
                [tempArray addObject:str];
                
            }
            else{
                //从内容中查询
                range = [[[UItool flattenHTML:str.content]uppercaseString] rangeOfString:[name uppercaseString]];
                if (range.location != NSNotFound){
                    [tempArray addObject:str];
                    
                }
            }
        }
        if (!tempArray.count) {
            aphaView.hidden = NO;
        }else{
            aphaView.hidden = YES;
        }

        [self.faqTableView reloadData];
        }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JEFAQContentModel *model = tempArray[indexPath.section];
    return model.height.intValue;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     JEFAQContentModel * info = tempArray[section];
     NSInteger count = info.isOpened ? 1 : 0;
     return count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
      return [tempArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView ];
    headView.delegate = self;
    headView.information = tempArray[section];
    headView.information.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    headView.contentView.backgroundColor = section%2 == 0 ? RGBCOLOR(227, 227, 227) : RGBCOLOR(238, 238, 238);
    NSString *str = [NSString stringWithFormat:@"Q%d:%@",section+1,headView.information.title];
    headView.numLabel.text = str;
   // headView.numLabel.font = [UIFont systemFontOfSize:30];
    if (keyWord.length) {
        NSRange range = [[str uppercaseString] rangeOfString:[keyWord uppercaseString]];
        if (range.location!=NSNotFound) {
            [headView.numLabel setColor:[UIColor yellowColor] fromIndex:range.location length:range.length];
        }
    }
       // [headView addSubview:label];

    return headView;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    JEFAQContentModel *app = tempArray[section];
//    NSString *str = [NSString stringWithFormat:@"Q%d:%@",section+1,app.title];
//    return  str;
//}

/*
 create cell
 webview
 loadString
 
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"Cell";
    
    JEFAQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[JEFAQTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (indexPath.section%2 == 0) {
        cell.backgroundColor = RGBCOLOR(227, 227, 227);
    }
    else{
        cell.backgroundColor = RGBCOLOR(238, 238, 238);
    }
    
    cell.webView.delegate = self;
    JEFAQContentModel *model = tempArray[indexPath.section];
    model.indexPath = indexPath;
    [cell loadData:model.content];
   // cell.HTMLdata = model.content;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *requestURL =[request URL];
    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
        return ![ [ UIApplication sharedApplication ] openURL: requestURL ];
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    int h = webView.scrollView.contentSize.height;
    webView.frame = ccr(0, 0, self.view.frame.size.width, h);
    JEFAQTableViewCell *cell =  (JEFAQTableViewCell *)webView.superview.superview.superview;
    if (isIOS8) {
        cell = (JEFAQTableViewCell *)webView.superview.superview;
    }

    NSIndexPath *indexPath = [_faqTableView indexPathForCell:cell];
    JEFAQContentModel *model = tempArray[indexPath.section];
    if (model.height.intValue == h) {
        if(keyWord.length)
            [webView highlightAllOccurencesOfString:keyWord];
        else
            [webView removeAllHighlights];
        [SVProgressHUD dismiss];
        return;
    }
    model.height = String(@"%d",h);
    [_faqTableView reloadData];
//    [self.faqTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];


}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
}

- (void)clickHeadView:(HeadView *)headView isOpen:(BOOL)isOpen{
    [self.faqTableView reloadData];

    if  (isOpen){
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        int i = 0;
        for (int index = 0; index<headView.information.indexPath.section; index++) {
            JEFAQContentModel *model = tempArray[index];
            if (model.isOpened) {
                i+=model.height.intValue;
            }
        }
        [self.faqTableView setContentOffset:ccp(0, headView.information.indexPath.section * 100 + i)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];
    
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
