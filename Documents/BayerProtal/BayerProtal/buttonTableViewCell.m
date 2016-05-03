//
//  buttonTableViewCell.m
//  BayerProtal
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "buttonTableViewCell.h"
#import "UIButton+BYbuttonTitle.h"
#import "CatageryButton.h"
#import "AppCatagery.h"
#import "CustomButton.h"

#define BT_WIDTH SCREEN_WIDTH*0.24
#define BT_SPACE_X SCREEN_WIDTH*0.035
#define BT_SPACE_Y   SCREEN_HEIGHT*0.02
#define BT_X   0

@implementation buttonTableViewCell
{
    NSMutableArray *mutableArr;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        _faAndHrBt = [CatageryButton make_typeTwoButtonWithFrame:CGRectZero andTitleFrame:CGRectZero];
//        _msBt = [CatageryButton make_typeTwoButtonWithFrame:CGRectZero andTitleFrame:CGRectZero];
//        //_msBt = [CatageryButton makeButtonWithFrame:CGRectZero andTitleFrame:CGRectZero];
//        _officeBt = [CatageryButton makeButtonWithFrame:CGRectZero andTitleFrame:CGRectZero];
//        _favourateBt = [CatageryButton makeButtonWithFrame:CGRectZero andTitleFrame:CGRectZero];
//        _allAppBt = [CatageryButton makeButtonWithFrame:CGRectZero andTitleFrame:CGRectZero];
//        _communicateBt = [CatageryButton makeButtonWithFrame:CGRectZero andTitleFrame:CGRectZero];
//      
//        
//        
//        [_faAndHrBt setBackgroundImage:[UIImage imageNamed:@"fa_process_icon.png"] forState:UIControlStateNormal];
//        [_msBt setBackgroundImage:[UIImage imageNamed:@"marketing&sales_icon.png"] forState:UIControlStateNormal];
//        [_officeBt setBackgroundImage:[UIImage imageNamed:@"office_tools_icon.png"] forState:UIControlStateNormal];
//        [_favourateBt setBackgroundImage:[UIImage imageNamed:@"Favorite_icon.png"] forState:UIControlStateNormal];
//        [_allAppBt setBackgroundImage:[UIImage imageNamed:@"all_application_icon.png"] forState:UIControlStateNormal];
//        [_communicateBt setBackgroundImage:[UIImage imageNamed:@"communication_icon.png"] forState:UIControlStateNormal];
//        
//        [_faAndHrBt addTarget:self action:@selector(catageryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_msBt addTarget:self action:@selector(catageryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_officeBt addTarget:self action:@selector(catageryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_allAppBt addTarget:self action:@selector(catageryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_favourateBt addTarget:self action:@selector(catageryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_communicateBt addTarget:self action:@selector(catageryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _exhibImageViewO  = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_exhibImageViewO];
        _exhibImageViewT  = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_exhibImageViewT];
        _exhibImageViewTH  = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_exhibImageViewTH];
        
       
        
        
        //NSArray *titleArray = @[@"",@"",@""];
        
        
        NSArray *imageArray = @[@"所有应用",@"报销及人事",@"我的助手",@"我的常用",@"市场及营销"];
        for (int i = 0; i<5; i++) {
            CustomButton *button;
            if (i<3) {
                button = [[CustomButton alloc]initWithFrame:CGRectMake(i%3*(300)+10, 330, 300, 150)];

            }else{
                button = [[CustomButton alloc]initWithFrame:CGRectMake(i%3*(450)+10, 480, 450, 150)];
            }

            [self.contentView addSubview:button];
            button.layer.borderWidth = 1.0;
            button.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0].CGColor;
            button.CusImageView.image = [UIImage imageNamed:imageArray[i]];
            [button addTarget:self action:@selector(catageryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.TitleLabel.text = imageArray[i];
            switch (i) {
                case 0:
                    button.tag = 10000;
                    break;
                case 1:
                    button.tag = 1;
                    break;
                case 2:
                    button.tag = 4;

                    break;
                case 3:
                    button.tag = 2;

                    break;
                case 4:
                    button.tag = 3;

                    break;
                default:
                    break;
            }
        }
        
        
        
        
        
        _faAndHrBt.tag = 1;
        
        _msBt.tag = 3;
        _officeBt.tag = 4;
        _favourateBt.tag = 2;
        
        _allAppBt.tag = 10000;
        
//        [self.contentView addSubview:_faAndHrBt];
//        [self.contentView addSubview:_msBt];
//        [self.contentView addSubview:_officeBt];
//        [self.contentView addSubview:_favourateBt];
//        [self.contentView addSubview:_allAppBt];
//        [self.contentView addSubview:_communicateBt];
        
         mutableArr = [NSMutableArray array];

    }
    return self;
}


