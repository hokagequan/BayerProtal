//
//  AppTableViewCell.h
//  BayerProtal
//
//  Created by admin on 14-10-11.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *firstLabel;

@property (nonatomic,strong) NSMutableArray *viewArray;

//-(void)initWithDictionary:(NSArray *)dic ;
//
//-(void)initThreeWithDictionary:(NSArray *)dic;

-(void)initWithArray:(NSArray *)array  andIshen:(BOOL)ishen;

@end
