//
//  MCRechargeCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/7/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import "MCRechargeCollectionViewCell.h"

@interface MCRechargeCollectionViewCell ()

@property(nonatomic,strong)UIImageView * selectedImgV;

@end

@implementation MCRechargeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)setDataSource:(MCPaymentModel*)dataSource{
    _dataSource=dataSource;
    _titleLab.text =dataSource.PayName;
    if (dataSource.isSelected) {
        if ([_dataSource.logoType isEqualToString:@"1"]) {
            _selectedImgV.image=[UIImage imageNamed:@"selected_zhifubao"];
        }else if ([_dataSource.logoType isEqualToString:@"2"]){
            _selectedImgV.image=[UIImage imageNamed:@"selected_weixin"];
        }else if ([_dataSource.logoType isEqualToString:@"3"]){
            _selectedImgV.image=[UIImage imageNamed:@"selected_qq"];
        }else if ([_dataSource.logoType isEqualToString:@"4"]){
            _selectedImgV.image=[UIImage imageNamed:@"selected_yhk"];
        }else if ([_dataSource.logoType isEqualToString:@"5"]){
            _selectedImgV.image=[UIImage imageNamed:@"selected_kuaijie"];
        }
    }else{
        if ([dataSource.logoType isEqualToString:@"1"]) {
            _selectedImgV.image=[UIImage imageNamed:@"unselected_zhifubao"];
        }else if ([dataSource.logoType isEqualToString:@"2"]){
            _selectedImgV.image=[UIImage imageNamed:@"unselected_weixin"];
        }else if ([dataSource.logoType isEqualToString:@"3"]){
            _selectedImgV.image=[UIImage imageNamed:@"unselected_qq"];
        }else if ([dataSource.logoType isEqualToString:@"4"]){
            _selectedImgV.image=[UIImage imageNamed:@"unselected_yhk"];
        }else if ([dataSource.logoType isEqualToString:@"5"]){
            _selectedImgV.image=[UIImage imageNamed:@"unselected_kuaijie"];
        }
    }
    
    
//    alipay
//    tenpay
//    cmb
//    icbc
}

-(void)initView{
    
    
    self.backgroundColor = [UIColor  clearColor];
    
    _selectedImgV=[[UIImageView alloc]init];
    _selectedImgV.backgroundColor=[UIColor clearColor];
    [self addSubview:_selectedImgV];
    _selectedImgV.image=[UIImage imageNamed:@""];
    [_selectedImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(5);

    }];
    
    
    _titleLab =[[UILabel alloc]initWithFrame:CGRectZero];
    _titleLab.font=[UIFont systemFontOfSize:10];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(_selectedImgV.mas_bottom).offset(5);
    }];
    
}

- (void)setSelected:(BOOL)selected{
//    if (selected) {
//        
//        if ([_dataSource.logoType isEqualToString:@"1"]) {
//            _selectedImgV.image=[UIImage imageNamed:@"selected_zhifubao"];
//        }else if ([_dataSource.logoType isEqualToString:@"2"]){
//            _selectedImgV.image=[UIImage imageNamed:@"selected_weixin"];
//        }else if ([_dataSource.logoType isEqualToString:@"3"]){
//            _selectedImgV.image=[UIImage imageNamed:@"selected_qq"];
//        }else if ([_dataSource.logoType isEqualToString:@"4"]){
//            _selectedImgV.image=[UIImage imageNamed:@"selected_yhk"];
//        }else if ([_dataSource.logoType isEqualToString:@"5"]){
//            _selectedImgV.image=[UIImage imageNamed:@"selected_kuaijie"];
//        }
//
//    }else{
//        
//        if ([_dataSource.logoType isEqualToString:@"1"]) {
//            _selectedImgV.image=[UIImage imageNamed:@"unselected_zhifubao"];
//        }else if ([_dataSource.logoType isEqualToString:@"2"]){
//            _selectedImgV.image=[UIImage imageNamed:@"unselected_weixin"];
//        }else if ([_dataSource.logoType isEqualToString:@"3"]){
//            _selectedImgV.image=[UIImage imageNamed:@"unselected_qq"];
//        }else if ([_dataSource.logoType isEqualToString:@"4"]){
//            _selectedImgV.image=[UIImage imageNamed:@"unselected_yhk"];
//        }else if ([_dataSource.logoType isEqualToString:@"5"]){
//            _selectedImgV.image=[UIImage imageNamed:@"unselected_kuaijie"];
//        }
//        
//    }
}


@end







