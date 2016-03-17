//
//  MessageTableViewCell.m
//  BayerProtal
//
//  Created by admin on 14-10-10.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell
@synthesize timeLabel;
@synthesize desLabel;
@synthesize detailButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin;
        detailButton = [[UIButton alloc]initWithFrame:CGRectZero];
        detailButton.tag = 5;
        detailButton.titleLabel.font = [UIFont systemFontOfSize:13];
        detailButton.layer.cornerRadius = 2;
        detailButton.layer.masksToBounds = YES;
        detailButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:145/255.0 blue:195/255.0 alpha:1.0];
        [self.contentView addSubview:detailButton];
        [detailButton addTarget:self action:@selector(OpenUrl) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:desLabel];
        [self addSubview:timeLabel];
    }
    return self;
}
- (void)OpenUrl {
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://sp-coll-bhc.ap.bayer.cnb/sites/250003/compliance/SitePages/OrgChart.aspx"]];
}
-(void)initWithDescrption:(BYinformation *)info;
{
    //ccr(self.frame.size.width-220, 30, 200, 50)
    self.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    desLabel.text = info.information;
    timeLabel.text = info.createTime;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    // desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.numberOfLines = 0;
    NSDictionary *attributes = @{NSFontAttributeName:desLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [desLabel.text boundingRectWithSize:CGSizeMake(2*VIEW_WIDTH_HEN/3-50, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    desLabel.frame = ccr(50, 30, 2*VIEW_WIDTH_HEN/3-40, size.height+10);
    timeLabel.frame = ccr(self.frame.size.width-240, 35, 200, 50);

    if (info.isRead==[NSNumber numberWithInt:1]) {//Helvetica
        [timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [desLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        desLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        timeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    }
    else{
         [timeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
         [desLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
         desLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
         timeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    
   
}
-(void)initWithDescrptions:(NSString *)info;
{
    //ccr(self.frame.size.width-220, 30, 200, 50)
    self.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    desLabel.text = info;
    //timeLabel.text = info.createTime;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    // desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.numberOfLines = 0;
    NSDictionary *attributes = @{NSFontAttributeName:desLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [desLabel.text boundingRectWithSize:CGSizeMake( SCREEN_WIDTH-TabBar_WIDTH-90, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    desLabel.frame = ccr(10, 30, SCREEN_WIDTH-TabBar_WIDTH-90, size.height+10);
    timeLabel.frame = ccr(self.frame.size.width-240, 35, 200, 50);
    
//    if (info.isRead==[NSNumber numberWithInt:1]) {//Helvetica
//        [timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
//        [desLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
//        desLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
//        timeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
//    }
//    else{
//        [timeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
//        [desLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
//        desLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//        timeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    }
    
    [detailButton setFrame:CGRectMake(CGRectGetMaxX(desLabel.frame), size.height/2+5, 60, 40)];
    [detailButton setTitle:@"联系合规" forState:UIControlStateNormal];
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
