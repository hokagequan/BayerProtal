//
//  MessageViewController.m
//  BayerProtal
//
//  Created by admin on 14-9-25.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "MessageViewController.h"
#import "AFNetworking.h"
#import "MessageTableViewCell.h"
#import "BYinformation.h"
#import "DetailMessageViewController.h"
#import "BayerProtal-Swift.h"

@interface MessageViewController ()
{
    NSMutableArray * messageArray;
    NSMutableArray *tempArra;
    NSArray *messageList;
    UIImageView *lognBT;
    UIView *aphaView;
}

@end

@implementation MessageViewController

@synthesize navView;
@synthesize titleLabel;
@synthesize messageListTableView;
@synthesize desList;
@synthesize timeList;
@synthesize messageSearchBar;

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refershMessage:) name:@"refershMessage" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLanguage:) name:@"changeLanguage" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refershMessage:) name:@"refreshAll" object:nil];
    
    [self CreateNavgationView];
    
    [self messageLoadData];
    [self createTableView];
    [self createAphaView];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        
        [self messageViewOfHen];
        
    }
    else{
        [self messageViewOfShu];
        
    }
    [UItool refershMessageWithTime];
    [messageListTableView reloadData];
    
    // FIXME: Test
    
    [MessageManager defaultManager].unReadCount = 10;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refershMessage" object:nil];

}
-(void)refershMessage:(NSNotification *)noti
{
    [self messageLoadData];
    [messageListTableView reloadData];
}


-(void)messageLoadData
{
    tempArra = [NSMutableArray array];

    //获取数据
    if ([UItool isChinese]==YES) {
        titleLabel.text = @"信息";
        
    }
    else{
        titleLabel.text = @"Message";
    }
//    messageList = [LocalSqlManger selectAllMessage];

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:[NSString stringWithFormat:@"http://%@/Bayer_portal/mobile/muser!MessageList.action",LocalHost] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        if([responseObject[@"SendMessageLog"] isKindOfClass:[NSArray class]]){
//        
//            for (NSDictionary *dic in responseObject[@"SendMessageLog"]) {
//                
//                BYinformation *info = [[BYinformation alloc]init];
//                [info setValuesForKeysWithDictionary:dic];
//                [tempArra addObject:info];
//            }
//            [messageListTableView reloadData];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//    }];
//    
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *array = [user objectForKey:@"messageArray"];
//    tempArra = [NSMutableArray arrayWithArray:array];
    
    // FIXME: Test
    NSManagedObjectContext *context = [CoreDataManager defalutManager].managedObjectContext;
    messageList = [[MessageManager defaultManager] getMessages:context];
    
    tempArra = [NSMutableArray arrayWithArray:messageList];
    
    [messageListTableView reloadData];
    
    // QCW fix
    [[MessageManager defaultManager] synthronizeMessages:^{
        NSManagedObjectContext *context = [CoreDataManager defalutManager].managedObjectContext;
        messageList = [[MessageManager defaultManager] getMessages:context];
        tempArra = [NSMutableArray arrayWithArray:messageList];
        
        [[MessageManager defaultManager] readAllMessage];
        [messageListTableView reloadData];
    }];
}

-(void)changeLanguage:(NSNotification *)noti
{
    if ([UItool isChinese]==YES) {
        titleLabel.text = @"信息";
        messageSearchBar.placeholder = @"搜索通知";
    }
    else{
        titleLabel.text = @"Message";
        messageSearchBar.placeholder = @"Search Message";
    }
   
}

-(void)messageViewOfHen
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:nil];
    
}

-(void)messageViewOfShu
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:nil];
   
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
             [self messageViewOfShu];
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            //home健在上 
             [self messageViewOfShu];
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            //home健在左
            [self messageViewOfHen];
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            
            [self messageViewOfHen];
            //home健在右
            break;
        default:
            break;
            
            
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
    messageSearchBar.text = @"";
    [self searchBar:messageSearchBar textDidChange:@""];
    [messageSearchBar resignFirstResponder];
    
    // [aphaView removeFromSuperview];
}

