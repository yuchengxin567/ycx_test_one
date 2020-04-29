//
//  ycx_TableViewCell.m
//  ycx_test_one
//
//  Created by YCX on 2020/4/14.
//  Copyright © 2020 YCX. All rights reserved.
//

#import "ycx_TableViewCell.h"
@interface ycx_TableViewCell()
@end
@implementation ycx_TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setVm:(ycx_ViewModel *)vm{
    _vm = vm;
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel * titlelb = [[UILabel alloc]init];
    titlelb.numberOfLines = 0;
    titlelb.font = [UIFont systemFontOfSize:20];
    titlelb.text = _vm.cellModel.title;
    [self addSubview:titlelb];
           
    UILabel * timelb = [[UILabel alloc]init];
    timelb.textAlignment = NSTextAlignmentRight;
    timelb.font = [UIFont systemFontOfSize:17];
    timelb.textColor = [UIColor lightGrayColor];
    timelb.text = _vm.cellModel.date;
    [self addSubview:timelb];
    
    if ([_vm.cellModel.doc_type isEqualToString:@"0"]) {
        
        titlelb.frame = CGRectMake(20, 10, SCREEN_WIDTH-40, _vm.titleHeight);
        timelb.frame = CGRectMake(20, CGRectGetMaxY(titlelb.frame)+10, SCREEN_WIDTH-40, 20);
        
    }else if ([_vm.cellModel.doc_type isEqualToString:@"1"]){
        
        UIImageView * imagev = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, IMAGE_WIDE, IMAGE_HEIGHT)];
        [imagev sd_setImageWithURL:[NSURL URLWithString:_vm.cellModel.photo]];
        [self addSubview:imagev];
        
        titlelb.frame = CGRectMake(CGRectGetMaxX(imagev.frame) +10,15 , SCREEN_WIDTH - CGRectGetMaxX(imagev.frame)-30, IMAGE_HEIGHT-30);
        
        timelb.frame = CGRectMake(CGRectGetMaxX(imagev.frame) +10,CGRectGetMaxY(imagev.frame)-20 , SCREEN_WIDTH - CGRectGetMaxX(imagev.frame)-30, 20);
        
    }else{
        titlelb.frame = CGRectMake(20, 10, SCREEN_WIDTH-40, _vm.titleHeight);
        
        NSArray * imagearr = @[_vm.cellModel.photo,_vm.cellModel.photo2,_vm.cellModel.photo3];
        
        for (int i=0; i<imagearr.count; i++) {
            UIImageView * imagev = [[UIImageView alloc]initWithFrame:CGRectMake(20+(IMAGE_WIDE+10)*i, _vm.titleHeight+20, IMAGE_WIDE, IMAGE_HEIGHT)];
            //去掉字符串空格
            [imagev sd_setImageWithURL:[NSURL URLWithString:[imagearr[i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"猫2@3x.png"]];
            [self addSubview:imagev];
        }
        timelb.frame = CGRectMake(20, _vm.titleHeight+20+IMAGE_HEIGHT+10, SCREEN_WIDTH-40, 20);
    }
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, _vm.cellHeight-1, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
