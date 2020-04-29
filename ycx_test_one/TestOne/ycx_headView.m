//
//  ycx_headView.m
//  ycx_test_one
//
//  Created by YCX on 2020/4/14.
//  Copyright © 2020 YCX. All rights reserved.
//

#import "ycx_headView.h"
#import "YCX_PageControl.h"
#import "ycx_model.h"
@interface ycx_headView()<UIScrollViewDelegate>
{
    dispatch_source_t  timer;
}
@property (strong,nonatomic) UIScrollView * scrollv;
@property (strong,nonatomic) YCX_PageControl * page;
@property (strong,nonatomic) UILabel * titlelb;
@property (strong,nonatomic) NSArray * dataArr;
@end
@implementation ycx_headView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _scrollv = [[UIScrollView alloc]init];
        _scrollv.showsVerticalScrollIndicator = NO;
        _scrollv.showsHorizontalScrollIndicator = NO;
        _scrollv.pagingEnabled = YES;
        _scrollv.delegate = self;
        [self addSubview:_scrollv];
        
        _page = [[YCX_PageControl alloc]init];
        _page.currentPageIndicatorTintColor = [UIColor blueColor];
        _page.pageIndicatorTintColor = [UIColor whiteColor];
        
        [self addSubview:_page];
        
        _titlelb = [[UILabel alloc]init];
        _titlelb.font = [UIFont systemFontOfSize:20];
        _titlelb.textColor = [UIColor whiteColor];
        [self addSubview:_titlelb];
    }
    return self;
}

-(void)setViewAttribute:(NSArray *)arr{
    _dataArr = arr;
    _scrollv.frame = self.bounds;
    _scrollv.contentSize = CGSizeMake(SCREEN_WIDTH * (arr.count+1), self.frame.size.height);
    
    for (int i= 0;i<=arr.count;i++) {
        ycx_model * model;
        if (i==arr.count) {
            model = arr[0];
        }else{
            model = arr[i];
        }
        UIImageView * imagev = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.frame.size.height)];
        [imagev sd_setImageWithURL:[NSURL URLWithString:model.photo]];
        [_scrollv addSubview:imagev];
        if (i==0) {
            _titlelb.text = model.title;
        }
    }
    
    //page 宽度
    CGFloat  pagewide = (arr.count*2-1)*8;
    
    _titlelb.frame = CGRectMake(20, self.frame.size.height-40, SCREEN_WIDTH-pagewide-50, 30);
    
    _page.numberOfPages = arr.count;
    _page.frame = CGRectMake(CGRectGetMaxX(_titlelb.frame)+10, self.frame.size.height-40, pagewide, 30);
    NSLog(@"%@",_page);
    [self beginTimer];
}

//轮播
-(void)beginTimer{
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        dispatch_async(dispatch_get_main_queue(), ^{
             [UIView animateWithDuration:0.5 animations:^{
                 self.scrollv.contentOffset = CGPointMake(SCREEN_WIDTH+self.scrollv.contentOffset.x, 0);
             } completion:^(BOOL finished) {
                [self pageAndTitleFollowScrollv];
             }];
        });
    }];
//    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//
//      dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC, 1.0 * NSEC_PER_SEC);
//
//      dispatch_source_set_event_handler(timer, ^{
//              dispatch_async(dispatch_get_main_queue(), ^{
//                  [UIView animateWithDuration:0.5 animations:^{
//                      self.scrollv.contentOffset = CGPointMake(SCREEN_WIDTH+self.scrollv.contentOffset.x, 0);
//                  } completion:^(BOOL finished) {
//                     [self pageAndTitleFollowScrollv];
//                  }];
//              });
//      });
//      dispatch_resume(timer);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self pageAndTitleFollowScrollv];
}

-(void)pageAndTitleFollowScrollv{
    if (self.scrollv.contentOffset.x/SCREEN_WIDTH == self.dataArr.count) {
            self.scrollv.contentOffset = CGPointMake(0, 0);
        }
        NSInteger index = self.scrollv.contentOffset.x / SCREEN_WIDTH;
        self.page.currentPage = index;
        self.titlelb.text = ((ycx_model *)self.dataArr[index]).title;
}
@end
