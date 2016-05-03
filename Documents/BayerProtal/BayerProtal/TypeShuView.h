//
//  TypeShuView.h
//  BayerProtal
//
//  Created by admin on 14-10-21.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeShuView : UIView

@property (nonatomic,strong) UIScrollView *scrollView;

-(void)typeShuViewInitWithList:(NSArray *)dic;

@end
