//
//  ycx_ViewModel.h
//  ycx_test_one
//
//  Created by YCX on 2020/4/14.
//  Copyright © 2020 YCX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ycx_model.h"
NS_ASSUME_NONNULL_BEGIN

@interface ycx_ViewModel : NSObject
//数据请求
@property (strong,nonatomic,readonly) RACCommand * requestCommand;

//文本高度
@property (assign,nonatomic) CGFloat titleHeight;
//cell高度
@property (assign,nonatomic) CGFloat cellHeight;
//cellmodel
@property (strong,nonatomic) ycx_model * cellModel;

+(instancetype)CellViewModel:(ycx_model *)model;
-(instancetype)initWithCellModel:(ycx_model *)model;


-(void)setRequestPreparation;
@end
NS_ASSUME_NONNULL_END
