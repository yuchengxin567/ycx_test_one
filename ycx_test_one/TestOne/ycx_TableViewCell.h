//
//  ycx_TableViewCell.h
//  ycx_test_one
//
//  Created by YCX on 2020/4/14.
//  Copyright © 2020 YCX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ycx_ViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface ycx_TableViewCell : UITableViewCell
@property (strong,nonatomic) ycx_ViewModel * vm;

@end

NS_ASSUME_NONNULL_END
