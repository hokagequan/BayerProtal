//
//  AppTableViewCell.m
//  BayerProtal
//
//  Created by admin on 14-10-11.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "AppTableViewCell.h"
#import "appCellView.h"
#import "BYapp.h"
#import "UIImage+Tint.h"

@implementation AppTableViewCell
@synthesize firstLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        firstLabel = [[UILabel alloc] initWithFrame:ccr(5, self.frame.size.height/4, 100, self.frame.size.height/2)];
        [self addSubview:firstLabel];
        
         _viewArray = [NSMutableArray array];
        
    }
    return self;
}



-(void)initWithArray:(NSArray *)array andIshen:(BOOL)ishen
{
    if ([array count]>[_viewArray count]) {
        int count = _viewArray.count;
        for (int i=0; i<[array count]-count; i++) {
            appCellView *view = [[appCellView alloc]init];
            [_viewArray addObject:view];
        }
    }
    if (ishen) {
       
        [self initThreeWithDictionary:array];
    }
    else{
          [self initWithDictionary:array];
    }
}

-(void)initWithDictionary:(NSArray *)dic
{
    
    int i =0;
    int k = 0;
    CGFloat height = 100;
    CGFloat width = 200;
    CGFloat X = 350;
    CGFloat Y = 100;
    //CGFloat space = 10;
    int m = [dic count]%2!=0?[dic count]+1:[dic count];
    int n = m/2;
    int j = [dic count]<2?1:2;
    int l = 0;
    
   for ( i = 0;i<n;i++) {
        for (k=0; k<j;k++ ) {
            appCellView *view;
            if (l<[dic count]) {
               view = [_viewArray objectAtIndex:l];
                view.frame = ccr(50+X*k, Y*i+30*(i+1), width, height);
                 BYapp *app = [dic objectAtIndex:l];
                [view makeTheNewUI:app];
                l++;
            }
            [self.contentView addSubview:view];
            }
       if ([_viewArray count]>[dic count]) {
           for (int w=[dic count]; w<[_viewArray count]; w++) {
               appCellView *view = [_viewArray objectAtIndex:w];
               [view removeFromSuperview];
           }
       }

   }
}


-(void)initThreeWithDictionary:(NSArray *)dic
{
    int i =0;
    int k = 0;
    CGFloat height = 100;
    CGFloat width = 200;
    CGFloat X = 300;
    CGFloat Y = 100;
    //CGFloat space = 10;
    int m ;
    if ([dic count]%3==0) {
        m = [dic count];
    }
    else if ([dic count]%3==1)
    {
        m =[dic count]+2;
    }
    else if([dic count]%3==2)
    {
        m =[dic count]+1;
    }

    int n = m/3;
    int j = [dic count]<4?[dic count]:3;
    int l = 0;
    for ( i = 0;i<n;i++) {
        for (k=0; k<j;k++ ) {
            appCellView *view ;
            if (l<[dic count]) {
                view = [_viewArray objectAtIndex:l];
                view.frame = ccr(50+X*k, Y*i+30*(i+1), width, height);
                BYapp *app = [dic objectAtIndex:l];
                [view makeTheNewUI:app];
                l++;
            }
            [self.contentView addSubview:view];
            for (int w=[dic count]; w<[_viewArray count]; w++) {
                appCellView *view = [_viewArray objectAtIndex:w];
                [view removeFromSuperview];
            }
        
        }
        
    }
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
