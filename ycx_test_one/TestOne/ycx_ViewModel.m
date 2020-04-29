//
//  ycx_ViewModel.m
//  ycx_test_one
//
//  Created by YCX on 2020/4/14.
//  Copyright © 2020 YCX. All rights reserved.
//

#define Url @"http://console.juyun.tv/tools/list.json"

#import "ycx_ViewModel.h"
#import "ycx_model.h"

@implementation ycx_ViewModel
-(instancetype)initWithCellModel:(ycx_model *)model{
    if (self = [super init]) {
        self.cellModel = model;
        //计算高度
        [self CalculatedHeight];
    }
    return  self;
}

+(instancetype)CellViewModel:(ycx_model *)model{
    return [[self alloc] initWithCellModel:model];
}

-(void)CalculatedHeight{
    //计算高度
    CGRect rect = [self.cellModel.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    
    self.titleHeight = rect.size.height;
    //上下间距10
    if ([self.cellModel.doc_type isEqualToString:@"0"]) {
        self.cellHeight = rect.size.height + 50;
    }else if ([self.cellModel.doc_type isEqualToString:@"1"]){
        self.cellHeight = IMAGE_HEIGHT + 20;
    }else{
        self.cellHeight = rect.size.height + 60 + IMAGE_HEIGHT;
    }
}


//数据请求
-(void)setRequestPreparation{
    _requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            //拿到参数 input    进行请求
        AFHTTPSessionManager *  networking =   [AFHTTPSessionManager manager];
        networking.requestSerializer = [AFHTTPRequestSerializer serializer];
        networking.responseSerializer = [AFJSONResponseSerializer serializer];
       //设置请求时间
        networking.requestSerializer.timeoutInterval = 10.0f;
       //允许使用蜂窝网络
        networking.requestSerializer.allowsCellularAccess = YES;
         //添加多种链接的后缀支持
        networking.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/javascript",@"text/plain",@"text/html", nil];
                    //需要添加菊花
        [networking GET:Url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                       
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
             //判断是否请求成功
             if (responseObject[@"list_slide"] && responseObject[@"list"]) {
                 NSArray * headarr = responseObject[@"list_slide"];
                 NSArray * dataarr = responseObject[@"list"];
                 //头部数组
                 headarr =  [[headarr.rac_sequence map:^id _Nullable(id  _Nullable value) {
                     return [ycx_model initWithDic:value];
                 }] array];
                 
                 //cell数组
                 dataarr =  [[dataarr.rac_sequence map:^id _Nullable(id  _Nullable value) {
                     return [ycx_ViewModel CellViewModel:[ycx_model initWithDic:value]];
                 }] array];
                 
                 [subscriber sendNext:@[headarr,dataarr]];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
            }];
            
            return nil;
        }];
        return signal;
    }];
}
@end
