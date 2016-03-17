//
//  buttonTableViewCell.h
//  BayerProtal
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatageryButton.h"
@protocol catageryDelegate <NSObject>
@optional
-(void)goToTheCategery:(id)sender;

@end
@interface buttonTableViewCell : UITableViewCell

@property (nonatomic,strong) CatageryButton * faAndHrBt;
@property (nonatomic,strong) CatageryButton * msBt;
@property (nonatomic,strong) CatageryButton * officeBt;
@property (nonatomic,strong) CatageryButton * favourateBt;
@property (nonatomic,strong) CatageryButton * allAppBt;
@property (nonatomic,strong) CatageryButton *communicateBt;
@property (nonatomic,strong) UIImageView *exhibImageViewO;
@property (nonatomic,strong) UIImageView *exhibImageViewT;
@property (nonatomic,strong) UIImageView *exhibImageViewTH;

@property (nonatomic,weak) id<catageryDelegate>delegate;

-(void)initWithBtArray:(NSArray *)array andIsHen:(BOOL)isHen;
@end
