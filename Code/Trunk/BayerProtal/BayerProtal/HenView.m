//
//  HenView.m
//  BayerProtal
//
//  Created by admin on 14-10-20.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "HenView.h"

#import "AppTableViewCell.h"
#import "appCellView.h"
#import "AppDetailViewController.h"


#import "LocalSqlManger.h"
#import "IpaRequestManger.h"
#import "AppDelegate.h"

#define HEIGHT_SPACE 10;
#define HEIGHT_BUTTON 100;


@implementation HenView
@synthesize BYlistTableview;
@synthesize letterList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        BYlistTableview = [[UITableView alloc]initWithFrame:ccr(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        // BYlistTableview.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:0.9];
        BYlistTableview.delegate = self;
        BYlistTableview.dataSource = self;
        [self addSubview:BYlistTableview];
        BYlistTableview.sectionIndexTrackingBackgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
        letterList = [LocalSqlManger selectAllFirstLetter];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSInteger m = (tableView==BYlistTableview)?[letterList count]:1;
    return m;
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
           
            int m = 0 ;
            if ([array count]%3==0) {
                m=[array count];
            }
            else if ([array count]%3==1) {
                m=[array count]+2;
            }
            else if ([array count]%3==2) {
                m=[array count]+1;
            }
            CGFloat h = (tableView == BYlistTableview)?m*100/3+(m/3+1)*20:100;
            NSLog(@"shushushushsushu%f/n",h);
            return h;

            
            
        }
        
    }
    return 0;
    
    
    
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return letterList;
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
            //[cell initThreeWithDictionary:arry andNum:0];
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
