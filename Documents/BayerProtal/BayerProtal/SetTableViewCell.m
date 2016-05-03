//
//  SetTableViewCell.m
//  BayerProtal
//
//  Created by admin on 14-10-19.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "SetTableViewCell.h"

@implementation SetTableViewCell
{
    UILabel *label;
    NSString *setKey;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      label = [[UILabel alloc] initWithFrame:ccr(15, 0, self.frame.size.width/2+100, 250/3.f)];
        [self.contentView addSubview:label];

    }
    return self;
}

-(void)initFirstTypeWith:(NSArray *)array
{
    // label.frame = ccr(15, self.frame.size.height/2-20, self.frame.size.width/2+100, 80);
    if ([UItool isChinese]==YES) {
        label.text = [array objectAtIndex:0];
    }
    else{
        label.text = [array objectAtIndex:1];
    }
//    CGFloat h = [label.text stringSizeWithFont:label.font size:ccs(VIEW_W(label), 10000) breakmode: NSLineBreakByWordWrapping].height;
//    label.frame = ccr(15, self.frame.size.height/2-h/2, self.frame.size.width/2+100, h);
   
    
//   UILabel *luanLabel = [[UILabel alloc] initWithFrame:ccr(self.frame.size.width+300, 30, 100, 100)];
//   luanLabel.text = @"简体中文";
//   [self addSubview:luanLabel];
    
}



-(void)initSecondTypeWith:(NSArray *)array andKey:(NSString *)key
{
    setKey=key;
    //label.frame = ccr(15, self.frame.size.height/2-20, self.frame.size.width/2+100, 80);
    if ([UItool isChinese]==YES) {
        label.text = [array objectAtIndex:0];
    }
    else{
        label.text = [array objectAtIndex:1];
    }
    
//    CGFloat h = [label.text stringSizeWithFont:label.font size:ccs(VIEW_W(label), 10000) breakmode: NSLineBreakByWordWrapping].height;
//    label.frame = ccr(15, self.frame.size.height/2-h/2, self.frame.size.width/2+100, h);
    
    UISwitch * openSwitch = [[UISwitch alloc] initWithFrame:ccr(self.frame.size.width-70, 30, 150, 150)];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:key]isEqualToString:@"on"]) {
        [openSwitch setOn:YES];
    }
    else  if([[[NSUserDefaults standardUserDefaults]objectForKey:key]isEqualToString:@"off"])
    {
        [openSwitch setOn:NO];
    }
    
    openSwitch.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
    [openSwitch addTarget:self action:@selector(openSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:openSwitch];
    

}



-(void)openSwitchAction:(id)sender
{
    UISwitch *mySwitch = sender;
    BOOL isSwitchOn = [mySwitch isOn];
    if (isSwitchOn) {
        NSLog(@"======kai=====");
        [[NSUserDefaults standardUserDefaults]setObject:@"on" forKey:setKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }
    else{
        NSLog(@"======guan======");
        [[NSUserDefaults standardUserDefaults]setObject:@"off" forKey:setKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
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
