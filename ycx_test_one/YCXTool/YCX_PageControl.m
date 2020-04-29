//
//  YCX_PageControl.m
//  ycx_test_one
//
//  Created by YCX on 2020/4/14.
//  Copyright © 2020 YCX. All rights reserved.
//
#define dotW 8
#define margin 8

#import "YCX_PageControl.h"

@implementation YCX_PageControl

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //计算圆点间距
    CGFloat marginX = margin + 8;
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotW)];
    }
}

- (void)setCurrentPage:(NSInteger)page {
        [super setCurrentPage:page];
    
        for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
            UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
            CGSize size;
            size.height = 8;
            size.width = 8;
            [subview setFrame:CGRectMake(subview.frame.origin.x,subview.frame.origin.y,size.width,size.height)];
        }
}
@end
