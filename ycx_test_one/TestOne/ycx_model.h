//
//  ycx_model.h
//  ycx_test_one
//
//  Created by YCX on 2020/4/14.
//  Copyright © 2020 YCX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ycx_model : NSObject
@property (copy,nonatomic) NSString * contentID;
@property (copy,nonatomic) NSString * title;
@property (copy,nonatomic) NSString * photo;
@property (copy,nonatomic) NSString * photo2;
@property (copy,nonatomic) NSString * photo3;
@property (copy,nonatomic) NSString * contentUrl;
@property (copy,nonatomic) NSString * doc_type;
@property (copy,nonatomic) NSString * date;

+(instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
