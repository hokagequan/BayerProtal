//
//  BYguideView.m
//  BayerProtal
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 DNE Technology Co.,Ltd. All rights reserved.
//

#import "BYguideView.h"

@implementation BYguideView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andArray:(NSArray *)array
{
    self = [[BYguideView alloc] initWithFrame:frame];
    if (self) {
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        _page = [[UIPageControl alloc] initWithFrame:ccr(self.frame.size.width-50, self.frame.size.height-100, 100, 30)];
        _page.numberOfPages = [array count];
        [self addSubview:_page];
        
        for (int i = 0; i<[array count]; i++) {
            UIImageView *imagView = [[UIImageView alloc] initWithFrame:self.frame];
            imagView.image = [UIImage imageNamed:[array objectAtIndex:i]];
            [self addSubview:imagView];
        }
        [self setContentSize:ccs([array count]*SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _page.currentPage = self.contentOffset.x/SCREEN_WIDTH;
}

@end