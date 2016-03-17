//
//  UIWebView+SearchWebView.h
//  BayerProtal
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (SearchWebView)

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str;
- (void)removeAllHighlights;

@end
