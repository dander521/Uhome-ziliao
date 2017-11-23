//
//  MCUserDefinedLotteryCategoriesCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCUserDefinedLotteryCategoriesCollectionViewCell.h"

@interface MCUserDefinedHadSelectedCZCollectionViewCell ()

@property (nonatomic,strong)UIImageView * imageV;
@property (nonatomic,strong)UILabel *lab_title;

@end

@implementation MCUserDefinedHadSelectedCZCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}
-(void)setDataSource:(MCUserDefinedLotteryCategoriesModel *)dataSource{
    _dataSource=dataSource;
    _lab_title.text =dataSource.name;
}

-(void)initView{
    
    _lab_title =[[UILabel alloc]initWithFrame:CGRectZero];
    _lab_title.font=[UIFont systemFontOfSize:10];
    _lab_title.textColor=RGB(46, 46, 46);
    self.backgroundColor=RGB(246, 246, 246);
//    self.layer.borderColor = RGB(220, 220, 220).CGColor;
//    self.layer.borderWidth = 0.5;
    _lab_title.text =@"加载中...";
    _lab_title.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_lab_title];
    [_lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _imageV=[[UIImageView alloc]init];
    [self addSubview:_imageV];
    _imageV.image=[UIImage imageNamed:@"UserDefinedCZ-"];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-2);
        make.top.equalTo(self.mas_top).offset(2);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    
}
- (void)setSelected:(BOOL)selected{
}


@end


@interface MCUserDefinedLotteryCategoriesCollectionViewCell ()

@property (nonatomic,strong)UILabel *lab_title;
@property (nonatomic,strong)UIImageView * imageV;

@end

@implementation MCUserDefinedLotteryCategoriesCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}
-(void)setDataSource:(MCUserDefinedLotteryCategoriesModel *)dataSource{
    
    _dataSource=dataSource;
    _lab_title.text =dataSource.name;
     [self setCellSelected:dataSource.isSelected];
    
}

-(void)initView{
    
    _lab_title =[[UILabel alloc]initWithFrame:CGRectZero];
    _lab_title.font=[UIFont systemFontOfSize:10];
    
    _lab_title.textColor=RGB(46,46,46);
    self.backgroundColor=RGB(246, 246, 246);
//    self.layer.borderColor = RGB(220, 220, 220).CGColor;
//    self.layer.borderWidth = 0.5;

    _lab_title.text =@"加载中...";
    _lab_title.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_lab_title];
    [_lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _imageV=[[UIImageView alloc]init];
    [self addSubview:_imageV];
    _imageV.image=[UIImage imageNamed:@"UserDefinedCZ-"];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-2);
        make.top.equalTo(self.mas_top).offset(2);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    
    
}
- (void)setSelected:(BOOL)selected{
   
    
   
}

-(void)setCellSelected:(BOOL)selected{
    if (selected) {
        _imageV.image=[UIImage imageNamed:@"UserDefinedCZ+no"];
        
    }else{
        _imageV.image=[UIImage imageNamed:@"UserDefinedCZ+"];
        
    }
}

@end





































