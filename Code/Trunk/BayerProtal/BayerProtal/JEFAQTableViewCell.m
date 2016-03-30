//
//  JEFAQTableViewCell.m
//  BayerProtal
//
//  Created by 尹现伟 on 14/10/27.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "JEFAQTableViewCell.h"
#import "UIWebView+SearchWebView.h"
@interface JEFAQTableViewCell()

@end

@implementation JEFAQTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWebView];
    }
    return self;
}
- (void)initWebView{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectZero];
//    self.webView.userInteractionEnabled = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque=NO;
    self.webView.scrollView.bounces = NO;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:self.webView];
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setHTMLdata:(NSString *)HTMLdata{
    if (_HTMLdata != HTMLdata) {
        _HTMLdata = HTMLdata;
    }
}

- (void)loadData:(id)data{
    if ([data isKindOfClass:[NSString class]]) {
        NSString *strData = (NSString *)data;
//        NSString *HTMLData=[NSString stringWithFormat:@"<div id='foo' style='color:#EEEEEE' >%@</div>",strData];
         [self.webView loadHTMLString:strData baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]]];
        self.webView.frame = ccr(0, 0, self.bounds.size.width, 100);
        //[self.webView removeAllHighlights];
//       NSInteger inty= [self.webView highlightAllOccurencesOfString:@"出国"];
       // NSLog(<#fmt, ...#>)
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