-(void)CreateNavgationView{
 

    navView = [[UIView alloc] initWithFrame:ccr(0, 0, 1024, Nav_HEIGHT)];
    navView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    navView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleLabel = [[UILabel alloc] initWithFrame:ccr(SCREEN_WIDTH/2-100, navView.frame.size.height/2-50, 200, 100)];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:25];
    [navView addSubview:titleLabel];
    [self.view addSubview:navView];
    messageSearchBar = [[UISearchBar alloc] initWithFrame:ccr(3*VIEW_W(self.view)/5,Nav_HEIGHT/2-35, VIEW_W(self.view)*0.3, 100)];
    messageSearchBar.backgroundColor = [UIColor clearColor];
    messageSearchBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
    for (UIView *view in messageSearchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    messageSearchBar.tintColor = [UIColor lightGrayColor];
	messageSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	messageSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    messageSearchBar.showsScopeBar = NO;
    messageSearchBar.showsCancelButton = NO;
    messageSearchBar.delegate = self;
    //[messageSearchBar sizeToFit];
    if ([UItool isChinese]==YES) {
        messageSearchBar.placeholder = @"搜索通知";
    }
    else{
        messageSearchBar.placeholder = @"Search Message";
    }
   // [navView addSubview:messageSearchBar];
    
    lognBT = [[UIImageView alloc] initWithFrame:ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-53)/2, 53, 53)];
    lognBT.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    [navView addSubview:lognBT];
    lognBT.image = [UIImage imageNamed:@"logo.png"];
    
    
    titleLabel.frame = ccr(SCREEN_WIDTH/2-100, navView.frame.size.height/2-35, 200, 100);
    lognBT.frame = ccr(1024-80, (Nav_HEIGHT-45)/2, 53, 53);

}

-(void)createTableView
{
    messageListTableView = [[UITableView alloc] initWithFrame:ccr(TabBar_WIDTH, Nav_HEIGHT,1024-TabBar_WIDTH, 768-Nav_HEIGHT) style:UITableViewStylePlain];
    messageListTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    messageListTableView.dataSource = self;
    messageListTableView.delegate = self;
    [self.view addSubview:messageListTableView];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [messageSearchBar resignFirstResponder];
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
    NSString *name = searchText;
    aphaView.hidden = YES;
    tempArra = [[NSMutableArray alloc] init];
    [tempArra removeAllObjects];
    if (![searchText length]) {
        aphaView.hidden = NO;
        tempArra = [NSMutableArray arrayWithArray:messageList];
        [messageListTableView reloadData];
    }
    else {
        NSRange range;
        
//        for (BYinformation *str  in messageList){
//            range = [str.information  rangeOfString:name];
//            
//            if (range.location != NSNotFound){
//                [tempArra addObject:str];
//                
//            }
//        }
        for (MessageEntity *message in messageList) {
            range = [message.content rangeOfString:name];
            
            if (range.location != NSNotFound) {
                [tempArra addObject:message];
            }
        }
        [messageListTableView reloadData];
        if (!tempArra.count) {
            aphaView.hidden = NO;
        }else{
            aphaView.hidden = YES;
        }

    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tempArra count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"MessageCell";
    MessageTableViewCell *messageCell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifer];
    if (messageCell==nil) {
        messageCell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
       // messageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    MessageEntity *message = tempArra[indexPath.row];
    [messageCell initWithDescrptions:message.content];
    return messageCell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSString *subject = @"Message subject";//邮件主题
//    NSString *body = @"Message body";//邮件内容
//    NSString *address = @"test1@akosma.com";//收件
//    NSString *cc = @"test2@akosma.com";//抄送
//    NSString *path = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=%@&body=%@", address, cc, subject, body];
//    NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    [[UIApplication sharedApplication] openURL:url];
//    DetailMessageViewController *detailMessage = [[DetailMessageViewController alloc] init];
//    //参数传递
//    BYinformation *byInfor = [tempArra objectAtIndex:[indexPath row]];
//    detailMessage.information =byInfor;
//    [self.navigationController pushViewController:detailMessage animated:NO];
    
   // [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://sp-coll-bhc.ap.bayer.cnb/sites/250003/compliance/SitePages/OrgChart.aspx"]];
    
}


//删除数据
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle==UITableViewCellEditingStyleDelete) {
//        //删除数据源。
//        BYinformation *byInfor = [tempArra objectAtIndex:[indexPath row]];
//        [byInfor MR_deleteEntity];
//        [JEUtits save];
//        [tempArra removeObjectAtIndex:[indexPath row]];
//        [messageListTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        
//        tempArra =[NSMutableArray arrayWithArray:[LocalSqlManger selectAllMessage]];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"refershMessage" object:self];
//    }
//        [messageListTableView setEditing:NO animated:YES];
//}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @" 删 除  ";
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
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
