//
//  ShuView.m
//  BayerProtal
//
//  Created by admin on 14-10-20.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "ShuView.h"
#import "AppTableViewCell.h"
#import "appCellView.h"
#import "AppDetailViewController.h"


#import "LocalSqlManger.h"
#import "IpaRequestManger.h"
#import "AppDelegate.h"

#define HEIGHT_SPACE 10;
#define HEIGHT_BUTTON 100;


@implementation ShuView
@synthesize BYlistTableview;
@synthesize letterList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        BYlistTableview = [[UITableView alloc]initWithFrame:ccr(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
         BYlistTableview.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:0.9];
        BYlistTableview.delegate = self;
        BYlistTableview.dataSource = self;
        [self addSubview:BYlistTableview];
        letterList = [LocalSqlManger selectAllFirstLetter];

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSInteger m = (tableView==BYlistTableview)?[letterList count]:1;
    return m;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return letterList;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int k = [letterList count];
    for (int i =0; i<k; i++) {
        NSArray * array = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:@"theFirstLetter" and:[letterList objectAtIndex:i]];
        
        if ([indexPath section]==i) {
            int m = ([array count]%2 !=0)?1:0;
                CGFloat h = (tableView == BYlistTableview)?([array count]+m)*100/2+(([array count]+m)/2+1)*20:100;
                NSLog(@"hen%f/n",h);
                return h;
            }
        
    }
    return 0;
    
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [letterList objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * inderfiter = @"appCellInder";
    AppTableViewCell * cell = (AppTableViewCell *)[tableView dequeueReusableCellWithIdentifier:inderfiter];
    NSArray * arry ;
    if (cell == nil) {
        cell = [[AppTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inderfiter];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        arry = [LocalSqlManger selectClass:@"BYapp" ThroughTheKey:@"theFirstLetter" and:[letterList objectAtIndex:[indexPath section]]];
        for (int i=0; i<[arry count]; i++) {
            BYapp * app = [arry objectAtIndex:i];
            NSLog(@"hen%@count%@",[letterList objectAtIndex:[indexPath section]],app.appId);
            //[cell initWithDictionary:arry andNum:0];
        }
        
        
        
    }
     cell.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    return cell;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
