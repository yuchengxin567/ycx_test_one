//
//  ycx_model.m
//  ycx_test_one
//
//  Created by YCX on 2020/4/14.
//  Copyright © 2020 YCX. All rights reserved.
//

#import "ycx_model.h"

@implementation ycx_model
+(instancetype)initWithDic:(NSDictionary *)dic{
    ycx_model * model = [[ycx_model alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

/*
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
 
}
 */
@end