-(void)initWithBtArray:(NSArray *)array andIsHen:(BOOL)isHen
{
  
//    for (int v=0; v<[array count]; v++) {
//        AppCatagery *cata = [array objectAtIndex:v];
//        NSLog(@"%@",cata.catageryId);
//    }
    int count = [mutableArr count];
    NSLog(@"%d",mutableArr.count);
    int h ,l;
    int m =[array count]-4;
    
    if (m<=4) {
        h=1;l=m;
    }
    else{
        h= [self getNum:m];
        l=4;
    }
    if (count<m) {
        for (int n=4; n<m-count+4 ; n++) {
            
                CatageryButton *cataBt = [CatageryButton makeButtonWithFrame:CGRectZero andTitleFrame:CGRectZero];
                [self.contentView addSubview:cataBt];
                [mutableArr addObject:cataBt];
               AppCatagery *catagory = [array objectAtIndex:count+n];
              [cataBt sd_setBackgroundImageWithURL:[NSURL URLWithString:catagory.imagUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"faq.png"]];
                 cataBt.tag = [catagory.catageryId intValue];
            if ([UItool isChinese]==YES) {
                cataBt.nameLabel.text = catagory.chineseName;
            }
            else{
                cataBt.nameLabel.text = catagory.englishName;
            }
                [cataBt addTarget:self action:@selector(catageryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
        }
    }
    else if (count>m)  //count 是buttond 的个数
    {
        int num = 0;
        for (int n=4; n<count+4 ; n++) {
            if (num<m) {
                AppCatagery *catagory = [array objectAtIndex:n];
               CatageryButton* cataBt = [mutableArr objectAtIndex:n-4];
                [cataBt sd_setBackgroundImageWithURL:[NSURL URLWithString:catagory.imagUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"faq.png"]];
                cataBt.tag = [catagory.catageryId intValue];
                [self.contentView addSubview:cataBt];
                if ([UItool isChinese]==YES) {
                    cataBt.nameLabel.text = catagory.chineseName;
                }
                else{
                    cataBt.nameLabel.text = catagory.englishName;
                }
                [cataBt addTarget:self action:@selector(catageryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            else{
                
                 CatageryButton *buttton = [mutableArr objectAtIndex:num];
                [buttton removeFromSuperview];
                [mutableArr removeObjectAtIndex:num];
                
            }
            num++;
            
        }

        
    }
    else{
        for (int n=4; n<count+4; n++) {
            AppCatagery *catagory = [array objectAtIndex:n];
            CatageryButton* cataBt = [mutableArr objectAtIndex:n-4];
            [self.contentView addSubview:cataBt];

            [cataBt sd_setBackgroundImageWithURL:[NSURL URLWithString:catagory.imagUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"faq.png"]];
            cataBt.tag = [catagory.catageryId intValue];
            if ([UItool isChinese]==YES) {
                cataBt.nameLabel.text = catagory.chineseName;
            }
            else{
                cataBt.nameLabel.text = catagory.englishName;
            }
            [cataBt addTarget:self action:@selector(catageryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    AppCatagery *FaHcatagory;
    AppCatagery *Mscatagory;
    AppCatagery *OfficEcatagory;
    AppCatagery * Favcatagory;
    NSArray *cgArray = [LocalSqlManger selectAllCatagery];
    if ([cgArray count]!=0) {
         Favcatagory = [cgArray objectAtIndex:1];
        NSLog(@"%@=====ssssssssss===",Favcatagory.englishName);
        FaHcatagory = [cgArray objectAtIndex:0];
        Mscatagory = [cgArray objectAtIndex:2];
        OfficEcatagory = [cgArray objectAtIndex:3];
    }
    
    
     CatageryButton *button;
    if (isHen) {
        CGFloat firstY = BT_SPACE_Y;
        CGFloat bigWidth = BT_WIDTH*2+BT_SPACE_X;
        [_faAndHrBt set_buttonFrame:ccr(BT_X,firstY,bigWidth , BT_WIDTH) andTitleFrame:ccr(bigWidth/2-20, 0, bigWidth/2, BT_WIDTH) andFont:[UIFont systemFontOfSize:28]];
        [_favourateBt set_buttonFrame:ccr(BT_X+bigWidth+BT_SPACE_X, firstY, bigWidth, BT_WIDTH) andTitleFrame:ccr(bigWidth/2+10, 0, bigWidth/2-10, BT_WIDTH) andFont:[UIFont systemFontOfSize:28]];
        [_officeBt set_buttonFrame:ccr(BT_X+bigWidth+BT_SPACE_X, firstY+BT_WIDTH+BT_SPACE_Y, BT_WIDTH, BT_WIDTH) andTitleFrame:ccr(0, BT_WIDTH*3/4, BT_WIDTH, BT_WIDTH/4) andFont:[UIFont systemFontOfSize:28]];
        [_allAppBt set_buttonFrame:ccr(BT_X+bigWidth+2*BT_SPACE_X+BT_WIDTH, firstY+BT_WIDTH+BT_SPACE_Y, BT_WIDTH, BT_WIDTH) andTitleFrame:ccr(0, BT_WIDTH*3/4, BT_WIDTH, BT_WIDTH/4) andFont:[UIFont systemFontOfSize:28]];
        
        [_msBt set_buttonFrame:ccr(BT_X, firstY+BT_SPACE_Y+BT_WIDTH, bigWidth, 2*BT_WIDTH+BT_SPACE_Y) andTitleFrame:ccr(0, 3, bigWidth-16, BT_WIDTH) andFont:[UIFont systemFontOfSize:28]];
        
        CGFloat w = SCREEN_WIDTH-20-TabBar_WIDTH;
        
        _exhibImageViewO.frame = CGRectMake(10, 10, w/3*2-5, 300);
        _exhibImageViewT.frame = CGRectMake(CGRectGetMaxX(_exhibImageViewO.frame)+5, 10, w/3, 150-2);
        _exhibImageViewTH.frame = CGRectMake(CGRectGetMaxX(_exhibImageViewO.frame)+5, CGRectGetMaxY(_exhibImageViewT.frame)+5, w/3, 150-3);
//        _exhibImageViewO.backgroundColor = [UIColor redColor];
//        _exhibImageViewT.backgroundColor = [UIColor blueColor];
//        _exhibImageViewTH.backgroundColor = [UIColor yellowColor];
        
        [_exhibImageViewO sd_setImageWithURL:[NSURL URLWithString:@"http://gcintranet.ap.bayer.cnb/cms"] placeholderImage:[UIImage imageNamed:@"0拜助理-0英文_03"]];
        [_exhibImageViewT sd_setImageWithURL:[NSURL URLWithString:@"http://gcintranet.ap.bayer.cnb/cms/Services/Corp_Services_China/LPC/Compliance_in_Greater_China/"] placeholderImage:[UIImage imageNamed:@"0拜助理-0英文_05"]];
        [_exhibImageViewTH sd_setImageWithURL:[NSURL URLWithString:@"http://gcintranet.ap.bayer.cnb/cms/Services/Corp_Services_China/Information_Management/IT_China/"] placeholderImage:[UIImage imageNamed:@"0拜助理-0英文_08"]];

        
        if ([UItool isChinese]==YES) {
            [_favourateBt catageryButton_setTitle:Favcatagory.chineseName and:[UIFont systemFontOfSize:36]];
            [_faAndHrBt catageryButton_setTitle:FaHcatagory.chineseName and:[UIFont systemFontOfSize:36]];
            [_officeBt catageryButton_setTitle:OfficEcatagory.chineseName and:[UIFont systemFontOfSize:28]];
            [_allAppBt catageryButton_setTitle:@"所有应用" and:[UIFont systemFontOfSize:26]];
            [_msBt catageryButton_setTitle:Mscatagory.chineseName and:[UIFont systemFontOfSize:40]];
            
        }
        else{
            [_faAndHrBt catageryButton_setTitle:FaHcatagory.englishName and:[UIFont systemFontOfSize:36]];
            [_favourateBt catageryButton_setTitle:Favcatagory.englishName and:[UIFont systemFontOfSize:36]];
            [_officeBt catageryButton_setTitle:OfficEcatagory.englishName and:[UIFont systemFontOfSize:24]];
            [_allAppBt catageryButton_setTitle:@"All Applications" and:[UIFont systemFontOfSize:24]];
            [_msBt catageryButton_setTitle:Mscatagory.englishName and:[UIFont systemFontOfSize:36]];

        }
        

        int j;
        for (int i = 0; i<5; i++) {
        
        switch (i) {
            case 0:
                j = 10000;
                [self setupButton:i tag:j];
                break;
            case 1:
                j = 1;
                [self setupButton:i tag:j];

                break;
            case 2:
                j = 4;
                [self setupButton:i tag:j];

                break;
            case 3:
                j = 2;
                [self setupButton:i tag:j];

                break;
            case 4:
                j = 3;
                [self setupButton:i tag:j];

                break;
            default:
                break;
                
                
                
                
        }
}
//=================================动态========================================================
        CGFloat newY = firstY+3*BT_WIDTH+3*BT_SPACE_Y;
        int k =0;
       
        if ([mutableArr count]!=0) {
            
            for (k=0; k<2; k++) {
                if (k<m) {
                    button = [mutableArr objectAtIndex:k];
                    button.frame = ccr(BT_X+bigWidth+BT_SPACE_X+(BT_WIDTH+BT_SPACE_X)*k, firstY+(BT_WIDTH+BT_SPACE_Y)*2, BT_WIDTH, BT_WIDTH) ;
                    CGFloat h = [button.nameLabel.text stringSizeWithFont:button.nameLabel.font size:ccs(VIEW_W(self), VIEW_H(button)) breakmode: NSLineBreakByCharWrapping].height;
                    button.nameLabel.frame = ccr(0, VIEW_H(button)-h, VIEW_W(button), h);
                    button.nameLabel.font = [UIFont systemFontOfSize:26];
                }
                
            }
            if (k>=2) {
                for (int H=0; H<h; H++) {
                    for (int lie=0; lie<l; lie++) {
                        if (k<m) {
                            button = [mutableArr objectAtIndex:k];
                            // AppCatagery *catagory = [array objectAtIndex:k+4];
                            button.frame = ccr(BT_X+(BT_WIDTH+BT_SPACE_X)*lie, newY+(BT_SPACE_Y+BT_WIDTH)*H, BT_WIDTH, BT_WIDTH);
                            CGFloat h = [button.nameLabel.text stringSizeWithFont:button.nameLabel.font size:ccs(VIEW_W(self), VIEW_H(button)) breakmode: NSLineBreakByCharWrapping].height;
                            button.nameLabel.frame = ccr(0, VIEW_H(button)-h, VIEW_W(button), h);
                            button.nameLabel.font = [UIFont systemFontOfSize:26];
                            
                            k++;
                            
                        }
                        
                        //[button sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal];
                    }
                }

            }
           
        }
            }
    else
    {
        _exhibImageViewO.frame = CGRectMake(10, 10, 450, 300);
        _exhibImageViewT.frame = CGRectMake(10, 10, 450, 300);
        _exhibImageViewTH.frame = CGRectMake(10, 10, 450, 300);

        CGFloat btWidth = SCREEN_WIDTH*0.176;
        CGFloat firstY = BT_SPACE_Y;
        CGFloat bigWidth = btWidth*2+BT_SPACE_X;
        [_faAndHrBt set_buttonFrame:ccr(BT_X,firstY,bigWidth , btWidth) andTitleFrame:ccr(bigWidth/2-20, 0, bigWidth/2, btWidth) andFont:[UIFont systemFontOfSize:26]];
       
        [_favourateBt set_buttonFrame:ccr(BT_X+bigWidth+BT_SPACE_X, firstY, bigWidth, btWidth) andTitleFrame:ccr(bigWidth/2+10, 0, bigWidth/2-10, btWidth) andFont:[UIFont systemFontOfSize:28]];
        [_officeBt set_buttonFrame:ccr(BT_X+bigWidth+BT_SPACE_X, firstY+btWidth+BT_SPACE_Y, btWidth, btWidth) andTitleFrame:ccr(0, btWidth*3/4, btWidth, btWidth/4) andFont:[UIFont systemFontOfSize:28]];
        [_allAppBt set_buttonFrame:ccr(BT_X+bigWidth+2*BT_SPACE_X+btWidth, firstY+btWidth+BT_SPACE_Y, btWidth, btWidth) andTitleFrame:ccr(0, btWidth*3/4, btWidth, btWidth/4) andFont:[UIFont systemFontOfSize:28]];
        
        [_msBt set_buttonFrame:ccr(BT_X, firstY+BT_SPACE_Y+btWidth, bigWidth, 2*btWidth+BT_SPACE_Y) andTitleFrame:ccr(0, 3,bigWidth-16, btWidth) andFont:[UIFont systemFontOfSize:28]];

        if ([UItool isChinese]==YES) {
            [_favourateBt catageryButton_setTitle:Favcatagory.chineseName and:[UIFont systemFontOfSize:28]];
            [_faAndHrBt catageryButton_setTitle:FaHcatagory.chineseName and:[UIFont systemFontOfSize:28]];
            [_officeBt catageryButton_setTitle:OfficEcatagory.chineseName and:[UIFont systemFontOfSize:22]];
            [_allAppBt catageryButton_setTitle:@"所有应用" and:[UIFont systemFontOfSize:20]];
            [_msBt catageryButton_setTitle:Mscatagory.chineseName and:[UIFont systemFontOfSize:30]];
            
            }
        else{
            [_faAndHrBt catageryButton_setTitle:FaHcatagory.englishName and:[UIFont systemFontOfSize:28]];
            [_favourateBt catageryButton_setTitle:Favcatagory.englishName and:[UIFont systemFontOfSize:28]];
            [_officeBt catageryButton_setTitle:OfficEcatagory.englishName and:[UIFont systemFontOfSize:22]];
            [_allAppBt catageryButton_setTitle:@"All Applications" and:[UIFont systemFontOfSize:18]];
            [_msBt catageryButton_setTitle:Mscatagory.englishName and:[UIFont systemFontOfSize:30]];

        }

//========================================动态========================================================
        CGFloat newShuY = firstY +(btWidth+BT_SPACE_Y)*3;
        int k =0;
        
        if ([mutableArr count]!=0) {
            
            for (k=0; k<2; k++) {
                if (k<m) {
                    button = [mutableArr objectAtIndex:k];
                    button.frame = ccr(BT_X+bigWidth+BT_SPACE_X+(btWidth+BT_SPACE_X)*k, firstY+(btWidth+BT_SPACE_Y)*2, btWidth, btWidth) ;
                    CGFloat h = [button.nameLabel.text stringSizeWithFont:button.nameLabel.font size:ccs(VIEW_W(self), VIEW_H(button)) breakmode: NSLineBreakByCharWrapping].height;
                    button.nameLabel.frame = ccr(0, VIEW_H(button)-h, VIEW_W(button), h);
                    button.nameLabel.font = [UIFont systemFontOfSize:20];

                }
               
            }
            if (k>=2) {
                for (int H=0; H<h; H++) {
                    for (int lie=0; lie<l; lie++) {
                        if (k<m) {
                            button = [mutableArr objectAtIndex:k];
                            //  AppCatagery *catagory = [array objectAtIndex:k+4];
                            button.frame = ccr(BT_X+(btWidth+BT_SPACE_X)*lie, newShuY+(BT_SPACE_Y+btWidth)*H, btWidth, btWidth);
                            CGFloat h = [button.nameLabel.text stringSizeWithFont:button.nameLabel.font size:ccs(VIEW_W(self), VIEW_H(button)) breakmode: NSLineBreakByCharWrapping].height;
                            button.nameLabel.frame = ccr(0, VIEW_H(button)-h, VIEW_W(button), h);
                            button.nameLabel.font = [UIFont systemFontOfSize:20];
                            k++;
                        }
                        
                    }
                }
            }
            
        }

    }
        
}
- (void)setupButton:(int)j tag :(int)k{
    AppCatagery *FaHcatagory;
    AppCatagery *Mscatagory;
    AppCatagery *OfficEcatagory;
    AppCatagery * Favcatagory;
    NSArray *cgArray = [LocalSqlManger selectAllCatagery];
    if ([cgArray count]!=0) {
        Favcatagory = [cgArray objectAtIndex:1];
        NSLog(@"%@=====ssssssssss===",Favcatagory.englishName);
        FaHcatagory = [cgArray objectAtIndex:0];
        Mscatagory = [cgArray objectAtIndex:2];
        OfficEcatagory = [cgArray objectAtIndex:3];
    }

    CustomButton *cus = (CustomButton *)[self.contentView viewWithTag:k];
    if ([UItool isChinese]==YES) {
        if (FaHcatagory.chineseName) {
            NSArray *CN =@[@"所有应用",FaHcatagory.chineseName,OfficEcatagory.chineseName,Favcatagory.chineseName,Mscatagory.chineseName];
            cus.TitleLabel.text = CN[j];
            
        }
        
    }else{
        if (FaHcatagory.englishName) {
            NSArray *EN =@[@"All Applications",FaHcatagory.englishName,OfficEcatagory.englishName,Favcatagory.englishName,Mscatagory.englishName];
            cus.TitleLabel.text = EN[j];
            
        }
        
    }
    
}
-(int)getNum:(int)num
{
    if (num%4!=0&&num>4) {
        while (num%4!=0) {
            num++;
        }
    }
    
    return num/4;
}

-(void)catageryButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(goToTheCategery:)]) {
        [self.delegate goToTheCategery:sender];
    }
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
