//
//  MCHomePageLotteryCategoriesCollectionViewCell.m
//  Uhome
//
//  Created by miaocai on 2017/5/27.
//  Copyright © 2017年 menhao. All rights reserved.
//

#import "MCHomePageLotteryCategoriesCollectionViewCell.h"
#import "MCUserDefinedLotteryCategoriesModel.h"

@interface MCHomePageLotteryCategoriesCollectionViewCell()
    
//菜种图片
@property (nonatomic,strong)UIImageView * samllImageV;
    
//菜种图片
@property (nonatomic, strong)  UIImageView *logoImageV;

//名称
@property (nonatomic, strong)  UILabel *nameLabel;

@end

@implementation MCHomePageLotteryCategoriesCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.backgroundColor = [UIColor whiteColor];
//    self.backgroundColor = RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
    
    CGFloat W= (G_SCREENWIDTH-2)/3.0;
    CGFloat Top=(W-50-10-20)/2.0;
    
    _logoImageV=[[UIImageView alloc]init];
    [self addSubview:_logoImageV];
    [_logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(Top);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    _nameLabel=[[UILabel alloc]init];
    _nameLabel.textColor = [UIColor darkGrayColor];
    _nameLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_logoImageV.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(50);
    }];
    
    _samllImageV=[[UIImageView alloc]init];
    [self addSubview:_samllImageV];
    [_samllImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
}

- (void)awakeFromNib {
    
    
//    self.backgroundColor = RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
    
    
    [super awakeFromNib];
    self.iconImageV.image = [UIImage imageNamed:@"fc_sd.png"];
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.layer.cornerRadius = 6.0f;
    self.clipsToBounds = YES;
}

    
-(void)setDataSource:(MCUserDefinedLotteryCategoriesModel *)dataSource{
    _dataSource=dataSource;
    if (dataSource.name) {
        self.nameLabel.text = dataSource.name;
        self.backgroundColor = [UIColor whiteColor];
    }
    if ([dataSource.isShowType intValue]==1) {
        _samllImageV.image=[UIImage imageNamed:@"hot"];
    }else if ([dataSource.isShowType intValue]==2){
        _samllImageV.image=[UIImage imageNamed:@"new"];
    }else{
        _samllImageV.image=nil;
    }
    
    _logoImageV.image = [UIImage imageNamed:dataSource.logo];
    self.iconImageV.backgroundColor = [UIColor clearColor];
    self.iconImageV.image = [UIImage imageNamed:dataSource.logo];
}

@end
