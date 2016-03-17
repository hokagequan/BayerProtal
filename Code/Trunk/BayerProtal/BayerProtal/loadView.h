//
//  loadView.h
//  testLoadview
//
//  Created by admin on 14-10-30.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"GPLoadingView.h"

@interface loadView : UIView

@property (nonatomic,strong)GPLoadingView *gpView;

-(void)starte;
-(void)stop;

@end
