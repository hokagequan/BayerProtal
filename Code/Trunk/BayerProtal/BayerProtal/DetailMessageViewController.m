//
//  DetailMessageViewController.m
//  BayerProtal
//
//  Created by admin on 14-10-21.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "DetailMessageViewController.h"
#import "NIAttributedLabel.h"

@interface DetailMessageViewController ()<NIAttributedLabelDelegate>{
    UILabel *timeLabel;
    NIAttributedLabel *messageLabel;
    UIView *naVview;
    UIButton *lognBT;
}
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation DetailMessageViewController

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLuanguage) name:@"changeLanguage" object:nil];
    if (self.information.isRead.intValue == 0) {
        self.information.isRead = @1;
        [JEUtits save];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refershMessage" object:self];
    self.view.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    
    [self createView];
    [self loadData];
}
-(void)loadData
{
    if ([UItool isChinese]==YES) {
        self.titleLabel.text = @"信息";
    }
    else{
        self.titleLabel.text = @"Message";
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [self detailViewOfHen];
    }
    else{
        [self detailViewOfShu];
    }
    
}

-(void)changeLuanguage
{
    [self loadData];
    
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            [self detailViewOfShu];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            [self detailViewOfShu];
            break;
        case UIInterfaceOrientationLandscapeLeft:
            [self detailViewOfHen];
            break;
        case UIInterfaceOrientationLandscapeRight:
            [self detailViewOfHen];
            break;
            
        default:
            break;
    }
}

-(void)createView
{
    
    naVview = [[UIView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH , Nav_HEIGHT)];
    naVview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg.png"]];
    naVview.backgroundColor = [UIColor colorWithRed:4/255.0 green:126/255.0 blue:163/255.0 alpha:1.0];
    [self.view addSubview:naVview];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = ccr(110,(Nav_HEIGHT-31)/2 -10, 50, 50);
    button.titleLabel.font = [UIFont systemFontOfSize:28];
    [button setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
   // [button setTitle:@"back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:95/255.0 green:158/255.0 blue:160/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [naVview addSubview:button];
    self.titleLabel = [[UILabel alloc] initWithFrame:ccr(SCREEN_WIDTH/2-100, naVview.frame.size.height/2-50, 200, 100)];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:22];
    [naVview addSubview:self.titleLabel];

    
    timeLabel = [[UILabel alloc] initWithFrame:ccr(20, Nav_HEIGHT+10, 200, 50)];
    [self.view addSubview:timeLabel];
    timeLabel.text = self.information.createTime;
    
//    2014-12-19 11:56 消息内容支持点击链接至Safari  -尹现伟
    messageLabel = [[NIAttributedLabel alloc] initWithFrame:ccr(50, VIEW_BY(timeLabel), VIEW_W(self.view)-100, VIEW_H(self.view) - VIEW_BY(timeLabel) - 20)];
    messageLabel.autoDetectLinks = YES;
    [self.view addSubview:messageLabel];
    messageLabel.text = self.information.information;
    messageLabel.delegate = self;
    messageLabel.numberOfLines = 0;
    lognBT = [[UIButton alloc] initWithFrame:CGRectZero];
    [lognBT setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    lognBT.hidden = YES;
    [naVview addSubview:lognBT];
    messageLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
}

#pragma mark - NIAttributedLabelDelegate

- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point{
    NSString* title = nil;
    if (NSTextCheckingTypeLink == result.resultType) {
        if (![result.URL.scheme isEqualToString:@"mailto"]) {
            title = result.URL.absoluteString;
            [[UIApplication sharedApplication]openURL:URL(@"%@",title)];
        }
    }
    
}

- (BOOL)attributedLabel:(NIAttributedLabel *)attributedLabel shouldPresentActionSheet:(UIActionSheet *)actionSheet withTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point{
    return NO;
}
-(void)back:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void)detailViewOfHen
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToHen" object:self];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//   messageLabel.numberOfLines = 0;
//  NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:button.desLabel.font,NSFontAttributeName,nil];
//    CGFloat width = SCREEN_HEIGHT - 100;
//    NSDictionary *attributes = @{NSFontAttributeName:messageLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
//    CGSize size = [messageLabel.text boundingRectWithSize:CGSizeMake(width,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    CGFloat y =timeLabel.frame.size.height+timeLabel.frame.origin.y+10;
//     messageLabel.frame = ccr(50,y, size.width+5, size.height);
    lognBT.frame = ccr(SCREEN_HEIGHT-73, (Nav_HEIGHT-63)/2, 63, 63);

}


-(void)detailViewOfShu
{
    //20, Nav_HEIGHT+10, 200, 100
     [[NSNotificationCenter defaultCenter]postNotificationName:@"changeScreenToShu" object:self];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    messageLabel.numberOfLines = 0;
//    CGFloat width = SCREEN_WIDTH - 100;
//    NSDictionary *attributes = @{NSFontAttributeName:messageLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
//    CGSize size = [messageLabel.text boundingRectWithSize:CGSizeMake(width,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    CGFloat y =timeLabel.frame.size.height+timeLabel.frame.origin.y+10;
//
//    messageLabel.frame = ccr(50,y, size.width+5,size.height);
    lognBT.frame = ccr(SCREEN_WIDTH-73, (Nav_HEIGHT-63)/2, 63, 63);

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
