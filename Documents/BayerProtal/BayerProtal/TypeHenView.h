//
//  TypeHenView.h
//  BayerProtal
//
//  Created by admin on 14-10-21.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeHenView : UIView

@property (nonatomic,strong) UIScrollView *scrollView;

-(void)typeHenViewInitWithList:(NSArray *)array;

@end
